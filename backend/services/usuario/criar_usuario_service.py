from models import Usuario
from repositories import UsuarioRepository


class CriarUsuarioService:
    def executar(self, dados):
        nome = dados.get("nome")
        email = dados.get("email")
        telefone = dados.get("telefone")
        senha = dados.get("senha")
        tipo_conta = dados.get("tipo_conta")

        if not nome:
            raise ValueError("O nome é obrigatório")

        if not senha:
            raise ValueError("A senha é obrigatória")

        if not email and not telefone:
            raise ValueError("É necessário informar e-mail ou telefone.")

        if email and UsuarioRepository.buscar_por_email(email):
            raise ValueError("Já existe um usuário cadastrado com este e-mail.")

        if telefone and UsuarioRepository.buscar_por_telefone(telefone):
            raise ValueError("Já existe um usuário cadastrado com este telefone.")
        
        if not tipo_conta:
            raise ValueError("O tipo da conta é obrigatório.")
                
        usuario = Usuario(
            nome=nome,
            email=email,
            senha=senha,
            telefone=telefone,
            tipo_conta = tipo_conta
        )

        usuario.salvar()

        return usuario.to_dict()
