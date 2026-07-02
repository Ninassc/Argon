from models import AtivoMinerario
from models import Usuario
from models import ProcessoMinerario


class CriarAtivoService:
    def executar(self, dados):

        id_usuario = dados.get("id_usuario")
        id_processo = dados.get("id_processo")
        descricao = dados.get("descricao", "")


        if not id_usuario:
            raise ValueError("O usuário é obrigatório.")

        if not id_processo:
            raise ValueError("O processo minerário é obrigatório.")

        usuario = Usuario.buscar_por_id(id_usuario)

        if usuario is None:
            raise ValueError("Usuário não encontrado.")
        
        if usuario.tipo_conta != "Titular":
            raise ValueError(
                "Somente titulares podem cadastrar ativos minerários."
            )

        processo = ProcessoMinerario.buscar_por_id(id_processo)

        if processo is None:
            raise ValueError("Processo minerário não encontrado.")

        ativo_existente = AtivoMinerario.buscar_por_usuario_processo(
            id_usuario, id_processo
        )

        if ativo_existente:
            raise ValueError("Este processo já está cadastrado na sua carteira.")

        ativo = AtivoMinerario(
            id_usuario=id_usuario, id_processo=id_processo, descricao=descricao
        )

        ativo.salvar()

        return ativo.to_dict()
