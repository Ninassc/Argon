from models import AtivoMinerario


class DeletarAtivoService:

    def executar(self, id_usuario, id_ativo):

        ativo = AtivoMinerario.buscar_por_usuario_ativo(id_usuario, id_ativo)

        if ativo is None:
            return False

        ativo.deletar()

        return True
