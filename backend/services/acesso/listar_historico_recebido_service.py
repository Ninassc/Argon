from models import Acesso

class ListarHistoricoRecebidoService:

    def executar(self, id_usuario):
        historico = Acesso.listar_historico_recebido(id_usuario)
        
        return [solicitacao.to_dict() for solicitacao in historico]