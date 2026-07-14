import requests
import re
from datetime import datetime


class BuscarDadosANMService:

    def buscar_ids(self):

        url = "https://geo.anm.gov.br/arcgis/rest/services/SIGMINE/dados_anm/MapServer/0/query"

        params = {
            "where": "UF='MG'",
            "returnIdsOnly": "true",
            "f": "json",
        }

        resposta = requests.get(url, params=params, timeout=60)
        resposta.raise_for_status()

        dados = resposta.json()

        return dados.get("objectIds", [])

    def executar(self):

        url = "https://geo.anm.gov.br/arcgis/rest/services/SIGMINE/dados_anm/MapServer/0/query"

        ids = self.buscar_ids()

        print(f"Total de IDs encontrados: {len(ids)}")

        tamanho_bloco = 1000

        # Guarda apenas um registro para cada PROCESSO
        processos_unicos = {}

        for i in range(0, len(ids), tamanho_bloco):

            bloco = ids[i : i + tamanho_bloco]

            print(f"Buscando registros {i + 1} até {i + len(bloco)}...")

            params = {
                "objectIds": ",".join(map(str, bloco)),
                "outFields": "*",
                "returnGeometry": "false",
                "f": "json",
            }

            resposta = requests.get(url, params=params, timeout=60)
            resposta.raise_for_status()

            dados = resposta.json()

            features = dados.get("features", [])

            print(f"Lote recebido: {len(features)} registros")

            for feature in features:

                atributos = feature.get("attributes", {})

                processo = atributos.get("PROCESSO")

                # Se já existe, ignora
                if processo in processos_unicos:
                    continue

                texto_ult_evento = atributos.get("ULT_EVENTO")

                dt_ult_evento = None

                if texto_ult_evento:
                    encontrado = re.search(r"\d{2}/\d{2}/\d{4}", texto_ult_evento)

                    if encontrado:
                        dt_ult_evento = datetime.strptime(
                            encontrado.group(), "%d/%m/%Y"
                        ).date()

                processos_unicos[processo] = {
                    "id_anm": atributos.get("ID"),
                    "processo": processo,
                    "numero": atributos.get("NUMERO"),
                    "ano": atributos.get("ANO"),
                    "area_ha": atributos.get("AREA_HA"),
                    "fase": atributos.get("FASE"),
                    "ult_evento": atributos.get("ULT_EVENTO"),
                    "dt_ult_evento": dt_ult_evento,
                    "nome": atributos.get("NOME"),
                    "subs": atributos.get("SUBS"),
                    "uso": atributos.get("USO"),
                    "uf": atributos.get("UF"),
                    "ds_processo": atributos.get("DSProcesso"),
                }

        print(f"\nTotal de processos únicos: {len(processos_unicos)}")

        return list(processos_unicos.values())
