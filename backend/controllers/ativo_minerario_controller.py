from flask import Blueprint, request, jsonify
from sqlalchemy.exc import SQLAlchemyError
from flask_jwt_extended import (
    jwt_required,
    get_jwt_identity,
)

from models import db

from services import (
    CriarAtivoService,
    AtualizarAtivoService,
    DeletarAtivoService,
)

ativo_bp = Blueprint(
    "ativos",
    __name__,
    url_prefix="/ativos",
)


@ativo_bp.post("/")
@jwt_required()
def criar_ativo():

    try:
        dados = request.get_json()

        id_usuario = int(get_jwt_identity())

        service = CriarAtivoService()

        ativo = service.executar(
            dados,
            id_usuario,
        )

        return jsonify(ativo), 201

    except ValueError as erro:
        return jsonify({"erro": str(erro)}), 400

    except SQLAlchemyError:
        db.session.rollback()
        return jsonify({"erro": "Erro ao criar ativo."}), 500


@ativo_bp.put("/<int:id_ativo>")
@jwt_required()
def atualizar_ativo(id_ativo):

    try:

        dados = request.get_json()

        id_usuario = int(get_jwt_identity())

        service = AtualizarAtivoService()

        ativo = service.executar(
            id_ativo,
            id_usuario,
            dados,
        )

        if ativo is None:
            return (
                jsonify({"erro": "Ativo não encontrado ou você não possui permissão."}),
                404,
            )

        return jsonify(ativo), 200

    except ValueError as erro:
        return jsonify({"erro": str(erro)}), 400

    except SQLAlchemyError:
        db.session.rollback()
        return jsonify({"erro": "Erro ao atualizar ativo."}), 500


@ativo_bp.delete("/<int:id_ativo>")
@jwt_required()
def deletar_ativo(id_ativo):

    try:

        id_usuario = int(get_jwt_identity())

        service = DeletarAtivoService()

        resultado = service.executar(id_ativo, id_usuario)

        if not resultado:
            return (
                jsonify({"erro": "Ativo não encontrado ou você não possui permissão."}),
                404,
            )

        return jsonify({"mensagem": "Ativo excluído com sucesso."}), 200

    except SQLAlchemyError:
        db.session.rollback()
        return jsonify({"erro": "Erro ao excluir ativo."}), 500
