from repositories import UsuarioRepository


class DeletarUsuarioService:
    def executar(self, usuario_id):
        usuario = UsuarioRepository.buscar_por_id(usuario_id)

        if usuario is None:
            return None

        dados_usuario = usuario.to_dict()

        usuario.deletar()

        return dados_usuario
