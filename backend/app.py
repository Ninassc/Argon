from flask import Flask
from flask_cors import CORS
from flask_jwt_extended import JWTManager

from config import Config
from models import db
from controllers import usuario_bp, processo_bp, ativo_bp, auth_bp


def create_app():
    app = Flask(__name__)

    app.config.from_object(Config)

    jwt = JWTManager(app)

    CORS(app)

    db.init_app(app)

    app.register_blueprint(usuario_bp)
    app.register_blueprint(processo_bp)
    app.register_blueprint(ativo_bp)
    app.register_blueprint(auth_bp)

    with app.app_context():
        db.create_all()

    return app


app = create_app()

if __name__ == "__main__":
    app.run(debug=True)
