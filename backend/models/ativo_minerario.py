from . import db


class AtivoMinerario(db.Model):
    __tablename__ = "ativo_minerario"

    id_ativo = db.Column(db.Integer, primary_key=True)

    id_usuario = db.Column(
        db.Integer, db.ForeignKey("usuario.id_usuario"), nullable=False
    )

    id_processo = db.Column(
        db.Integer, db.ForeignKey("processo_minerario.id_processo"), nullable=False
    )

    descricao = db.Column(db.Text)

    dt_cadastro = db.Column(db.DateTime, nullable=False, default=db.func.now())

    usuario = db.relationship("Usuario", back_populates="ativos")

    processo = db.relationship("ProcessoMinerario", back_populates="ativos")

    # CREATE
    def salvar(self):
        db.session.add(self)
        db.session.commit()

    # UPDATE
    def atualizar(self, descricao=None):
        if descricao is not None:
            self.descricao = descricao

        db.session.commit()

    # DELETE
    def deletar(self):
        db.session.delete(self)
        db.session.commit()

    # READ
    # @classmethod
    # def listar_todos(cls):
    #     return cls.query.order_by(cls.id_ativo.asc()).all()

    @classmethod
    def buscar_por_id(cls, id_ativo):
        return cls.query.get(id_ativo)

    @classmethod
    def buscar_por_usuario(cls, id_usuario):
        return (
            cls.query.filter_by(id_usuario=id_usuario)
            .order_by(cls.dt_cadastro.desc())
            .all()
        )

    @classmethod
    def buscar_por_usuario_processo(cls, id_usuario, id_processo):
        return cls.query.filter_by(
            id_usuario=id_usuario, id_processo=id_processo
        ).first()

    @classmethod
    def buscar_por_usuario_ativo(cls, id_usuario, id_ativo):
        return cls.query.filter_by(id_usuario=id_usuario, id_ativo=id_ativo).first()

    # JSON
    def to_dict(self):
        return {
            "id_ativo": self.id_ativo,
            "id_usuario": self.id_usuario,
            "id_processo": self.id_processo,
            "descricao": self.descricao,
            "dt_cadastro": (self.dt_cadastro.isoformat() if self.dt_cadastro else None),
        }
