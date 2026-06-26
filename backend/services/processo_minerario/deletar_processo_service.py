from models import ProcessoMinerario

class DeletarProcessoService:
    def executar(self, id_processo):
        processo = ProcessoMinerario.buscar_por_id(id_processo)

        if processo is None:
            return False

        processo.deletar()

        return True