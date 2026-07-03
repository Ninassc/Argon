from models import ProcessoMinerario
from models import db


class ImportarProcessosANMService:

    def executar_importacao(self, processos):

        importados = 0
        atualizados = 0

        existentes = {
            processo.id_anm: processo
            for processo in ProcessoMinerario.query.all()
        }

        for dados in processos:

            id_anm = dados.get("id_anm")

            if not id_anm:
                continue

            processo = existentes.get(id_anm)

            if processo is None:

                processo = ProcessoMinerario(
                    processo=dados.get("processo"),
                    numero=dados.get("numero"),
                    ano=dados.get("ano"),
                    area_ha=dados.get("area_ha"),
                    id_anm=id_anm,
                    fase=dados.get("fase"),
                    ult_evento=dados.get("ult_evento"),
                    nome=dados.get("nome"),
                    subs=dados.get("subs"),
                    uso=dados.get("uso"),
                    uf=dados.get("uf"),
                    ds_processo=dados.get("ds_processo"),
                )

                processo.salvar()

                importados += 1

            else:

                processo.atualizar(
                    processo=dados.get("processo"),
                    numero=dados.get("numero"),
                    ano=dados.get("ano"),
                    area_ha=dados.get("area_ha"),
                    id_anm=id_anm,
                    fase=dados.get("fase"),
                    ult_evento=dados.get("ult_evento"),
                    nome=dados.get("nome"),
                    subs=dados.get("subs"),
                    uso=dados.get("uso"),
                    uf=dados.get("uf"),
                    ds_processo=dados.get("ds_processo"),
                )

                atualizados += 1

        try:
            db.session.commit()

        except Exception:
            db.session.rollback()
            raise

        return {
            "importados": importados,
            "atualizados": atualizados,
        }