from repositories import ProcessoMinerarioRepository


class BuscarDetalhesProcessoService:

    def executar(self, id_processo):

        resultado = ProcessoMinerarioRepository.buscar_detalhes(id_processo)

        if resultado is None:
            return None

        return {
            "processo": resultado["processo"].to_dict(),
            "ativo": (resultado["ativo"].to_dict() if resultado["ativo"] else None),
        }
