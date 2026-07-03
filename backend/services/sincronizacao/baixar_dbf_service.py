import requests

url = "https://geo.anm.gov.br/arcgis/rest/services/SIGMINE/dados_anm/MapServer/0/query"

params = {
    "where": "1=1",
    "outFields": "*",
    "returnGeometry": False,
    "f": "json"
}

r = requests.get(url, params=params, timeout=60)
r.raise_for_status()

dados = r.json()

print(f"Total recebido: {len(dados['features'])}")
print()

for i, feature in enumerate(dados["features"][:1000], start=1):#todos = 5000 / colocar filtro UF = MG
    
    print(f"Registro {i}")
    for campo, valor in feature["attributes"].items():
        print(f"{campo}: {valor}")
    print("-" * 50)
