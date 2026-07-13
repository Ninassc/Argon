from sqlalchemy import text

from models import db, ProcessoMinerario, AtivoMinerario


class ProcessoMinerarioRepository:

    @staticmethod
    def listar_paginado(pagina, limite):

        banco = db.session.get_bind().dialect.name

        if banco == "mysql":

            offset = (pagina - 1) * limite

            resultado = db.session.execute(
                text("CALL sp_listar_processos(:limite, :offset)"),
                {
                    "limite": limite,
                    "offset": offset,
                },
            )

            linhas = resultado.mappings().all()
            resultado.close()

            resultado = db.session.execute(text("CALL sp_total_processos()"))

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
    def pesquisar(termo, pagina, limite):

        banco = db.session.get_bind().dialect.name

        if banco == "mysql":

            offset = (pagina - 1) * limite

            resultado = db.session.execute(
                text("CALL sp_pesquisar_processos(" ":termo, :limite, :offset)"),
                {
                    "termo": termo,
                    "limite": limite,
                    "offset": offset,
                },
            )

            linhas = resultado.mappings().all()
            resultado.close()

            resultado_total = db.session.execute(
                text("CALL sp_total_pesquisa_processos(:termo)"),
                {
                    "termo": termo,
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
