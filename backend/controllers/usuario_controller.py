from flask import Blueprint, request, jsonify
from models import db
from sqlalchemy.exc import SQLAlchemyError

from services import CriarUsuarioService
from services import ListarUsuariosService
from services import BuscarUsuarioService
from services import DeletarUsuarioService
from services import AtualizarUsuarioService

from services import BuscarAtivoService
from services import ListarAtivosUsuarioService

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


@usuario_bp.get("/<int:id_usuario>/ativos/<int:id_ativo>")
def buscar_ativo(id_usuario, id_ativo):

    service = BuscarAtivoService()

    ativo = service.executar(id_usuario, id_ativo)

    if ativo is None:
        return jsonify({"erro": "Ativo não encontrado."}), 404

    return jsonify(ativo), 200


@usuario_bp.get("/<int:id_usuario>/ativos")
def listar_ativos(id_usuario):

    service = ListarAtivosUsuarioService()

    ativos = service.executar(id_usuario)

    return jsonify(ativos), 200