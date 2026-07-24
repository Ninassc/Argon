from sqlalchemy import text
from sqlalchemy import func

from models import db, ProcessoMinerario, AtivoMinerario


class ProcessoMinerarioRepository:

    @staticmethod
    def listar_paginado(pagina, limite, fase=None, substancia=None):

        banco = db.session.get_bind().dialect.name

        if banco == "mysql":

            offset = (pagina - 1) * limite

            resultado = db.session.execute(
                text("CALL sp_listar_processos(:limite, :offset, :fase, :substancia)"),
                {
                    "limite": limite,
                    "offset": offset,
                    "fase": fase,
                    "substancia": substancia,
                },
            )

            linhas = resultado.mappings().all()
            resultado.close()

            resultado = db.session.execute(
                text("CALL sp_total_processos(:fase, :substancia)"),
                {
                    "fase": fase,
                    "substancia": substancia,
                },
            )

            total = resultado.mappings().first()["total"]
            resultado.close()

            total_paginas = (total + limite - 1) // limite

            processos = [ProcessoMinerario(**dict(linha)) for linha in linhas]

            return {
                "pagina": pagina,
                "total": total,
                "total_paginas": total_paginas,
                "processos": processos,
            }

        paginacao = ProcessoMinerario.query.order_by(
            ProcessoMinerario.id_processo.desc()
        ).paginate(
            page=pagina,
            per_page=limite,
        )

        return {
            "pagina": paginacao.page,
            "total": paginacao.total,
            "total_paginas": paginacao.pages,
            "processos": paginacao.items,
        }

    @staticmethod
    def pesquisar(termo, pagina, limite, fase=None, substancia=None):

        banco = db.session.get_bind().dialect.name

        if banco == "mysql":

            offset = (pagina - 1) * limite

            resultado = db.session.execute(
                text(
                    "CALL sp_pesquisar_processos(:termo, :limite, :offset, :fase, :substancia)"
                ),
                {
                    "termo": termo,
                    "limite": limite,
                    "offset": offset,
                    "fase": fase,
                    "substancia": substancia,
                },
            )

            linhas = resultado.mappings().all()
            resultado.close()

            resultado_total = db.session.execute(
                text("CALL sp_total_pesquisa_processos(:termo, :fase, :substancia)"),
                {
                    "termo": termo,
                    "fase": fase,
                    "substancia": substancia,
                },
            )

            linha_total = resultado_total.mappings().first()
            resultado_total.close()

            total = linha_total["total"] if linha_total else 0
            total_paginas = (total + limite - 1) // limite if limite > 0 else 0

            processos = [ProcessoMinerario(**dict(linha)) for linha in linhas]

            return {
                "pagina": pagina,
                "total": total,
                "total_paginas": total_paginas,
                "processos": processos,
            }

        paginacao = (
            ProcessoMinerario.query.filter(
                ProcessoMinerario.processo.ilike(f"%{termo}%")
                | ProcessoMinerario.nome.ilike(f"%{termo}%")
                | ProcessoMinerario.subs.ilike(f"%{termo}%")
            )
            .order_by(ProcessoMinerario.id_processo.desc())
            .paginate(
                page=pagina,
                per_page=limite,
            )
        )

        return {
            "pagina": paginacao.page,
            "total": paginacao.total,
            "total_paginas": paginacao.pages,
            "processos": paginacao.items,
        }

    @staticmethod
    def buscar_detalhes(id_processo):

        banco = db.session.get_bind().dialect.name

        if banco == "mysql":

            resultado = db.session.execute(
                text("CALL sp_buscar_detalhes_processo(:id_processo)"),
                {
                    "id_processo": id_processo,
                },
            )

            linha = resultado.mappings().first()

            resultado.close()

            if linha is None:
                return None

            return dict(linha)

        return None

    @staticmethod
    def listar_fases():
        resultados = (
            db.session.query(ProcessoMinerario.fase)
            .filter(ProcessoMinerario.fase.isnot(None))
            .filter(ProcessoMinerario.fase != "")
            .distinct()
            .order_by(ProcessoMinerario.fase)
            .all()
        )

        return [fase[0] for fase in resultados]

    @staticmethod
    def listar_substancias():
        resultados = (
            db.session.query(ProcessoMinerario.subs)
            .filter(ProcessoMinerario.subs.isnot(None))
            .filter(func.trim(ProcessoMinerario.subs) != "")
            .filter(ProcessoMinerario.subs != "DADO NÃO CADASTRADO")
            .distinct()
            .order_by(ProcessoMinerario.subs)
            .all()
        )

        return [subs[0] for subs in resultados]
