from repositories import UsuarioRepository


class BuscarUsuarioService:
    def executar(self, usuario_id, incluir_contato=False):
        usuario = UsuarioRepository.buscar_por_id(usuario_id)

        if usuario is None:
            return None

        return usuario.to_dict(incluir_contato=incluir_contato)
