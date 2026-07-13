from models import AtivoMinerario


class AtivoMinerarioRepository:

    @staticmethod
    def buscar_por_usuario(id_usuario):
        return (
            AtivoMinerario.query.filter_by(id_usuario=id_usuario)
            .order_by(AtivoMinerario.dt_cadastro.desc())
            .all()
        )

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
