from models import ProcessoMinerario, AtivoMinerario


class ProcessoMinerarioRepository:

    @staticmethod
    def listar_paginado(pagina, limite):
        return ProcessoMinerario.query.order_by(
            ProcessoMinerario.id_processo.desc()
        ).paginate(
            page=pagina,
            per_page=limite,
        )

    @staticmethod
    def pesquisar(termo, pagina, limite):
        return (
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

    @staticmethod
    def buscar_detalhes(id_processo):

        processo = ProcessoMinerario.query.get(id_processo)

        if processo is None:
            return None

        ativo = AtivoMinerario.query.filter_by(id_processo=id_processo).first()

        return {
            "processo": processo,
            "ativo": ativo,
        }
