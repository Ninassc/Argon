from datetime import datetime

from models import db
from models import AtivoMinerario


class Acesso(db.Model):
    __tablename__ = "acesso"

    id_acesso = db.Column(db.Integer, primary_key=True)

    id_usuario = db.Column(
        db.Integer,
        db.ForeignKey("usuario.id_usuario"),
        nullable=False,
    )

    id_ativo = db.Column(
        db.Integer,
        db.ForeignKey("ativo_minerario.id_ativo"),
        nullable=False,
    )

    status = db.Column(
        db.String(20),
        nullable=False,
        default="pendente",
    )

    origem = db.Column(
        db.String(20),
        nullable=False,
        default="solicitacao",
    )

    dt_solicitacao = db.Column(
        db.DateTime,
        default=datetime.now,
    )

    dt_acesso = db.Column(
        db.DateTime,
        nullable=True,
    )

    usuario = db.relationship(
        "Usuario",
        back_populates="acessos",
    )

    ativo = db.relationship(
        "AtivoMinerario",
        back_populates="acessos",
    )

    @classmethod
    def buscar(cls, id_usuario, id_ativo):
        return cls.query.filter_by(
            id_usuario=id_usuario,
            id_ativo=id_ativo,
        ).first()

    @classmethod
    def criar_solicitacao(cls, id_usuario, id_ativo):
        acesso = cls(
            id_usuario=id_usuario,
            id_ativo=id_ativo,
            status="pendente",
            origem="solicitacao",
        )

        db.session.add(acesso)
        db.session.commit()

        return acesso

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

    def aprovar(self):
        self.status = "aprovado"
        self.dt_acesso = datetime.now()

        db.session.commit()

        return self

    def recusar(self):
        self.status = "recusado"
        self.dt_acesso = None

        db.session.commit()

        return self

    def remover(self):
        db.session.delete(self)
        db.session.commit()

    @classmethod
    def listar_solicitacoes_recebidas(cls, id_proprietario):
        return (
            cls.query.join(AtivoMinerario)
            .filter(
                AtivoMinerario.id_usuario == id_proprietario,
                cls.status == "pendente",
                cls.origem == "solicitacao",
            )
            .order_by(cls.dt_solicitacao.desc())
            .all()
        )

    @classmethod
    def listar_historico_recebido(cls, id_proprietario):
        return (
            cls.query.join(AtivoMinerario)
            .filter(
                AtivoMinerario.id_usuario == id_proprietario,
                cls.status.in_(["aprovado", "recusado"]),
                cls.origem == "solicitacao",
            )
            .order_by(cls.dt_solicitacao.desc())
            .all()
        )

    @classmethod
    def listar_enviadas(cls, id_usuario):
        return (
            cls.query.filter(
                cls.id_usuario == id_usuario,
                cls.origem == "solicitacao",
            )
            .order_by(cls.dt_solicitacao.desc())
            .all()
        )

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
            "usuario": (self.usuario.to_dict() if self.usuario else None),
            "ativo": (self.ativo.to_dict() if self.ativo else None),
        }
