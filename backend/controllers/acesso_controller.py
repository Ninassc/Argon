from flask import Blueprint, request, jsonify
from sqlalchemy.exc import SQLAlchemyError
from flask_jwt_extended import (
    jwt_required,
    get_jwt_identity,
)

from models import db

from services import (
    SolicitarAcessoService,
    ListarSolicitacoesRecebidasService,
    AprovarAcessoService,
    RecusarAcessoService,
    VerificarAcessoService,
)

acesso_bp = Blueprint("acesso", __name__, url_prefix="/acessos")


class AcessoController:

    @acesso_bp.post("/<int:id_ativo>/solicitar")
    @jwt_required()
    def solicitar_acesso(id_ativo):
        try:
            id_usuario = int(get_jwt_identity())

            acesso = SolicitarAcessoService().executar(id_usuario, id_ativo)

            return jsonify(acesso), 201

        except ValueError as erro:
            return jsonify({"erro": str(erro)}), 400

        except SQLAlchemyError:
            db.session.rollback()

            return jsonify({"erro": "Erro ao solicitar acesso."}), 500

    @acesso_bp.get("/recebidas")
    @jwt_required()
    def listar_solicitacoes_recebidas():
        try:
            id_usuario = int(get_jwt_identity())

            solicitacoes = ListarSolicitacoesRecebidasService().executar(id_usuario)

            return jsonify(solicitacoes), 200

        except ValueError as erro:
            return jsonify({"erro": str(erro)}), 400

        except SQLAlchemyError as erro:
            db.session.rollback()

            return jsonify({"erro": "Erro ao carregar solicitações de acesso."}), 500

    @acesso_bp.put("/<int:id_acesso>/aprovar")
    @jwt_required()
    def aprovar_acesso(id_acesso):
        try:
            id_usuario = int(get_jwt_identity())

            acesso = AprovarAcessoService().executar(id_usuario, id_acesso)

            return jsonify(acesso), 200

        except ValueError as erro:
            return jsonify({"erro": str(erro)}), 400

        except SQLAlchemyError:
            db.session.rollback()

            return jsonify({"erro": "Erro ao aprovar solicitação de acesso."}), 500

    @acesso_bp.put("/<int:id_acesso>/recusar")
    @jwt_required()
    def recusar_acesso(id_acesso):
        try:
            id_usuario = int(get_jwt_identity())

            acesso = RecusarAcessoService().executar(id_usuario, id_acesso)

            return jsonify(acesso), 200

        except ValueError as erro:
            return jsonify({"erro": str(erro)}), 400

        except SQLAlchemyError:
            db.session.rollback()

            return jsonify({"erro": "Erro ao recusar solicitação de acesso."}), 500

    @acesso_bp.get("/<int:id_ativo>/verificar")
    @jwt_required()
    def verificar_acesso(id_ativo):
        try:
            id_usuario = int(get_jwt_identity())

            resultado = VerificarAcessoService().executar(id_usuario, id_ativo)

            return jsonify(resultado), 200

        except ValueError as erro:
            return jsonify({"erro": str(erro)}), 400

        except SQLAlchemyError:
            db.session.rollback()

            return jsonify({"erro": "Erro ao verificar acesso."}), 500
