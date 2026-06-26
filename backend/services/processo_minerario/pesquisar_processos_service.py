from models import ProcessoMinerario


class PesquisarProcessosService:

    def executar(self, termo):
        processos = ProcessoMinerario.pesquisar(termo)

        return [processo.to_dict() for processo in processos]
