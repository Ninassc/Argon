from models import ProcessoMinerario


class ListarProcessosService:

    def executar(self, pagina, limite):
        processos = ProcessoMinerario.listar_paginado(pagina, limite)

        return {
            "pagina": processos.page,
            "total": processos.total,
            "total_paginas": processos.pages,
            "processos": [processo.to_dict() for processo in processos.items],
        }
