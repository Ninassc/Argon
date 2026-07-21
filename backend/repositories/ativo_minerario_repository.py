from sqlalchemy import text

from models import db, AtivoMinerario


class AtivoMinerarioRepository:

    @staticmethod
    def listar_ativos_usuario(id_usuario):

        banco = db.session.get_bind().dialect.name

        if banco == "mysql":

            resultado = db.session.execute(
                text("CALL sp_listar_ativos_usuario(:id_usuario)"),
                {
                    "id_usuario": id_usuario,
                },
            )

            linhas = resultado.mappings().all()
            resultado.close()

            ativos = []

            for linha in linhas:
                ativos.append({
                    "id_ativo": linha["id_ativo"],
                    "id_usuario": linha["id_usuario"],
                    "descricao": linha["descricao"],
                    "dt_cadastro": linha["dt_cadastro"],

                    "processo": {
                        "id_processo": linha["id_processo"],
                        "id_anm": linha["id_anm"],
                        "processo": linha["processo"],
                        "numero": linha["numero"],
                        "ano": linha["ano"],
                        "area_ha": linha["area_ha"],
                        "fase": linha["fase"],
                        "ult_evento": linha["ult_evento"],
                        "dt_ult_evento": linha["dt_ult_evento"],
                        "nome": linha["nome"],
                        "subs": linha["subs"],
                        "uso": linha["uso"],
                        "uf": linha["uf"],
                        "ds_processo": linha["ds_processo"],
                    }
                })

            return ativos

        ativos = (
            AtivoMinerario.query.filter_by(id_usuario=id_usuario)
            .order_by(AtivoMinerario.dt_cadastro.desc())
            .all()
        )

        return ativos

    @staticmethod
    def buscar_por_usuario_processo(id_usuario, id_processo):
        return AtivoMinerario.query.filter_by(
            id_usuario=id_usuario,
            id_processo=id_processo,
        ).first()

    @staticmethod
    def buscar_por_usuario_ativo(id_usuario, id_ativo):
        return AtivoMinerario.query.filter_by(
            id_usuario=id_usuario,
            id_ativo=id_ativo,
        ).first()

    @staticmethod
    def buscar_por_processo(id_processo):
        return AtivoMinerario.query.filter_by(id_processo=id_processo).first()
