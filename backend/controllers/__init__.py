from .usuario_controller import usuario_bp
from .processo_minerario_controller import processo_bp
from .ativo_minerario_controller import ativo_bp
from .auth_controller import auth_bp
from .favorito_controller import favorito_bp
from .compartilhamento_processo_controller import compartilhamento_bp
from .acesso_controller import acesso_bp

__all__ = [
    "usuario_bp",
    "processo_bp",
    "ativo_bp",
    "auth_bp",
    "favorito_bp",
    "compartilhamento_bp",
    "acesso_bp",
]
