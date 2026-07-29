from models import Favorito


class DeletarFavoritoService:

    def executar(self, id_usuario, id_processo):

        favorito = Favorito.existe(
            id_usuario,
            id_processo
        )

        if favorito is None:
            raise ValueError("Processo não está salvo.")

        Favorito.deletar(
            id_usuario,
            id_processo
        )

        return {
            "mensagem": "Processo removido dos favoritos."
        }