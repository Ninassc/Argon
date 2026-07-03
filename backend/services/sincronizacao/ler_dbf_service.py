from dbfread import DBF

class LerDBFService:
 
    def executar(self, caminho_arquivo):
        """
        Recebe o caminho de um arquivo .dbf,
        lê os registros e os transforma em
        uma lista de dicionários.
 
        Retorno esperado:
            [
                {
                    "id_anm": "...",
                    "processo": "...",
                    ...
                }
            ]
        """
        tabela = DBF(caminho_arquivo, encoding="utf-8", load=True)
 
        return [
            {
                "id_anm": registro.get("ID"),
                "processo": registro.get("PROCESSO"),
                "numero": registro.get("NUMERO"),
                "ano": registro.get("ANO"),
                "area_ha": registro.get("AREA_HA"),
                "fase": registro.get("FASE"),
                "ult_evento": registro.get("ULT_EVENTO"),
                "nome": registro.get("NOME"),
                "subs": registro.get("SUBS"),
                "uso": registro.get("USO"),
                "uf": registro.get("UF"),
                "ds_processo": registro.get("DSProcesso"),
            }
            for registro in tabela
        ] #acho que era pra fazer isso
