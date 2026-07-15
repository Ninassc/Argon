from repositories import UsuarioRepository
from flask_jwt_extended import create_access_token


class LoginService:

    def executar(self, dados):

        identificador = dados.get("identificador")
        senha = dados.get("senha")

        if not identificador:
            raise ValueError("Informe o e-mail ou telefone.")

        if not senha:
            raise ValueError("Informe a senha.")

        usuario = UsuarioRepository.buscar_por_email_ou_telefone(
            email=identificador,
            telefone=identificador,
        )

        if usuario is None:
            raise ValueError("Usuário não encontrado.")

        if usuario.senha != senha:
            raise ValueError("Senha incorreta.")

        token = create_access_token(identity=str(usuario.id_usuario))

        return {
            "token": token,
            "usuario": usuario.to_dict(),
        }
