from flask import Blueprint, request, jsonify
from flask_jwt_extended import (
    jwt_required,
    get_jwt_identity,
)

from models import db

from services import ListarProcessosService
from services import DeletarProcessoService
from services import PesquisarProcessosService
from services import BuscarDetalhesProcessoService
from services import ListarFasesService
from services import ListarSubstanciasService

processo_bp = Blueprint("processos", __name__, url_prefix="/processos")


@processo_bp.get("/")
def listar_processos():

    pagina = request.args.get("page", 1, type=int)
    limite = request.args.get("limit", 20, type=int)

    fase = request.args.get("fase") or None
    substancia = request.args.get("substancia") or None

    limite = min(limite, 100)

    service = ListarProcessosService()
    resultado = service.executar(
        pagina,
        limite,
        fase,
        substancia,
    )

    return jsonify(resultado), 200


@processo_bp.get("/pesquisar")
def pesquisar_processo():

    termo = request.args.get("termo", "")
    fase = request.args.get("fase") or None
    substancia = request.args.get("substancia") or None

    pagina = request.args.get("page", 1, type=int)
    limite = request.args.get("limit", 20, type=int)

    limite = min(limite, 100)

    service = PesquisarProcessosService()
    resultado = service.executar(
        termo,
        pagina,
        limite,
        fase,
        substancia,
    )

    return jsonify(resultado), 200


@processo_bp.get("/<int:id_processo>/detalhes")
def buscar_detalhes(id_processo):

    service = BuscarDetalhesProcessoService()

    resultado = service.executar(id_processo)

    if resultado is None:
        return jsonify({"erro": "Processo não encontrado."}), 404

    return jsonify(resultado), 200


@processo_bp.get("/fases")
def listar_fases():
    try:
        fases = ListarFasesService().executar()

        return jsonify(fases), 200

    except Exception as erro:
        return jsonify({"erro": str(erro)}), 500


@processo_bp.get("/substancias")
def listar_substancias():
    try:
        substancias = ListarSubstanciasService().executar()

        return jsonify(substancias), 200

    except Exception as erro:
        return jsonify({"erro": str(erro)}), 500


# Apenas para teste (os processos minerários não poderão ser deletados)
# @processo_bp.delete("/<int:id_processo>")
# def deletar_processo(id_processo):
#     service = DeletarProcessoService()

#     resultado = service.executar(id_processo)

#     if not resultado:
#         return jsonify({"erro": "Processo não encontrado."}), 404

#     return jsonify({"mensagem": "Processo excluído com sucesso."}), 200


# @processo_bp.get('/pesquisar')
# def pesquisar_processo():
#     termo = request.args.get("termo", "")

#     service = PesquisarProcessosService()

#     processos = service.executar(termo)

#     return jsonify(processos), 200


# @processo_bp.get('/')
# def listar_processos():
#     service = ListarProcessosService()

#     processos = service.executar()

#     return jsonify(processos), 200
