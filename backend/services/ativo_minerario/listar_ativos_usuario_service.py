from models import AtivoMinerario

class ListarAtivosUsuarioService:

    def executar(self, id_usuario):
        ativos = AtivoMinerario.buscar_por_usuario(id_usuario)

        return [ativo.to_dict() for ativo in ativos]
