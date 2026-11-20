from flask import Blueprint, jsonify, request

from services import LoginService
from services import BuscarUsuarioService

from flask_jwt_extended import (
    jwt_required,
    get_jwt_identity,
)

auth_bp = Blueprint(
    "auth",
    __name__,
    url_prefix="/auth",
)

class AuthController:

    @auth_bp.post("/login")
    def login():
        try:
            dados = request.get_json(silent=True)
            if not isinstance(dados, dict):
                return jsonify({"erro": "Envie um objeto JSON."}), 400

            resultado = LoginService().executar(dados)

            return jsonify(resultado), 200

        except ValueError as erro:
            return jsonify({"erro": str(erro)}), 401


    @auth_bp.get("/me")
    @jwt_required()
    def usuario_logado():

        id_usuario = int(get_jwt_identity())

        service = BuscarUsuarioService()

        usuario = service.executar(id_usuario, incluir_contato=True)

        if usuario is None:
            return jsonify({"erro": "Usuário não encontrado."}), 404

        return jsonify(usuario), 200
