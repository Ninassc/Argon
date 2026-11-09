import os
from pathlib import Path
from datetime import timedelta

from dotenv import load_dotenv


BASE_DIR = Path(__file__).resolve().parent

load_dotenv(BASE_DIR / ".env")


def _normalizar_database_url(url):

    if not url:
        raise RuntimeError(
            "DATABASE_URL não definida. Configure no arquivo .env "
            "(ex.: mysql://usuario:senha@zephyr.proxy.rlwy.net:14029/railway)."
        )

    if url.startswith("mysql://"):
        url = url.replace("mysql://", "mysql+pymysql://", 1)

    return url


class Config:
    SQLALCHEMY_DATABASE_URI = _normalizar_database_url(os.getenv("DATABASE_URL"))
    SQLALCHEMY_TRACK_MODIFICATIONS = False

    # Banco na nuvem derruba conexões ociosas: testa a conexão antes de usar
    # e renova as conexões antigas.
    SQLALCHEMY_ENGINE_OPTIONS = {
        "pool_pre_ping": True,
        "pool_recycle": 280,
        "connect_args": {"connect_timeout": 15},
    }

    JWT_SECRET_KEY = os.getenv(
        "JWT_SECRET_KEY",
        "argon_projeto_software_2026",
    )

    JWT_ACCESS_TOKEN_EXPIRES = timedelta(hours=8)