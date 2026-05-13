"""Seed idempotent pour créer un utilisateur admin local."""

from app.crud import create_user, get_user_by_tel
from app.db.session import Base, SessionLocal, engine
from app.models.diagnostic import Diagnostic  # noqa: F401
from app.models.parcelle import Parcelle  # noqa: F401
from app.models.user import User  # noqa: F401


def seed_admin_user() -> int:
    """Crée l'utilisateur admin/admin si absent. Retourne son id."""
    Base.metadata.create_all(bind=engine)

    db = SessionLocal()
    try:
        existing = get_user_by_tel(db, 'admin')
        if existing is not None:
            print(f'Utilisateur admin deja present (id={existing.id}).')
            return existing.id

        created = create_user(
            db=db,
            nom='Admin',
            prenom='Admin',
            region='System',
            tel='admin',
            password='admin',
        )
        print(f'Utilisateur admin cree (id={created.id}).')
        return created.id
    finally:
        db.close()


if __name__ == '__main__':
    seed_admin_user()
