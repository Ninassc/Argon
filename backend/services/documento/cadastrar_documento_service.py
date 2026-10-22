from models import AtivoMinerario, Documento, db
from .storage_service import StorageService
from pathlib import Path
from flask import current_app


class CadastrarDocumentoService:
    def executar(self, id_usuario, id_ativo, arquivo):

        ativo = AtivoMinerario.buscar_por_id(id_ativo)

        if ativo is None:
            raise ValueError("Ativo minerário não encontrado.")

        if ativo.id_usuario != id_usuario:
            raise PermissionError(
                "Você não tem permissão para anexar documentos a este ativo."
            )

        if arquivo is None or not arquivo.filename:
            raise ValueError("Nenhum arquivo foi selecionado.")

        tipos_permitidos = {
            ".pdf": "application/pdf",
            ".jpg": "image/jpeg",
            ".jpeg": "image/jpeg",
            ".png": "image/png",
            ".docx": "application/vnd.openxmlformats-officedocument.wordprocessingml.document",
        }

        extensao = Path(arquivo.filename).suffix.lower()

        if extensao not in tipos_permitidos:
            raise ValueError("Tipo de arquivo não permitido.")

        arquivo.stream.seek(0, 2)
        tamanho = arquivo.stream.tell()
        arquivo.stream.seek(0)

        if tamanho == 0:
            raise ValueError("O arquivo está vazio.")

        if tamanho > 10 * 1024 * 1024:
            raise ValueError("O arquivo deve ter no máximo 10 MB.")

        assinatura = arquivo.stream.read(8)

        arquivo.stream.seek(0)

        assinaturas = {
            ".pdf": assinatura.startswith(b"%PDF-"),
            ".jpg": assinatura.startswith(b"\xff\xd8\xff"),
            ".jpeg": assinatura.startswith(b"\xff\xd8\xff"),
            ".png": assinatura.startswith(b"\x89PNG\r\n\x1a\n"),
            ".docx": assinatura.startswith(b"PK\x03\x04"),
        }

        if not assinaturas[extensao]:
            raise ValueError("O conteúdo não corresponde ao formato informado.")

        tipo_arquivo = tipos_permitidos[extensao]

        storage = StorageService()
        caminho = storage.upload(arquivo, id_ativo, tipo_arquivo)

        try:
            documento = Documento(
                id_ativo=id_ativo,
                nome_original=arquivo.filename,
                tipo_arquivo=tipo_arquivo,
                tamanho=tamanho,
                caminho_storage=caminho,
            )

            documento.salvar()

            return documento.to_dict()

        except Exception:
            db.session.rollback()

            try:
                storage.excluir(caminho)
            except Exception:
                current_app.logger.exception("Erro ao remover arquivo do Supabase.")

            raise
