from datetime import datetime

from models import db


class Acesso(db.Model):
    __tablename__ = "acesso"

    id_acesso = db.Column(db.Integer, primary_key=True)

    id_usuario = db.Column(
        db.Integer, db.ForeignKey("usuario.id_usuario"), nullable=False
    )

    id_ativo = db.Column(
        db.Integer, db.ForeignKey("ativo_minerario.id_ativo"), nullable=False
    )

    status = db.Column(db.String(20), nullable=False, default="pendente")

    origem = db.Column(db.String(20), nullable=False, default="solicitacao")

    dt_solicitacao = db.Column(db.DateTime, default=datetime.now)

    dt_acesso = db.Column(db.DateTime, nullable=True)

    usuario = db.relationship("Usuario", back_populates="acessos")

    ativo = db.relationship("AtivoMinerario", back_populates="acessos")

    @classmethod
    def buscar(cls, id_usuario, id_ativo):
        return cls.query.filter_by(id_usuario=id_usuario, id_ativo=id_ativo).first()

    @classmethod
    def criar_compartilhamento(cls, id_usuario, id_ativo):
        acesso = cls(
            id_usuario=id_usuario,
            id_ativo=id_ativo,
            status="aprovado",
            origem="compartilhamento",
            dt_acesso=datetime.now(),
        )

        db.session.add(acesso)
        db.session.commit()

        return acesso

    def remover(self):
        db.session.delete(self)
        db.session.commit()

    def to_dict(self):
        return {
            "id_acesso": self.id_acesso,
            "id_usuario": self.id_usuario,
            "id_ativo": self.id_ativo,
            "status": self.status,
            "origem": self.origem,
            "dt_solicitacao": (
                self.dt_solicitacao.isoformat() if self.dt_solicitacao else None
            ),
            "dt_acesso": (self.dt_acesso.isoformat() if self.dt_acesso else None),
        }
