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


@usuario_bp.post("/")
def criar_usuario():
    try:
        dados = request.get_json()

        service = CriarUsuarioService()

        usuario = service.executar(dados)

        return jsonify(usuario), 201

    except ValueError as erro:
        return jsonify({"erro": str(erro)}), 400

    except Exception as e:
        db.session.rollback()
        print(e)
        raise

    # except SQLAlchemyError:
    #     db.session.rollback()
    #     return jsonify({"erro": "Erro ao salvar usuário no banco de dados."}), 500


@usuario_bp.get("/")
def listar_usuarios():
    service = ListarUsuariosService()

    usuarios = service.executar()

    return jsonify(usuarios), 200


@usuario_bp.get("/<int:usuario_id>")
def buscar_usuario_id(usuario_id):
    service = BuscarUsuarioService()

    usuario = service.executar(usuario_id)

    if usuario is None:
        return jsonify({"erro": "Usuário não encontrado."}), 404

    return jsonify(usuario), 200


@usuario_bp.put("/<int:usuario_id>")
def atualizar_usuario(usuario_id):
    try:
        dados = request.get_json() or {}

        service = AtualizarUsuarioService()

        usuario = service.executar(usuario_id, dados)

        if usuario is None:
            return jsonify({"erro": "Usuário não encontrado."}), 404

        return jsonify(usuario), 200

    except ValueError as erro:
        return jsonify({"erro": str(erro)}), 400

    except SQLAlchemyError:
        db.session.rollback()
        return jsonify({"erro": "Erro ao atualizar usuário."}), 500


@usuario_bp.delete("/<int:usuario_id>")
def deletar_usuario(usuario_id):
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

    usuario = BuscarUsuarioService().executar(id_usuario)

    return jsonify(usuario), 200


@usuario_bp.put("/me")
@jwt_required()
def atualizar_me():
    id_usuario = int(get_jwt_identity())

    usuario = AtualizarUsuarioService().executar(id_usuario, request.get_json())

    return jsonify(usuario), 200


@usuario_bp.put("/me/senha")
@jwt_required()
def alterar_senha():
    id_usuario = int(get_jwt_identity())

    dados = request.get_json()

    service = AlterarSenhaService()

    service.executar(id_usuario, dados)

    return jsonify({"mensagem": "Senha alterada com sucesso."}), 200
