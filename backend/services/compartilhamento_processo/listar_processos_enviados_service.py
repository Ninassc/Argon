from models import CompartilhamentoProcesso


class ListarProcessosEnviadosService:

    def executar(self, id_usuario):

        compartilhamentos = CompartilhamentoProcesso.listar_enviados(id_usuario)

        return [compartilhamento.to_dict() for compartilhamento in compartilhamentos]
