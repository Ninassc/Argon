from repositories import UsuarioRepository


class BuscarUsuarioService:
    def executar(self, usuario_id):
        usuario = UsuarioRepository.buscar_por_id(usuario_id)

        if usuario is None:
            raise ValueError("Usuário não encontrado.")

        return usuario.to_dict()
