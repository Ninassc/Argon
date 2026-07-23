from repositories import ProcessoMinerarioRepository


class ListarProcessosService:
    def executar(self, pagina, limite, fase=None):

        resultado = ProcessoMinerarioRepository.listar_paginado(pagina, limite, fase)

        return {
            "pagina": resultado["pagina"],
            "total": resultado["total"],
            "total_paginas": resultado["total_paginas"],
            "processos": [processo.to_dict() for processo in resultado["processos"]],
        }
