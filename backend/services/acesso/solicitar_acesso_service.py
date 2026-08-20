from models import Acesso, AtivoMinerario


class SolicitarAcessoService:

    def executar(self, id_usuario, id_ativo):
        ativo = AtivoMinerario.buscar_por_id(id_ativo)

        if ativo is None:
            raise ValueError("Ativo não encontrado")

        if ativo.id_usuario == id_usuario:
            raise ValueError("Você não pode solicitar acesso ao seu próprio ativo")

        acesso_existente = Acesso.buscar(id_usuario, id_ativo)

        if acesso_existente:
            if acesso_existente.status == "pendende":
                raise ValueError("Já existe uma solicitação de acesso pendente")

            if acesso_existente.status == "aprovado":
                raise ValueError("Você já possui acesso a este ativo")

            if acesso_existente.status == "recusado":
                raise ValueError("Sua solicitação de acesso já foi recusada")

        acesso = Acesso.criar_solicitacao(
            id_usuario=id_usuario,
            id_ativo=id_ativo
        )

        return acesso.to_dict()