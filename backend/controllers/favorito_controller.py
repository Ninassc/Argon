from flask import Blueprint, jsonify, request
from flask_jwt_extended import jwt_required, get_jwt_identity
from sqlalchemy.exc import SQLAlchemyError

from models import db
from services import CriarFavoritoService
from services import DeletarFavoritoService
from services import ListarFavoritosService
from services import VerificarFavoritoService

favorito_bp = Blueprint("favorito", __name__, url_prefix="/favoritos")

class FavoritoController:
    
    @favorito_bp.post("/")
    @jwt_required()
    def criar_favorito():

        try:
            id_usuario = int(get_jwt_identity())

            dados = request.get_json() or {}

            id_processo = dados.get("id_processo")

            if id_processo is None:
                return jsonify({"erro": "O processo é obrigatório."}), 400

            favorito = CriarFavoritoService().executar(id_usuario, id_processo)

            return jsonify(favorito), 201

        except ValueError as erro:
            return jsonify({"erro": str(erro)}), 400

        except SQLAlchemyError:
            db.session.rollback()

            return jsonify({"erro": "Erro ao salvar favorito."}), 500


    @favorito_bp.delete("/<int:id_processo>")
    @jwt_required()
    def deletar_favorito(id_processo):

        try:
            id_usuario = int(get_jwt_identity())

            resultado = DeletarFavoritoService().executar(id_usuario, id_processo)

            return jsonify(resultado), 200

        except ValueError as erro:
            return jsonify({"erro": str(erro)}), 400

        except SQLAlchemyError:
            db.session.rollback()

            return jsonify({"erro": "Erro ao remover favorito."}), 500


    @favorito_bp.get("/")
    @jwt_required()
    def listar_favoritos():

        try:
            id_usuario = int(get_jwt_identity())

            favoritos = ListarFavoritosService().executar(id_usuario)

            return jsonify(favoritos), 200

        except SQLAlchemyError:
            db.session.rollback()

            return jsonify({"erro": "Erro ao buscar favoritos."}), 500


    @favorito_bp.get("/verificar/<int:id_processo>")
    @jwt_required()
    def verificar_favorito(id_processo):

        id_usuario = int(get_jwt_identity())

        salvo = VerificarFavoritoService().executar(
            id_usuario,
            id_processo
        )

        return jsonify({
            "salvo": salvo
        }), 200