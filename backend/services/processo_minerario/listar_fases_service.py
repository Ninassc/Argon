from repositories import ProcessoMinerarioRepository


class ListarFasesService:
    def executar(self):
        return ProcessoMinerarioRepository.listar_fases()
