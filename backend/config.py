import os
from dotenv import load_dotenv
from datetime import timedelta

load_dotenv()

class Config:
    SQLALCHEMY_DATABASE_URI = os.getenv("DATABASE_URL")
    SQLALCHEMY_TRACK_MODIFICATIONS = False

    JWT_SECRET_KEY = "argon_projeto_software_2026"
    JWT_ACCESS_TOKEN_EXPIRES = timedelta(hours=8) #Apenas para desenvolvimento (APAGAR ISSO DEPOIS)