import os
import sys

BASE_DIR = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
sys.path.insert(0, BASE_DIR)

from app import create_app
from services.sincronizacao.sincronizar_base_anm import SincronizarBaseANMService


app = create_app()

with app.app_context():
    resultado = SincronizarBaseANMService().executar()
    print("\n===== Sincronização concluída =====")
    print(f"Processos importados : {resultado['importados']}")
    print(f"Processos atualizados: {resultado['atualizados']}")
    print(f"Total processado     : {resultado['importados'] + resultado['atualizados']}")