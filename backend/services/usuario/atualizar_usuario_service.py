from models.usuario import Usuario


class AtualizarUsuarioService:
    def executar(self, usuario_id, dados):
        usuario = Usuario.buscar_por_id(usuario_id)

        if usuario is None:
            return None

        novo_email = dados.get("email")
        novo_telefone = dados.get("telefone")
        tipo_conta = dados.get("tipo_conta")

        email_final = novo_email if novo_email is not None else usuario.email

        telefone_final = (
            novo_telefone if novo_telefone is not None else usuario.telefone
        )

        if not email_final and not telefone_final:
            raise ValueError("O usuário deve possuir e-mail ou telefone.")

        if novo_email:
            usuario_email = Usuario.buscar_por_email(novo_email)

            if usuario_email and usuario_email.id_usuario != usuario.id_usuario:
                raise ValueError("Já existe um usuário cadastrado com este e-mail.")

        if novo_telefone:
            usuario_telefone = Usuario.buscar_por_telefone(novo_telefone)

            if usuario_telefone and usuario_telefone.id_usuario != usuario.id_usuario:
                raise ValueError("Já existe um usuário cadastrado com este telefone.")

        usuario.atualizar(
            nome=dados.get("nome"),
            email=novo_email,
            telefone=novo_telefone,
            senha=dados.get("senha"),
            tipo_conta=tipo_conta,
        )

        return usuario.to_dict()
