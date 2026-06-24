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

    ativos = db.relationship('AtivoMinerario', back_populates='processo')
