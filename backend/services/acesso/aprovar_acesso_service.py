from models import Acesso


class AprovarAcessoService:

    def executar(self, id_usuario, id_acesso):
        acesso = Acesso.query.get(id_acesso)

        if acesso is None:
            raise ValueError("Solicitação inexistente")

        if acesso.ativo.id_usuario != id_usuario:
            raise ValueError(
                "Você não possui permissão para aprovar esta solicitação"
            )

        if acesso.status != "pendente":
            raise ValueError("Esta solicitação já foi respondida")

        acesso.aprovar()

        return acesso.to_dict()