from flask import Blueprint, request, jsonify
from models import db
from sqlalchemy.exc import SQLAlchemyError
from flask_jwt_extended import (
    jwt_required,
    get_jwt_identity,
)

from services import CriarUsuarioService
from services import ListarUsuariosService
from services import BuscarUsuarioService
from services import DeletarUsuarioService
from services import AtualizarUsuarioService
from services import AlterarSenhaService

usuario_bp = Blueprint("usuario", __name__, url_prefix="/usuarios")

class UsuarioController:

    @usuario_bp.post("/")
    def criar_usuario():
        try:
            dados = request.get_json(silent=True)
            if not isinstance(dados, dict):
                return jsonify({"erro": "Envie um objeto JSON."}), 400

            service = CriarUsuarioService()

            usuario = service.executar(dados)

            return jsonify(usuario), 201

        except ValueError as erro:
            return jsonify({"erro": str(erro)}), 400

        except SQLAlchemyError:
            db.session.rollback()
            raise

    @usuario_bp.get("/")
    @jwt_required()
    def listar_usuarios():
        service = ListarUsuariosService()

        usuarios = service.executar()

        return jsonify(usuarios), 200


    @usuario_bp.get("/<int:usuario_id>")
    @jwt_required()
    def buscar_usuario_id(usuario_id):
        service = BuscarUsuarioService()

        usuario = service.executar(
            usuario_id, incluir_contato=str(usuario_id) == get_jwt_identity()
        )

        if usuario is None:
            return jsonify({"erro": "Usuário não encontrado."}), 404

        return jsonify(usuario), 200


    @usuario_bp.delete("/<int:usuario_id>")
    @jwt_required()
    def deletar_usuario(usuario_id):
        if str(usuario_id) != get_jwt_identity():
            return jsonify({"erro": "Acesso negado."}), 403

        try:
            service = DeletarUsuarioService()

            resultado = service.executar(usuario_id)

            if not resultado:
                return jsonify({"erro": "Usuário não encontrado."}), 404

            return jsonify({"mensagem": "Usuário excluído com sucesso."}), 200

        except SQLAlchemyError:
            db.session.rollback()
            return jsonify({"erro": "Erro ao excluir usuário."}), 500


    @usuario_bp.get("/me")
    @jwt_required()
    def buscar_me():
        id_usuario = int(get_jwt_identity())

        usuario = BuscarUsuarioService().executar(id_usuario, incluir_contato=True)

        return jsonify(usuario), 200


    @usuario_bp.put("/me")
    @jwt_required()
    def atualizar_me():
        try:
            id_usuario = int(get_jwt_identity())

            dados = request.get_json(silent=True)
            if not isinstance(dados, dict):
                return jsonify({"erro": "Envie um objeto JSON."}), 400

            usuario = AtualizarUsuarioService().executar(id_usuario, dados)

            if usuario is None:
                return jsonify({"erro": "Usuário não encontrado."}), 404

            return jsonify(usuario), 200

        except ValueError as erro:
            return jsonify({"erro": str(erro)}), 400

        except SQLAlchemyError:
            db.session.rollback()
            return jsonify({"erro": "Erro ao atualizar usuário."}), 500


    @usuario_bp.put("/me/senha")
    @jwt_required()
    def alterar_senha():
        try:
            id_usuario = int(get_jwt_identity())

            dados = request.get_json(silent=True)
            if not isinstance(dados, dict):
                return jsonify({"erro": "Envie um objeto JSON."}), 400

            service = AlterarSenhaService()

            token = service.executar(id_usuario, dados)

            return jsonify({
                "mensagem": "Senha alterada com sucesso.",
                "token": token,
            }), 200

        except ValueError as erro:
            return jsonify({"erro": str(erro)}), 400

        except SQLAlchemyError:
            db.session.rollback()
            return jsonify({"erro": "Erro ao alterar senha."}), 500
