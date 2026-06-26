from models import AtivoMinerario


class AtualizarAtivoService:

    def executar(self, id_usuario, id_ativo, dados):

        ativo = AtivoMinerario.buscar_por_usuario_ativo(id_usuario, id_ativo)

        if ativo is None:
            return None

        ativo.atualizar(descricao=dados.get("descricao"))

        return ativo.to_dict()
