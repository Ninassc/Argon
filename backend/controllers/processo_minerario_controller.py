from flask import Blueprint, request, jsonify

from models import db

from services import ListarProcessosService
from services import ImportarProcessosANMService
from services import BuscarProcessoPorIdService
from services import DeletarProcessoService
from services import PesquisarProcessosService

processo_bp = Blueprint('processos', __name__, url_prefix='/processos')

@processo_bp.get('/')
def listar_processos():
    service = ListarProcessosService()

    processos = service.executar()

    return jsonify(processos), 200


@processo_bp.get('/pesquisar')
def pesquisar_processo():
    termo = request.args.get("termo", "")
    
    service = PesquisarProcessosService()

    processos = service.executar(termo)

    return jsonify(processos), 200


@processo_bp.get('/<int:id_processo>')
def buscar_processo(id_processo):
    service = BuscarProcessoPorIdService()

    processo = service.executar(id_processo)

    if processo is None:
        return jsonify({
            "erro": "Processo não encontrado."
        }), 404

    return jsonify(processo), 200

#Apenas para teste (os processos minerários não poderão ser deletados)
@processo_bp.delete("/<int:id_processo>")
def deletar_processo(id_processo):
    service = DeletarProcessoService()

    resultado = service.executar(id_processo)

    if not resultado:
        return jsonify({"erro": "Processo não encontrado."}), 404

    return jsonify({"mensagem": "Processo excluído com sucesso."}), 200

