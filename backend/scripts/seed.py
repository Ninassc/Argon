import os
import sys

BASE_DIR = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
sys.path.insert(0, BASE_DIR)

from app import create_app
from models import db, Usuario, ProcessoMinerario

app = create_app()

with app.app_context():

    # Limpa os dados existentes (ordem importante por causa das FKs)
    # db.session.query(ProcessoMinerario).delete()
    # db.session.query(Usuario).delete()

    # Usuários
    usuarios = [
        Usuario(
            nome="Clara",
            email="clara@email.com",
            senha="123456",
            telefone="31999990001",
            tipo_conta="Titular",
        ),
        Usuario(
            nome="Victor",
            email="victor@email.com",
            senha="123456",
            telefone="31999990002",
            tipo_conta="Interessado",
        ),
    ]

    db.session.add_all(usuarios)

    # Processos Minerários
    processos = [
        ProcessoMinerario(
            processo="830.001/2026",
            numero="001",
            ano="2026",
            area_ha="120.50",
            id_anm="1001",
            fase="Pesquisa",
            ult_evento="Cadastro inicial",
            nome="Mineração Serra Azul",
            subs="Ferro",
            uso="Industrial",
            uf="MG",
            ds_processo="Ativo",
        ),
        ProcessoMinerario(
            processo="830.002/2026",
            numero="002",
            ano="2026",
            area_ha="87.30",
            id_anm="1002",
            fase="Requerimento",
            ult_evento="Aguardando análise",
            nome="Mineração Horizonte",
            subs="Ouro",
            uso="Industrial",
            uf="MG",
            ds_processo="Ativo",
        ),
        ProcessoMinerario(
            processo="830.003/2026",
            numero="003",
            ano="2026",
            area_ha="45.80",
            id_anm="1003",
            fase="Lavra",
            ult_evento="Licença concedida",
            nome="Pedreira Minas",
            subs="Calcário",
            uso="Construção Civil",
            uf="MG",
            ds_processo="Ativo",
        ),
    ]

    db.session.add_all(processos)

    db.session.commit()

    print("Banco populado com sucesso!")