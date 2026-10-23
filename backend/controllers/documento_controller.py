from flask import Blueprint, jsonify, request, current_app, send_file
from flask_jwt_extended import jwt_required, get_jwt_identity
from sqlalchemy.exc import SQLAlchemyError
from io import BytesIO

from models import db
from services import (
    CadastrarDocumentoService,
    ListarDocumentosService,
    BaixarDocumentoService,
)

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


@documento_bp.get("/ativos/<int:id_ativo>/documentos")
@jwt_required()
def listar_documentos(id_ativo):
    try:
        id_usuario = int(get_jwt_identity())

        documentos = ListarDocumentosService().executar(id_usuario, id_ativo)

        return jsonify(documentos), 200

    except ValueError as erro:
        return jsonify({"erro": str(erro)}), 404

    except PermissionError as erro:
        return jsonify({"erro": str(erro)}), 403

    except Exception:
        current_app.logger.exception("Erro inesperado ao listar documentos.")
        return jsonify({"erro": "Erro interno ao listar documentos."}), 500


@documento_bp.get("/documentos/<int:id_documento>/download")
@jwt_required()
def baixar_documento(id_documento):
    try:
        id_usuario = int(get_jwt_identity())

        resultado = BaixarDocumentoService().executar(
            id_usuario,
            id_documento,
        )

        return send_file(
            BytesIO(resultado["conteudo"]),
            mimetype=resultado["tipo_arquivo"],
            as_attachment=True,
            download_name=resultado["nome_original"],
        )

    except ValueError as erro:
        return jsonify({"erro": str(erro)}), 404

    except PermissionError as erro:
        return jsonify({"erro": str(erro)}), 403

    except Exception:
        current_app.logger.exception("Erro inesperado ao baixar documento.")

        return jsonify({"erro": "Erro interno ao baixar documento."}), 500
