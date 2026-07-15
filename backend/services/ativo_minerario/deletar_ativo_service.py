from repositories import AtivoMinerarioRepository


class DeletarAtivoService:

    def executar(self, id_ativo, id_usuario):

        ativo = AtivoMinerarioRepository.buscar_por_usuario_ativo(id_usuario, id_ativo)

        if ativo is None:
            return False

        ativo.deletar()

        return True
