from datetime import datetime

from models import db


class CompartilhamentoProcesso(db.Model):
    __tablename__ = "compartilhamento_processo"

    id_compartilhamento = db.Column(db.Integer, primary_key=True)

    id_usuario_origem = db.Column(
        db.Integer, db.ForeignKey("usuario.id_usuario"), nullable=False
    )

    id_usuario_destino = db.Column(
        db.Integer, db.ForeignKey("usuario.id_usuario"), nullable=False
    )

    id_processo = db.Column(
        db.Integer, db.ForeignKey("processo_minerario.id_processo"), nullable=False
    )

    dt_compartilhamento = db.Column(db.DateTime, default=datetime.now)

    usuario_origem = db.relationship(
        "Usuario",
        foreign_keys=[id_usuario_origem],
        back_populates="processos_compartilhados",
    )

    usuario_destino = db.relationship(
        "Usuario",
        foreign_keys=[id_usuario_destino],
        back_populates="processos_recebidos",
    )

    processo = db.relationship("ProcessoMinerario", back_populates="compartilhamentos")

    @classmethod
    def buscar(cls, id_usuario_origem, id_usuario_destino, id_processo):
        return cls.query.filter_by(
            id_usuario_origem=id_usuario_origem,
            id_usuario_destino=id_usuario_destino,
            id_processo=id_processo,
        ).first()

    @classmethod
    def compartilhar(cls, id_usuario_origem, id_usuario_destino, id_processo):
        compartilhamento = cls(
            id_usuario_origem=id_usuario_origem,
            id_usuario_destino=id_usuario_destino,
            id_processo=id_processo,
        )

        db.session.add(compartilhamento)
        db.session.commit()

        return compartilhamento

    @classmethod
    def listar_recebidos(cls, id_usuario):
        return (
            cls.query.filter_by(id_usuario_destino=id_usuario)
            .order_by(cls.dt_compartilhamento.desc())
            .all()
        )

    def remover(self):
        db.session.delete(self)
        db.session.commit()

    def to_dict(self):
        return {
            "id_compartilhamento": self.id_compartilhamento,
            "dt_compartilhamento": (
                self.dt_compartilhamento.isoformat()
                if self.dt_compartilhamento
                else None
            ),
            "usuario_origem": (
                self.usuario_origem.to_dict() if self.usuario_origem else None
            ),
            "processo": self.processo.to_dict() if self.processo else None,
        }
