from repositories import AtivoMinerarioRepository

class ListarAtivosUsuarioService:

    def executar(self, id_usuario):
        return AtivoMinerarioRepository.listar_ativos_usuario(id_usuario)
