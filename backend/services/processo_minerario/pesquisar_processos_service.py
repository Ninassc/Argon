from repositories import ProcessoMinerarioRepository


class PesquisarProcessosService:

    def executar(self, termo, pagina, limite):

        processos = ProcessoMinerarioRepository.pesquisar(
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
