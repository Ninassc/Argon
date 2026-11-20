from models import Usuario, db
from services.auth.login_service import LoginService


class AlterarSenhaService:

    def executar(self, id_usuario, dados):

        usuario = (
            Usuario.query.filter_by(id_usuario=id_usuario)
            .populate_existing()
            .with_for_update()
            .one_or_none()
        )

        if usuario is None:
            raise ValueError("Usuário não encontrado.")

        senha_atual = dados.get("senha_atual")
        nova_senha = dados.get("nova_senha")
        confirmar_senha = dados.get("confirmar_senha")

        if not usuario.verificar_senha(senha_atual):
            raise ValueError("Senha atual incorreta.")

        if not nova_senha:
            raise ValueError("Informe a nova senha.")

        if not confirmar_senha:
            raise ValueError("Confirme a nova senha.")

        if nova_senha != confirmar_senha:
            raise ValueError("As senhas não coincidem.")

        usuario.definir_senha(nova_senha)
        token = LoginService.emitir_token(usuario.id_usuario, usuario.versao_credencial())
        db.session.commit()
        return token
