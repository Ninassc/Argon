from models import Acesso, AtivoMinerario


class VerificarAcessoService:

    def executar(self, id_usuario, id_ativo):
        ativo = AtivoMinerario.buscar_por_id(id_ativo)

        if ativo is None:
            raise ValueError("Ativo não encontrado")

        if ativo.id_usuario == id_usuario:
            return {
                "possui_acesso": True,
                "status": "proprietario",
            }

        acesso = Acesso.buscar(id_usuario, id_ativo)

        if acesso is None:
            return {
                "possui_acesso": False,
                "status": None,
            }

        return {
            "possui_acesso": acesso.status == "aprovado",
            "status": acesso.status,
        }