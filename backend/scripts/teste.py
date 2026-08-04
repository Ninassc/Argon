from pathlib import Path
import geopandas as gpd

backend = Path(__file__).resolve().parents[1]
arquivo_shp = backend / "temp" / "anm_mg" / "MG.shp"

print("CAMINHO:", arquivo_shp)
print("EXISTE:", arquivo_shp.exists())

dados = gpd.read_file(arquivo_shp)

print(dados.columns.tolist())
print(dados.iloc[0].to_dict())