from . import db


class ProcessoMinerario(db.Model):
    __tablename__ = "processo_minerario"

    id_processo = db.Column(db.Integer, primary_key=True)

    processo = db.Column(db.String(20))

    numero = db.Column(db.String(20))

    ano = db.Column(db.String(10))

    area_ha = db.Column(db.String(30))

    id_anm = db.Column(db.String(50))

    fase = db.Column(db.String(100))

    ult_evento = db.Column(db.Text)

    nome = db.Column(db.String(150))

    subs = db.Column(db.String(100))

    uso = db.Column(db.String(100))

    uf = db.Column(db.String(5))

    ds_processo = db.Column(db.String(20))

    ultima_atualizacao = db.Column(db.DateTime, nullable=False, default=db.func.now())

    ativos = db.relationship("AtivoMinerario", back_populates="processo")

    # CREATE
    def salvar(self):
        db.session.add(self)

    # UPDATE
    def atualizar(
        self,
        processo=None,
        numero=None,
        ano=None,
        area_ha=None,
        id_anm=None,
        fase=None,
        ult_evento=None,
        nome=None,
        subs=None,
        uso=None,
        uf=None,
        ds_processo=None,
    ):
        if processo is not None:
            self.processo = processo

        if numero is not None:
            self.numero = numero

        if ano is not None:
            self.ano = ano

        if area_ha is not None:
            self.area_ha = area_ha

        if id_anm is not None:
            self.id_anm = id_anm

        if fase is not None:
            self.fase = fase

        if ult_evento is not None:
            self.ult_evento = ult_evento

        if nome is not None:
            self.nome = nome

        if subs is not None:
            self.subs = subs

        if uso is not None:
            self.uso = uso

        if uf is not None:
            self.uf = uf

        if ds_processo is not None:
            self.ds_processo = ds_processo

        self.ultima_atualizacao = db.func.now()

    # DELETE
    def deletar(self):
        db.session.delete(self)
        db.session.commit()

    # READ
    @classmethod
    def listar_todos(cls):
        return cls.query.order_by(cls.id_processo.asc()).all()

    @classmethod
    def listar_paginado(cls, pagina, limite):

        return cls.query.order_by(cls.ult_evento.desc()).paginate(
            page=pagina, per_page=limite
        )

    @classmethod
    def buscar_por_id(cls, id_processo):
        return cls.query.get(id_processo)

    @classmethod
    def buscar_por_id_anm(cls, id_anm):
        return cls.query.filter_by(id_anm=id_anm).first()

    @classmethod
    def pesquisar(cls, termo, pagina, limite):

        return (
            cls.query.filter(
                db.or_(
                    cls.processo.ilike(f"%{termo}%"),
                    cls.nome.ilike(f"%{termo}%"),
                    cls.subs.ilike(f"%{termo}%"),
                )
            )
            .order_by(cls.id_processo.desc())
            .paginate(
                page=pagina,
                per_page=limite,
            )
        )

    # JSON
    def to_dict(self):
        return {
            "id_processo": self.id_processo,
            "processo": self.processo,
            "numero": self.numero,
            "ano": self.ano,
            "area_ha": self.area_ha,
            "id_anm": self.id_anm,
            "fase": self.fase,
            "ult_evento": self.ult_evento,
            "nome": self.nome,
            "subs": self.subs,
            "uso": self.uso,
            "uf": self.uf,
            "ds_processo": self.ds_processo,
            "ultima_atualizacao": (
                self.ultima_atualizacao.isoformat() if self.ultima_atualizacao else None
            ),
        }
