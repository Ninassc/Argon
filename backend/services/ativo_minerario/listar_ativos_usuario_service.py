from repositories import AtivoMinerarioRepository

class ListarAtivosUsuarioService:

    def executar(self, id_usuario):
        ativos = AtivoMinerarioRepository.buscar_por_usuario(id_usuario)

        return [ativo.to_dict() for ativo in ativos]
