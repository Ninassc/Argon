from hashlib import sha256
from hmac import compare_digest

from werkzeug.security import check_password_hash, generate_password_hash

from . import db


class Usuario(db.Model):
    __tablename__ = "usuario"
    PREFIXO_HASH_SENHA = "scrypt:"

    id_usuario = db.Column(db.Integer, primary_key=True)

    nome = db.Column(db.String(100), nullable=False)

    email = db.Column(db.String(150), unique=True, nullable=True)

    senha = db.Column(db.String(255), nullable=False)

    telefone = db.Column(db.String(20), unique=True, nullable=True)

    tipo_conta = db.Column(db.Enum("Titular", "Interessado"), nullable=False)

    dt_cadastro = db.Column(db.DateTime, server_default=db.func.now())

    ativos = db.relationship("AtivoMinerario", back_populates="usuario")

    favoritos = db.relationship(
        "Favorito", back_populates="usuario", cascade="all, delete-orphan"
    )

    acessos = db.relationship(
        "Acesso", back_populates="usuario", cascade="all, delete-orphan"
    )

    processos_compartilhados = db.relationship(
        "CompartilhamentoProcesso",
        foreign_keys="CompartilhamentoProcesso.id_usuario_origem",
        back_populates="usuario_origem",
        cascade="all, delete-orphan",
    )

    processos_recebidos = db.relationship(
        "CompartilhamentoProcesso",
        foreign_keys="CompartilhamentoProcesso.id_usuario_destino",
        back_populates="usuario_destino",
        cascade="all, delete-orphan",
    )
    

    # criar usuário
    def salvar(self):
        db.session.add(self)
        db.session.commit()

    # atualizar usuário
    def atualizar(
        self,
        nome=None,
        email=None,
        telefone=None,
        tipo_conta=None,
    ):
        if nome is not None:
            self.nome = nome

        if email is not None:
            self.email = email

        if telefone is not None:
            self.telefone = telefone

        if tipo_conta is not None:
            self.tipo_conta = tipo_conta

        db.session.commit()

    # excluir usuário
    def deletar(self):
        db.session.delete(self)
        db.session.commit()

    # consultas
    @classmethod
    def listar_todos(cls):
        return cls.query.order_by(cls.id_usuario.asc()).all()

    def definir_senha(self, senha):
        if not isinstance(senha, str) or not 1 <= len(senha) <= 255:
            raise ValueError("A senha deve ter entre 1 e 255 caracteres.")
        self.senha = generate_password_hash(senha, method="scrypt")

    def verificar_senha(self, senha):
        if not isinstance(senha, str) or not 1 <= len(senha) <= 255:
            return False
        if self.senha.startswith(self.PREFIXO_HASH_SENHA):
            return check_password_hash(self.senha, senha)
        return compare_digest(self.senha.encode("utf-8"), senha.encode("utf-8"))

    # Json
    def versao_credencial(self):
        return sha256(self.senha.encode("utf-8")).hexdigest()

    def to_dict(self, incluir_contato=False):
        dados = {
            "id_usuario": self.id_usuario,
            "nome": self.nome,
            "tipo_conta": self.tipo_conta,
            "dt_cadastro": (self.dt_cadastro.isoformat() if self.dt_cadastro else None),
        }
        if incluir_contato:
            dados.update(email=self.email, telefone=self.telefone)
        return dados
