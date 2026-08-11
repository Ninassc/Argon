from models import CompartilhamentoProcesso


class ListarProcessosRecebidosService:

    def executar(self, id_usuario):

        compartilhamentos = CompartilhamentoProcesso.listar_recebidos(id_usuario)

        return [compartilhamento.to_dict() for compartilhamento in compartilhamentos]
