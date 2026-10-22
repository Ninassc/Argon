from flask import Blueprint, jsonify, request, current_app
from flask_jwt_extended import jwt_required, get_jwt_identity
from sqlalchemy.exc import SQLAlchemyError

from models import db
from services import CadastrarDocumentoService

documento_bp = Blueprint("documento", __name__)


@documento_bp.post("/ativos/<int:id_ativo>/documentos")
@jwt_required()
def cadastrar_documento(id_ativo):
    try:
        id_usuario = int(get_jwt_identity())
        arquivo = request.files.get("arquivo")

        documento = CadastrarDocumentoService().executar(id_usuario, id_ativo, arquivo)

        return jsonify(documento), 201

    except ValueError as erro:
        return jsonify({"erro": str(erro)}), 400

    except PermissionError as erro:
        return jsonify({"erro": str(erro)}), 403

    except SQLAlchemyError:
        db.session.rollback()
        current_app.logger.exception("Erro no banco ao cadastrar documento.")
        return jsonify({"erro": "Erro ao cadastrar documento."}), 500

    except Exception:
        current_app.logger.exception("Erro inesperado ao cadastrar documento.")
        return jsonify({"erro": "Erro interno ao cadastrar documento."}), 500
