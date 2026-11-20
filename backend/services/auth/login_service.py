from flask_jwt_extended import create_access_token

from repositories import UsuarioRepository

from models import Usuario, db

# Keeps an unknown account on the same password-check path as a hashed account.
_USUARIO_INEXISTENTE = Usuario()
_USUARIO_INEXISTENTE.definir_senha("credencial indisponível")


class LoginService:

    def executar(self, dados):

        identificador = dados.get("identificador")
        senha = dados.get("senha")

        if not isinstance(identificador, str) or not 1 <= len(identificador) <= 150:
            raise ValueError("Credenciais inválidas.")

        usuario = UsuarioRepository.buscar_por_email_ou_telefone(
            email=identificador,
            telefone=identificador,
        )

        credencial = usuario if usuario is not None else _USUARIO_INEXISTENTE
        if not credencial.verificar_senha(senha) or usuario is None:
            raise ValueError("Credenciais inválidas.")

        id_usuario = usuario.id_usuario
        versao_credencial = usuario.versao_credencial()
        if not usuario.senha.startswith(Usuario.PREFIXO_HASH_SENHA):
            senha_anterior = usuario.senha
            novo_hash = Usuario()
            novo_hash.definir_senha(senha)
            atualizados = Usuario.query.filter_by(
                id_usuario=usuario.id_usuario, senha=senha_anterior
            ).update({Usuario.senha: novo_hash.senha}, synchronize_session=False)
            db.session.commit()
            if not atualizados:
                raise ValueError("Credenciais inválidas.")
            versao_credencial = novo_hash.versao_credencial()

        return {
            "token": self.emitir_token(id_usuario, versao_credencial),
            "usuario": usuario.to_dict(incluir_contato=True),
        }

    @staticmethod
    def emitir_token(id_usuario, versao_credencial):
        return create_access_token(
            identity=str(id_usuario),
            additional_claims={"credencial": versao_credencial},
        )
