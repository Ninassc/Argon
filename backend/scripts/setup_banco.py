"""
Prepara o banco na nuvem (Railway): cria as tabelas e as stored procedures.

"""
import re
import sys
from pathlib import Path

BASE_DIR = Path(__file__).resolve().parent.parent
sys.path.insert(0, str(BASE_DIR))

from app import app
from models import db


def extrair_procedures(sql):

    comandos = []

    
    blocos = re.split(r"(?im)^\s*DROP PROCEDURE IF EXISTS\s+", sql)[1:]

    for bloco in blocos:
        nome = bloco.split(";", 1)[0].strip()

        corpo = re.search(r"CREATE PROCEDURE.*\bEND\b", bloco, re.S | re.I)
        if not corpo:
            raise RuntimeError(f"Não encontrei o corpo da procedure {nome}.")

        comandos.append(f"DROP PROCEDURE IF EXISTS {nome}")
        comandos.append(corpo.group(0))

    return comandos


def main():
    with app.app_context():
        banco = db.engine.url.render_as_string(hide_password=True)
        print(f"Conectando em: {banco}")

        # 1) tabelas
        db.create_all()
        print("Tabelas criadas/verificadas.")

        # 2) procedures
        sql = (BASE_DIR / "database" / "procedures.sql").read_text(encoding="utf-8")
        comandos = extrair_procedures(sql)

        conexao = db.engine.raw_connection()
        try:
            cursor = conexao.cursor()
            for comando in comandos:
                cursor.execute(comando)
            conexao.commit()
        finally:
            conexao.close()

        print(f"{len(comandos) // 2} procedures criadas.")


if __name__ == "__main__":
    main()