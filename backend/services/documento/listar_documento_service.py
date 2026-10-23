from models import AtivoMinerario, Documento, Acesso


class ListarDocumentosService:
    def executar(self, id_usuario, id_ativo):
        ativo = AtivoMinerario.buscar_por_id(id_ativo)

        if ativo is None:
            raise ValueError("Ativo minerário não encontrado.")

        id_usuario = int(id_usuario)

        proprietario = ativo.id_usuario == id_usuario

        acesso = Acesso.buscar(id_usuario, id_ativo)

        acesso_aprovado = (
            acesso is not None
            and acesso.status == "aprovado"
        )

        if not proprietario and not acesso_aprovado:
            raise PermissionError(
                "Você não tem permissão para visualizar os documentos deste ativo."
            )

        documentos = Documento.listar_por_ativo(id_ativo)

        return [documento.to_dict() for documento in documentos]