from . import db


class Usuario(db.Model):
    __tablename__ = "usuario"

    id_usuario = db.Column(db.Integer, primary_key=True)

    nome = db.Column(db.String(100), nullable=False)

    email = db.Column(db.String(150), unique=True)

    senha = db.Column(db.String(255), nullable=False)

    telefone = db.Column(db.String(20), unique=True)

    dt_cadastro = db.Column(db.DateTime, server_default=db.func.now())

    ativos = db.relationship("AtivoMinerario", back_populates="usuario")

    # criar usuário
    def salvar(self):
        db.session.add(self)
        db.session.commit()

    # atualizar usuário
    def atualizar(self, nome=None, email=None, senha=None, telefone=None):
        if nome is not None:
            self.nome = nome

        if email is not None:
            self.email = email

        if senha is not None:
            self.senha = senha

        if telefone is not None:
            self.telefone = telefone

        db.session.commit()

    # excluir usuário
    def deletar(self):
        db.session.delete(self)
        db.session.commit()

    # consultas
    @classmethod
    def listar_todos(cls):
        return cls.query.order_by(cls.id_usuario.asc()).all()

    @classmethod
    def buscar_por_id(cls, id_usuario):
        return cls.query.get(id_usuario)

    @classmethod
    def buscar_por_email(cls, email):
        return cls.query.filter_by(email=email).first()

    @classmethod
    def buscar_por_telefone(cls, telefone):
        return cls.query.filter_by(telefone=telefone).first()

    # Json
    def to_dict(self):
        return {
            "id_usuario": self.id_usuario,
            "nome": self.nome,
            "email": self.email,
            "telefone": self.telefone,
            "dt_cadastro": (self.dt_cadastro.isoformat() if self.dt_cadastro else None),
        }
