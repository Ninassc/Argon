from models import Acesso


class ListarEnviadasService:

    def executar(self, id_usuario):
        enviadas = Acesso.listar_enviadas(id_usuario)

        return [solicitacao.to_dict() for solicitacao in enviadas]
