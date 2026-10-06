import uuid
from pathlib import Path

from flask import current_app
from supabase import create_client


class StorageService:
    def __init__(self):
        self.supabase = create_client(
            current_app.config["SUPABASE_URL"],
            current_app.config["SUPABASE_SECRET_KEY"],
        )

        self.bucket = current_app.config["SUPABASE_BUCKET"]

    def upload(self, arquivo, id_ativo):
        extensao = Path(arquivo.filename).suffix.lower()

        nome_unico = f"{uuid.uuid4()}{extensao}"
        caminho = f"ativos/{id_ativo}/{nome_unico}"

        conteudo = arquivo.read()

        self.supabase.storage.from_(self.bucket).upload(
            path=caminho,
            file=conteudo,
            file_options={
                "content-type": arquivo.content_type,
            },
        )

        return caminho
