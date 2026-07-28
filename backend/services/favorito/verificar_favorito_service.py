from models import Favorito


class VerificarFavoritoService:

    def executar(self, id_usuario, id_processo):

        favorito = Favorito.existe(id_usuario, id_processo)

        return favorito is not None
