from models import Acesso, AtivoMinerario


class VerificarAcessoService:

    def executar(self, id_usuario, id_ativo):
        ativo = AtivoMinerario.buscar_por_id(id_ativo)

        if ativo is None:
            raise ValueError("Ativo não encontrado")

        if ativo.id_usuario == id_usuario:
            return True

        acesso = Acesso.buscar(id_usuario, id_ativo)

        if acesso is None:
            return False

        return acesso.status == "aprovado"