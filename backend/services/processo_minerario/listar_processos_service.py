from models import ProcessoMinerario

class ListarProcessosService:

    def executar(self):
        processos = ProcessoMinerario.listar_todos()

        return [processo.to_dict() for processo in processos]
