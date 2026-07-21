from apscheduler.schedulers.background import BackgroundScheduler
from services.sincronizacao.sincronizar_base_anm import (
    SincronizarBaseANMService,
)

scheduler = BackgroundScheduler()


def sincronizar(app):
    with app.app_context():
        resultado = SincronizarBaseANMService().executar()
        print(resultado)


def iniciar_scheduler(app):
    scheduler.add_job(
        func=sincronizar,
        args=[app],
        trigger="cron",
        hour=3,
        minute=0,
        id="sincronizar_anm",
        replace_existing=True,
    )

    scheduler.start()
