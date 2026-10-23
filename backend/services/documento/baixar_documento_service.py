from models import AtivoMinerario, Documento, Acesso
from services import StorageService


class BaixarDocumentoService:
    def executar(self, id_usuario, id_documento):
        documento = Documento.buscar_por_id(id_documento)

        if documento is None:
            raise ValueError("Documento não encontrado.")

        ativo = AtivoMinerario.buscar_por_id(documento.id_ativo)

        if ativo is None:
            raise ValueError("Ativo minerário não encontrado.")

        id_usuario = int(id_usuario)

        proprietario = ativo.id_usuario == id_usuario

        acesso = Acesso.buscar(id_usuario, documento.id_ativo)

        acesso_aprovado = (
            acesso is not None
            and acesso.status == "aprovado"
        )

        if not proprietario and not acesso_aprovado:
            raise PermissionError(
                "Você não tem permissão para baixar este documento."
            )

        conteudo = StorageService().download(
            documento.caminho_storage
        )

        return {
            "conteudo": conteudo,
            "nome_original": documento.nome_original,
            "tipo_arquivo": documento.tipo_arquivo,
        }