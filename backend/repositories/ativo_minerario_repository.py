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

            return [dict(linha) for linha in linhas]

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
