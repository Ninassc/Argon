from flask_sqlalchemy import SQLAlchemy

db = SQLAlchemy()

from .usuario import Usuario
from .processo_minerario import ProcessoMinerario
from .ativo_minerario import AtivoMinerario
from .favorito import Favorito

__all__ = [
    "db",
    "Usuario",
    "ProcessoMinerario",
    "AtivoMinerario",
    "Favorito"
]