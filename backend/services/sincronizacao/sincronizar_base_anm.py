from services.sincronizacao.buscar_dados_anm_service import BuscarDadosANMService
from services.processo_minerario.importar_processos_anm_service import (
    ImportarProcessosANMService,
)


class SincronizarBaseANMService:

    def executar(self):
        processos = BuscarDadosANMService().executar()

        resultado = ImportarProcessosANMService().executar_importacao(
            processos
        )

        return resultado