from models import AtivoMinerario
from repositories import AtivoMinerarioRepository


class AtualizarAtivoService:

    def executar(self, id_ativo, id_usuario, dados):

        ativo = AtivoMinerarioRepository.buscar_por_usuario_ativo(id_usuario, id_ativo)

        if ativo is None:
            return None

        ativo.atualizar(descricao=dados.get("descricao"))

        return ativo.to_dict()
