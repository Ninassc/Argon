from models import ProcessoMinerario


class BuscarProcessoService:

    def executar(self, termo):
        processos = ProcessoMinerario.pesquisar(termo)

        return [processo.to_dict() for processo in processos]
