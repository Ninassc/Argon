from models import Favorito


class ListarFavoritosService:

    def executar(self, id_usuario):

        favoritos = Favorito.listar_usuario(id_usuario)

        return [favorito.to_dict() for favorito in favoritos]
