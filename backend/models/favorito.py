from models import db


class Favorito(db.Model):
    __tablename__ = "favorito"

    id_favorito = db.Column(db.Integer, primary_key=True)

    id_usuario = db.Column(
        db.Integer, db.ForeignKey("usuario.id_usuario"), nullable=False
    )

    id_processo = db.Column(
        db.Integer, db.ForeignKey("processo_minerario.id_processo"), nullable=False
    )

    dt_favorito = db.Column(db.DateTime, server_default=db.func.now())

    usuario = db.relationship("Usuario", back_populates="favoritos")

    processo = db.relationship("ProcessoMinerario", back_populates="favoritos")

    @staticmethod
    def existe(id_usuario, id_processo):
        favorito = Favorito.query.filter_by(
            id_usuario=id_usuario,
            id_processo=id_processo
        ).first()

        return favorito

    @staticmethod
    def criar(id_usuario, id_processo):

        favorito = Favorito(id_usuario=id_usuario, id_processo=id_processo)

        db.session.add(favorito)
        db.session.commit()

        return favorito

    @staticmethod
    def deletar(id_usuario, id_processo):

        favorito = Favorito.existe(id_usuario, id_processo)

        if favorito:
            db.session.delete(favorito)
            db.session.commit()

        return favorito

    @staticmethod
    def listar_usuario(id_usuario):

        return Favorito.query.filter_by(id_usuario=id_usuario).all()

    def to_dict(self):
        return {
            "id_favorito": self.id_favorito,
            "dt_favorito": self.dt_favorito.isoformat() if self.dt_favorito else None,
            "processo": self.processo.to_dict() if self.processo else None,
        }
