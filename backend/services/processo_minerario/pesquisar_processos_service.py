from repositories import ProcessoMinerarioRepository


class PesquisarProcessosService:

    def executar(self, termo, pagina, limite, fase=None):
        resultado = ProcessoMinerarioRepository.pesquisar(termo, pagina, limite, fase)

        return {
            "pagina": resultado["pagina"],
            "total": resultado["total"],
            "total_paginas": resultado["total_paginas"],
            "processos": [processo.to_dict() for processo in resultado["processos"]],
        }
