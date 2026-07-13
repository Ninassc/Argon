from repositories import ProcessoMinerarioRepository


class BuscarDetalhesProcessoService:

    def executar(self, id_processo):

        resultado = ProcessoMinerarioRepository.buscar_detalhes(id_processo)

        if resultado is None:
            return None

        processo = {
            "id_processo": resultado["id_processo"],
            "processo": resultado["processo"],
            "numero": resultado["numero"],
            "ano": resultado["ano"],
            "area_ha": resultado["area_ha"],
            "id_anm": resultado["id_anm"],
            "fase": resultado["fase"],
            "ult_evento": resultado["ult_evento"],
            "nome": resultado["nome"],
            "subs": resultado["subs"],
            "uso": resultado["uso"],
            "uf": resultado["uf"],
            "ds_processo": resultado["ds_processo"],
            "ultima_atualizacao": (
                resultado["ultima_atualizacao"].isoformat()
                if resultado["ultima_atualizacao"]
                else None
            ),
        }

        ativo = None

        if resultado["id_ativo"] is not None:

            ativo = {
                "id_ativo": resultado["id_ativo"],
                "id_usuario": resultado["id_usuario"],
                "id_processo": resultado["id_processo"],
                "descricao": resultado["descricao"],
                "dt_cadastro": (
                    resultado["dt_cadastro"].isoformat()
                    if resultado["dt_cadastro"]
                    else None
                ),
                "usuario": {
                    "id_usuario": resultado["id_usuario"],
                    "nome": resultado["nome_usuario"],
                },
            }

        return {
            "processo": processo,
            "ativo": ativo,
        }
