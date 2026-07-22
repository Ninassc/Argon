from repositories import UsuarioRepository


class AlterarSenhaService:

    def executar(self, id_usuario, dados):

        usuario = UsuarioRepository.buscar_por_id(id_usuario)

        if usuario is None:
            raise ValueError("Usuário não encontrado.")

        senha_atual = dados.get("senha_atual")
        nova_senha = dados.get("nova_senha")
        confirmar_senha = dados.get("confirmar_senha")

        if not senha_atual:
            raise ValueError("Informe a senha atual.")

        if not nova_senha:
            raise ValueError("Informe a nova senha.")

        if not confirmar_senha:
            raise ValueError("Confirme a nova senha.")

        if nova_senha != confirmar_senha:
            raise ValueError("As senhas não coincidem.")

        usuario.atualizar(senha=nova_senha)
