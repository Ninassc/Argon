import os
import re

import click
from flask import Flask
from flask_cors import CORS
from flask_jwt_extended import JWTManager

from config import Config
from models import Usuario, db
from controllers import (
    usuario_bp,
    processo_bp,
    ativo_bp,
    auth_bp,
    favorito_bp,
    compartilhamento_bp,
    acesso_bp,
    documento_bp
)

from scheduler import iniciar_scheduler


def create_app():
    app = Flask(__name__)

    app.config.from_object(Config)

    jwt = JWTManager(app)

    @jwt.token_in_blocklist_loader
    def credencial_revogada(_header, payload):
        versao = payload.get("credencial")
        if not isinstance(versao, str):
            return True
        try:
            id_usuario = int(payload["sub"])
        except (KeyError, TypeError, ValueError):
            return True
        usuario = db.session.get(Usuario, id_usuario)
        return usuario is None or usuario.versao_credencial() != versao

    origens = app.config["CORS_ORIGINS"]
    if "*" in origens:
        raise RuntimeError("Configure origens explícitas em CORS_ORIGINS.")
    if origens:
        padroes = [re.compile(rf"\A{re.escape(origem)}\Z") for origem in origens]
        CORS(app, origins=padroes)

    db.init_app(app)

    @app.cli.command("migrar-senhas")
    def migrar_senhas():
        total = 0
        ultimo_id = 0
        while True:
            usuarios = (
                Usuario.query.filter(
                    Usuario.id_usuario > ultimo_id,
                    ~Usuario.senha.startswith(Usuario.PREFIXO_HASH_SENHA),
                )
                .order_by(Usuario.id_usuario)
                .limit(100)
                .with_for_update()
                .all()
            )
            if not usuarios:
                break
            ultimo_id = usuarios[-1].id_usuario
            for usuario in usuarios:
                usuario.definir_senha(usuario.senha)
            db.session.commit()
            total += len(usuarios)
        click.echo(f"Senhas migradas: {total}")

    app.register_blueprint(usuario_bp)
    app.register_blueprint(processo_bp)
    app.register_blueprint(ativo_bp)
    app.register_blueprint(auth_bp)
    app.register_blueprint(favorito_bp)
    app.register_blueprint(compartilhamento_bp)
    app.register_blueprint(acesso_bp)
    app.register_blueprint(documento_bp)

    with app.app_context():
        db.create_all()

    return app


app = create_app()

if __name__ == "__main__":
    debug = app.config["APP_DEBUG"]
    if not debug or os.environ.get("WERKZEUG_RUN_MAIN") == "true":
        iniciar_scheduler(app)

    app.run(debug=debug)
