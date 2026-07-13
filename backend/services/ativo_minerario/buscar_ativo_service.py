from models import AtivoMinerario
from repositories import AtivoMinerarioRepository


class BuscarAtivoService:

    def executar(self, id_usuario, id_ativo):

        ativo = AtivoMinerarioRepository.buscar_por_usuario_ativo(id_usuario, id_ativo)

        if ativo is None:
            return None

        return ativo.to_dict()
