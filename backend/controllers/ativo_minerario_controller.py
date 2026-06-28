from flask import Blueprint, request, jsonify
from sqlalchemy.exc import SQLAlchemyError

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
def criar_ativo():

    try:
        dados = request.get_json()

        service = CriarAtivoService()

        ativo = service.executar(dados)

        return jsonify(ativo), 201

    except ValueError as erro:
        return jsonify({"erro": str(erro)}), 400

    except SQLAlchemyError:
        db.session.rollback()
        return jsonify({"erro": "Erro ao criar ativo."}), 500


@ativo_bp.put("/<int:id_ativo>")
def atualizar_ativo(id_ativo):

    try:
        dados = request.get_json() or {}

        id_usuario = dados.get("id_usuario")

        service = AtualizarAtivoService()

        ativo = service.executar(id_usuario, id_ativo, dados)

        if ativo is None:
            return jsonify({"erro": "Ativo não encontrado."}), 404

        return jsonify(ativo), 200

    except ValueError as erro:
        return jsonify({"erro": str(erro)}), 400

    except SQLAlchemyError:
        db.session.rollback()
        return jsonify({"erro": "Erro ao atualizar ativo."}), 500


@ativo_bp.delete("/<int:id_ativo>")
def deletar_ativo(id_ativo):

    try:
        dados = request.get_json() or {}

        id_usuario = dados.get("id_usuario")

        service = DeletarAtivoService()

        resultado = service.executar(id_usuario, id_ativo)

        if not resultado:
            return jsonify({"erro": "Ativo não encontrado."}), 404

        return jsonify({"mensagem": "Ativo excluído com sucesso."}), 200

    except SQLAlchemyError:
        db.session.rollback()
        return jsonify({"erro": "Erro ao excluir ativo."}), 500
