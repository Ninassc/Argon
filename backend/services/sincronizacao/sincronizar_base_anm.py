from services import BaixarDBFService
from services import LerDBFService
from services import ImportarProcessosANMService

class SincronizarBaseANMService:

    def executar(self):
        """
        Orquestra toda a sincronização da base da ANM.

        Fluxo:
            1. Baixa o DBF.
            2. Lê o arquivo.
            3. Importa os processos para o banco.
        """

        # caminho = BaixarDBFService().executar()

        # processos = LerDBFService().executar(caminho)

        # resultado = ImportarProcessosANMService().executar_importacao(
        #     processos
        # )

        # return resultado
        
        pass