from models import Usuario, db

class UsuarioRepository:

    @staticmethod
    def buscar_por_id(id_usuario):
        return Usuario.query.get(id_usuario)

    @staticmethod
    def buscar_por_email(email):
        return Usuario.query.filter_by(email=email).first()

    @staticmethod
    def buscar_por_telefone(telefone):
        return Usuario.query.filter_by(telefone=telefone).first()

    @staticmethod
    def buscar_por_email_ou_telefone(email=None, telefone=None):

        filtros = []

        if email:
            filtros.append(Usuario.email == email)

        if telefone:
            filtros.append(Usuario.telefone == telefone)

        if not filtros:
            return None

        return Usuario.query.filter(db.or_(*filtros)).first()
