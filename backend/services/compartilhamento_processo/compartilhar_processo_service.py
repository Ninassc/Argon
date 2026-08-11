from models import CompartilhamentoProcesso, ProcessoMinerario, Usuario
from repositories import UsuarioRepository

class CompartilharProcessoService:

    def executar(self, id_usuario_origem, id_processo, email):

        if not email:
            raise ValueError("O e-mail do usuário é obrigatório.")

        processo = ProcessoMinerario.buscar_por_id(id_processo)

        if processo is None:
            raise ValueError("Processo não encontrado.")

        usuario_destino = UsuarioRepository.buscar_por_email(email)

        if usuario_destino is None:
            raise ValueError("Usuário não encontrado.")

        if usuario_destino.id_usuario == id_usuario_origem:
            raise ValueError("Você não pode compartilhar um processo com você mesmo.")

        compartilhamento_existente = CompartilhamentoProcesso.buscar(
            id_usuario_origem,
            usuario_destino.id_usuario,
            id_processo,
        )

        if compartilhamento_existente:
            raise ValueError("Este processo já foi compartilhado com este usuário.")

        compartilhamento = CompartilhamentoProcesso.compartilhar(
            id_usuario_origem=id_usuario_origem,
            id_usuario_destino=usuario_destino.id_usuario,
            id_processo=id_processo,
        )

        return compartilhamento.to_dict()
