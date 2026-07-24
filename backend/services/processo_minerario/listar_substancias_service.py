from repositories import ProcessoMinerarioRepository


class ListarSubstanciasService:
    def executar(self):
        return ProcessoMinerarioRepository.listar_substancias()
