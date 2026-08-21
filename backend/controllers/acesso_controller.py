from flask import Blueprint, request, jsonify
from sqlalchemy.exc import SQLAlchemyError
from flask_jwt_extended import (
    jwt_required,
    get_jwt_identity,
)

from models import db

from services import SolicitarAcessoService

acesso_bp = Blueprint("acesso", __name__, url_prefix="/acessos")


class AcessoController:

    @acesso_bp.post("/<int:id_ativo>/solicitar")
    @jwt_required()
    def solicitar_acesso(id_ativo):
        try:
            id_usuario = int(get_jwt_identity)

            acesso = SolicitarAcessoService().executar(id_usuario, id_ativo)

            return jsonify(acesso), 201

        except ValueError as erro:
            return jsonify({"erro": str(erro)}), 400

        except SQLAlchemyError:
            db.session.rollback()

            return jsonify({"erro": "Erro ao solicitar acesso."}), 500