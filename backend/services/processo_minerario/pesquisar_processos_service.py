from models import ProcessoMinerario


class PesquisarProcessosService:

    def executar(self, termo, pagina, limite):

        processos = ProcessoMinerario.pesquisar(
            termo,
            pagina,
            limite,
        )

        return {
            "pagina": processos.page,
            "total": processos.total,
            "total_paginas": processos.pages,
            "processos": [processo.to_dict() for processo in processos.items],
        }
