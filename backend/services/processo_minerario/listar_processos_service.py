from repositories import ProcessoMinerarioRepository


class ListarProcessosService:
    def executar(self, pagina, limite, fase=None, substancia=None):

        resultado = ProcessoMinerarioRepository.listar_paginado(
            pagina,
            limite,
            fase,
            substancia,
        )

        return {
            "pagina": resultado["pagina"],
            "total": resultado["total"],
            "total_paginas": resultado["total_paginas"],
            "processos": [processo.to_dict() for processo in resultado["processos"]],
        }
