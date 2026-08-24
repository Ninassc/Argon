from models import Acesso


class ListarSolicitacoesRecebidasService:

    def executar(self, id_usuario):
        solicitacoes = Acesso.listar_solicitacoes_recebidas(id_usuario)

        return [solicitacao.to_dict() for solicitacao in solicitacoes]
