import re
from datetime import datetime
import shutil
import zipfile
from pathlib import Path

import geopandas as gpd
import requests


class BuscarDadosANMService:

    URL_API = (
        "https://geo.anm.gov.br/arcgis/rest/services/"
        "SIGMINE/dados_anm/MapServer/0/query"
    )

    URL_SHAPEFILE = (
        "https://dadosabertos.anm.gov.br/" "SIGMINE/PROCESSOS_MINERARIOS/MG.zip"
    )

    def executar(self):
        try:
            print("Tentando consultar a API da ANM...")

            processos = self.buscar_pela_api()

            print("Fonte utilizada: API ArcGIS da ANM")

            return processos

        except (
            requests.exceptions.RequestException,
            ValueError,
        ) as erro:
            print(f"Falha ao consultar API: {erro}")
            print("Tentando buscar os dados pelo Shapefile...")

            processos = self.buscar_pelo_shapefile()

            print("Fonte utilizada: Shapefile da ANM")

            return processos

    def buscar_ids(self):
        params = {
            "where": "UF='MG'",
            "returnIdsOnly": "true",
            "f": "json",
        }

        resposta = requests.get(
            self.URL_API,
            params=params,
            timeout=60,
        )

        resposta.raise_for_status()

        dados = resposta.json()

        if "error" in dados:
            raise ValueError(
                dados["error"].get(
                    "message",
                    "Erro retornado pela API da ANM.",
                )
            )

        return dados.get("objectIds", [])

    def buscar_pela_api(self):
        ids = self.buscar_ids()

        print(f"Total de IDs encontrados: {len(ids)}")

        tamanho_bloco = 1000
        processos_unicos = {}

        for i in range(0, len(ids), tamanho_bloco):
            bloco = ids[i : i + tamanho_bloco]

            print(f"Buscando registros " f"{i + 1} até {i + len(bloco)}...")

            params = {
                "objectIds": ",".join(map(str, bloco)),
                "outFields": "*",
                "returnGeometry": "false",
                "f": "json",
            }

            resposta = requests.get(
                self.URL_API,
                params=params,
                timeout=60,
            )

            resposta.raise_for_status()

            dados = resposta.json()

            if "error" in dados:
                raise ValueError(
                    dados["error"].get(
                        "message",
                        "Erro ao buscar registros da ANM.",
                    )
                )

            features = dados.get("features", [])

            print(f"Lote recebido: {len(features)} registros")

            for feature in features:
                atributos = feature.get("attributes", {})

                processo = atributos.get("PROCESSO")

                if not processo:
                    continue

                if processo in processos_unicos:
                    continue

                texto_ult_evento = atributos.get("ULT_EVENTO")
                dt_ult_evento = self.extrair_data_ultimo_evento(texto_ult_evento)

                processos_unicos[processo] = {
                    "id_anm": atributos.get("ID"),
                    "processo": processo,
                    "numero": atributos.get("NUMERO"),
                    "ano": atributos.get("ANO"),
                    "area_ha": atributos.get("AREA_HA"),
                    "fase": atributos.get("FASE"),
                    "ult_evento": texto_ult_evento,
                    "dt_ult_evento": dt_ult_evento,
                    "nome": atributos.get("NOME"),
                    "subs": atributos.get("SUBS"),
                    "uso": atributos.get("USO"),
                    "uf": atributos.get("UF"),
                    "ds_processo": atributos.get("DSProcesso"),
                }

        print(f"\nTotal de processos únicos: " f"{len(processos_unicos)}")

        return list(processos_unicos.values())

    @staticmethod
    def extrair_data_ultimo_evento(texto_ult_evento):
        if not texto_ult_evento:
            return None

        encontrado = re.search(
            r"\d{2}/\d{2}/\d{4}",
            texto_ult_evento,
        )

        if not encontrado:
            return None

        return datetime.strptime(
            encontrado.group(),
            "%d/%m/%Y",
        ).date()

    @staticmethod
    def normalizar_valor(valor):
        if valor is None:
            return None

        try:
            if valor != valor:
                return None
        except TypeError:
            pass

        if isinstance(valor, str):
            valor = valor.strip()

            return valor if valor else None

        return valor

    def baixar_shapefile(self):
        pasta = (
            Path(__file__).resolve().parents[2]
            / "temp"
            / "anm_mg"
        )

        if pasta.exists():
            shutil.rmtree(pasta)

        pasta.mkdir(parents=True)

        arquivo_zip = pasta / "anm.zip"

        print("Baixando Shapefile da ANM...")

        resposta = requests.get(
            self.URL_SHAPEFILE,
            timeout=300,
            stream=True,
        )

        resposta.raise_for_status()

        with open(arquivo_zip, "wb") as arquivo:
            for bloco in resposta.iter_content(8192):
                if bloco:
                    arquivo.write(bloco)

        print("Download concluído.")

        with zipfile.ZipFile(arquivo_zip, "r") as zip_ref:
            zip_ref.extractall(pasta)

        arquivo_zip.unlink()

        print("Shapefile extraído.")

        return pasta

    def buscar_pelo_shapefile(self):
        pasta_temporaria = self.baixar_shapefile()

        caminho_shp = pasta_temporaria / "MG.shp"

        if not caminho_shp.exists():
            raise FileNotFoundError(f"Shapefile não encontrado em: {caminho_shp}")

        print(f"Lendo Shapefile: {caminho_shp}")

        dados = gpd.read_file(
            caminho_shp,
            engine="pyogrio",
        )

        print(f"Registros encontrados no arquivo: {len(dados)}")

        processos_unicos = {}

        for _, linha in dados.iterrows():
            processo = self.normalizar_valor(linha.get("PROCESSO"))

            if not processo:
                continue

            if processo in processos_unicos:
                continue

            texto_ult_evento = self.normalizar_valor(linha.get("ULT_EVENTO"))

            dt_ult_evento = self.extrair_data_ultimo_evento(texto_ult_evento)

            processos_unicos[processo] = {
                "id_anm": self.normalizar_valor(linha.get("ID")),
                "processo": processo,
                "numero": self.normalizar_valor(linha.get("NUMERO")),
                "ano": self.normalizar_valor(linha.get("ANO")),
                "area_ha": self.normalizar_valor(linha.get("AREA_HA")),
                "fase": self.normalizar_valor(linha.get("FASE")),
                "ult_evento": texto_ult_evento,
                "dt_ult_evento": dt_ult_evento,
                "nome": self.normalizar_valor(linha.get("NOME")),
                "subs": self.normalizar_valor(linha.get("SUBS")),
                "uso": self.normalizar_valor(linha.get("USO")),
                "uf": self.normalizar_valor(linha.get("UF")),
                "ds_processo": self.normalizar_valor(linha.get("DSProcesso")),
            }

        print(
            "Total de processos únicos obtidos pelo Shapefile: "
            f"{len(processos_unicos)}"
        )

        resultado = list(processos_unicos.values())

        shutil.rmtree(pasta_temporaria)

        return resultado