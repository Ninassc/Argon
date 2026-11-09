from models import ProcessoMinerario
from models import db


CAMPOS = [
    "processo",
    "numero",
    "ano",
    "area_ha",
    "id_anm",
    "fase",
    "ult_evento",
    "nome",
    "subs",
    "uso",
    "uf",
    "ds_processo",
]

TAMANHO_LOTE = 1000


class ImportarProcessosANMService:

    def executar_importacao(self, processos):

        importados = 0
        atualizados = 0

        existentes = {
            processo.id_anm: processo
            for processo in ProcessoMinerario.query.all()
        }

        novos = []
        ids_vistos = set()

        for dados in processos:

            id_anm = dados.get("id_anm")

            if not id_anm or id_anm in ids_vistos:
                continue

            ids_vistos.add(id_anm)

            processo = existentes.get(id_anm)

            if processo is None:

                registro = {campo: dados.get(campo) for campo in CAMPOS}
                registro["dt_ult_evento"] = dados.get("dt_ult_evento")

                novos.append(registro)

            else:

                # Só mexe no que realmente mudou: evita milhares de UPDATEs
                # desnecessários a cada sincronização.
                mudou = any(
                    dados.get(campo) is not None
                    and getattr(processo, campo) != dados.get(campo)
                    for campo in CAMPOS
                )

                if mudou:
                    processo.atualizar(
                        **{campo: dados.get(campo) for campo in CAMPOS}
                    )

                    atualizados += 1

        try:
            # Atualizações dos processos já existentes
            db.session.flush()

            # Inserções em lote (uma instrução SQL por lote, e não uma por
            # processo), com commit a cada lote e progresso na tela.
            total = len(novos)

            for inicio in range(0, total, TAMANHO_LOTE):
                lote = novos[inicio:inicio + TAMANHO_LOTE]

                db.session.bulk_insert_mappings(ProcessoMinerario, lote)
                db.session.commit()

                importados += len(lote)

                print(f"Gravados {importados} de {total} processos novos...")

            db.session.commit()

        except Exception:
            db.session.rollback()
            raise

        return {
            "importados": importados,
            "atualizados": atualizados,
        }