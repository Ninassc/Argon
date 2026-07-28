from models import Favorito, ProcessoMinerario


class CriarFavoritoService:

    def executar(self, id_usuario, id_processo):

        processo = ProcessoMinerario.query.get(id_processo)

        if processo is None:
            raise ValueError("Processo não encontrado.")

        if Favorito.existe(id_usuario, id_processo):
            raise ValueError("Processo já está salvo.")

        favorito = Favorito.criar(id_usuario, id_processo)

        return favorito.to_dict()
