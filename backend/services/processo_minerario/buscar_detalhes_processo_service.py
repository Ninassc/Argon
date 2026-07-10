from models import AtivoMinerario
from models import ProcessoMinerario


class BuscarDetalhesProcessoService:

    def executar(self, id_processo):

        processo = ProcessoMinerario.buscar_por_id(id_processo)

        if processo is None:
            return None

        ativo = AtivoMinerario.buscar_por_processo(id_processo)

        return {
            "processo": processo.to_dict(),
            "ativo": (ativo.to_dict() if ativo else None),
        }
