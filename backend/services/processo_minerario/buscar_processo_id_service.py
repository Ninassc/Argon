from models import ProcessoMinerario


class BuscarProcessoPorIdService:

    def executar(self, id_processo):

        processo = ProcessoMinerario.buscar_por_id(id_processo)

        if processo is None:
            return None

        return processo.to_dict()