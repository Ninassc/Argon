from . import db

class AtivoMinerario(db.Model):
    __tablename__ = "ativo_minerario"

    id_ativo = db.Column(
        db.Integer,
        primary_key=True
    )

    id_usuario = db.Column(
        db.Integer,
        db.ForeignKey("usuario.id_usuario"),
        nullable=False
    )

    id_processo = db.Column(
        db.Integer,
        db.ForeignKey("processo_minerario.id_processo"),
        nullable=False
    )

    descricao = db.Column(
        db.Text
    )

    dt_cadastro = db.Column(
        db.DateTime,
        nullable=False,
        default=db.func.now()
    )

    usuario = db.relationship(
        "Usuario",
        back_populates="ativos"
    )

    processo = db.relationship(
        "ProcessoMinerario",
        back_populates="ativos"
    )