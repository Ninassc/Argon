from . import db


class Documento(db.Model):
    __tablename__ = "documento"

    id_documento = db.Column(
        db.Integer,
        primary_key=True,
    )

    id_ativo = db.Column(
        db.Integer,
        db.ForeignKey("ativo_minerario.id_ativo"),
        nullable=False,
    )

    nome_original = db.Column(
        db.String(255),
        nullable=False,
    )

    tipo_arquivo = db.Column(
        db.String(100),
        nullable=False,
    )

    tamanho = db.Column(
        db.Integer,
        nullable=False,
    )

    caminho_storage = db.Column(
        db.String(240),
        nullable=False,
        unique=True,
    )

    dt_cadastro = db.Column(
        db.DateTime,
        nullable=False,
        default=db.func.now(),
    )

    ativo = db.relationship(
        "AtivoMinerario",
        back_populates="documentos",
    )

    # CREATE
    def salvar(self):
        db.session.add(self)
        db.session.commit()

    # DELETE
    def deletar(self):
        db.session.delete(self)
        db.session.commit()

    # READ
    @classmethod
    def buscar_por_id(cls, id_documento):
        return cls.query.get(id_documento)

    @classmethod
    def listar_por_ativo(cls, id_ativo):
        return (
            cls.query.filter_by(id_ativo=id_ativo)
            .order_by(cls.dt_cadastro.desc())
            .all()
        )

    # JSON
    def to_dict(self):
        return {
            "id_documento": self.id_documento,
            "id_ativo": self.id_ativo,
            "nome_original": self.nome_original,
            "tipo_arquivo": self.tipo_arquivo,
            "tamanho": self.tamanho,
            "caminho_storage": self.caminho_storage,
            "dt_cadastro": (self.dt_cadastro.isoformat() if self.dt_cadastro else None),
        }
