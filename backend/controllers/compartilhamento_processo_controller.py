from flask import Blueprint, jsonify, request
from flask_jwt_extended import jwt_required, get_jwt_identity

from sqlalchemy.exc import SQLAlchemyError

from models import db

from services import (
    CompartilharProcessoService,
    ListarProcessosEnviadosService,
    ListarProcessosRecebidosService,
)

compartilhamento_bp = Blueprint(
    "compartilhamento_processo",
    __name__,
    url_prefix="/compartilhamentos",
)


@compartilhamento_bp.post("/<int:id_processo>")
@jwt_required()
def compartilhar_processo(id_processo):
    try:
        id_usuario_origem = int(get_jwt_identity())

        dados = request.get_json() or {}
        email = dados.get("email")

        compartilhamento = CompartilharProcessoService().executar(
            id_usuario_origem=id_usuario_origem,
            id_processo=id_processo,
            email=email,
        )

        return jsonify(compartilhamento), 201

    except ValueError as erro:
        return jsonify({"erro": str(erro)}), 400

    except SQLAlchemyError:
        db.session.rollback()

        return jsonify({"erro": "Erro ao compartilhar processo."}), 500


@compartilhamento_bp.get("/recebidos")
@jwt_required()
def listar_processos_recebidos():
    try:
        id_usuario = int(get_jwt_identity())

        compartilhamentos = ListarProcessosRecebidosService().executar(id_usuario)

        return jsonify(compartilhamentos), 200

    except SQLAlchemyError:
        db.session.rollback()

        return jsonify({"erro": "Erro ao carregar processos compartilhados."}), 500


@compartilhamento_bp.get("/enviados")
@jwt_required()
def listar_processos_enviados():
    try:
        id_usuario = int(get_jwt_identity())

        compartilhamentos = ListarProcessosEnviadosService().executar(id_usuario)

        return jsonify(compartilhamentos), 200

    except SQLAlchemyError:
        db.session.rollback()

        return jsonify({"erro": "Erro ao carregar processos enviados."}), 500
