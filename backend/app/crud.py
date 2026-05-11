"""
Fonctions CRUD - Opérations de base de données.
Create, Read, Update, Delete pour User, Parcelle et Diagnostic.
"""

from typing import List, Optional
from sqlalchemy.orm import Session

from app.models.user import User
from app.models.parcelle import Parcelle
from app.models.diagnostic import Diagnostic
from app.core.security import get_password_hash, verify_password


# ============================================================
# CRUD - Utilisateurs
# ============================================================

def get_user_by_tel(db: Session, tel: str) -> Optional[User]:
    """Récupère un utilisateur par son numéro de téléphone."""
    return db.query(User).filter(User.tel == tel).first()


def get_user_by_id(db: Session, user_id: int) -> Optional[User]:
    """Récupère un utilisateur par son ID."""
    return db.query(User).filter(User.id == user_id).first()


def create_user(
    db: Session, nom: str, prenom: str, region: str, tel: str, password: str
) -> User:
    """Crée un nouvel agriculteur dans la base de données."""
    hashed_password = get_password_hash(password)
    db_user = User(
        nom=nom,
        prenom=prenom,
        region=region,
        tel=tel,
        hashed_password=hashed_password,
    )
    db.add(db_user)
    db.commit()
    db.refresh(db_user)
    return db_user


def authenticate_user(db: Session, tel: str, password: str) -> Optional[User]:
    """
    Authentifie un utilisateur par téléphone + mot de passe.
    Retourne l'utilisateur si les identifiants sont corrects, None sinon.
    """
    user = get_user_by_tel(db, tel)
    if not user:
        return None
    if not verify_password(password, user.hashed_password):
        return None
    return user


# ============================================================
# CRUD - Parcelles
# ============================================================

def get_parcelles_by_user(db: Session, user_id: int) -> List[Parcelle]:
    """Récupère toutes les parcelles d'un utilisateur."""
    return db.query(Parcelle).filter(Parcelle.user_id == user_id).all()


def get_parcelle_by_id(db: Session, parcelle_id: int) -> Optional[Parcelle]:
    """Récupère une parcelle par son ID."""
    return db.query(Parcelle).filter(Parcelle.id == parcelle_id).first()


def create_parcelle(
    db: Session,
    user_id: int,
    nom_parcelle: str,
    description: Optional[str] = None,
    surface: Optional[float] = None,
    latitude: Optional[float] = None,
    longitude: Optional[float] = None,
) -> Parcelle:
    """Crée une nouvelle parcelle pour un agriculteur."""
    db_parcelle = Parcelle(
        user_id=user_id,
        nom_parcelle=nom_parcelle,
        description=description,
        surface=surface,
        latitude=latitude,
        longitude=longitude,
    )
    db.add(db_parcelle)
    db.commit()
    db.refresh(db_parcelle)
    return db_parcelle


def bulk_create_parcelles(
    db: Session, user_id: int, parcelles_data: list
) -> List[Parcelle]:
    """
    Crée plusieurs parcelles en bloc (synchronisation offline → serveur).
    Retourne la liste des parcelles créées.
    """
    created = []
    for p_data in parcelles_data:
        db_parcelle = Parcelle(
            user_id=user_id,
            nom_parcelle=p_data.nom_parcelle,
            description=p_data.description,
            surface=p_data.surface,
            latitude=p_data.latitude,
            longitude=p_data.longitude,
        )
        db.add(db_parcelle)
        created.append(db_parcelle)
    db.commit()
    for p in created:
        db.refresh(p)
    return created


# ============================================================
# CRUD - Diagnostics
# ============================================================

def get_diagnostics_by_user(db: Session, user_id: int) -> List[Diagnostic]:
    """Récupère tous les diagnostics d'un utilisateur."""
    return (
        db.query(Diagnostic)
        .filter(Diagnostic.user_id == user_id)
        .order_by(Diagnostic.date_diagnostic.desc())
        .all()
    )


def get_diagnostics_by_parcelle(
    db: Session, parcelle_id: int
) -> List[Diagnostic]:
    """Récupère tous les diagnostics d'une parcelle donnée."""
    return (
        db.query(Diagnostic)
        .filter(Diagnostic.parcelle_id == parcelle_id)
        .order_by(Diagnostic.date_diagnostic.desc())
        .all()
    )


def create_diagnostic(
    db: Session,
    user_id: int,
    parcelle_id: int,
    maladie_detectee: str,
    date_diagnostic,
    confiance: Optional[float] = None,
    niveau_gravite: Optional[str] = None,
    recommandations: Optional[str] = None,
) -> Diagnostic:
    """Crée un nouveau diagnostic."""
    db_diag = Diagnostic(
        user_id=user_id,
        parcelle_id=parcelle_id,
        maladie_detectee=maladie_detectee,
        confiance=confiance,
        niveau_gravite=niveau_gravite,
        recommandations=recommandations,
        date_diagnostic=date_diagnostic,
    )
    db.add(db_diag)
    db.commit()
    db.refresh(db_diag)
    return db_diag


def bulk_create_diagnostics(
    db: Session, user_id: int, diagnostics_data: list
) -> List[Diagnostic]:
    """
    Crée plusieurs diagnostics en bloc (synchronisation offline → serveur).
    Vérifie que chaque parcelle_id appartient bien à l'utilisateur.
    """
    # Récupère les IDs de parcelles de l'utilisateur pour validation
    user_parcelle_ids = {
        p.id for p in db.query(Parcelle).filter(Parcelle.user_id == user_id).all()
    }

    created = []
    skipped = 0
    for d_data in diagnostics_data:
        # Sécurité : on ne crée le diagnostic que si la parcelle appartient à l'user
        if d_data.parcelle_id not in user_parcelle_ids:
            skipped += 1
            continue

        db_diag = Diagnostic(
            user_id=user_id,
            parcelle_id=d_data.parcelle_id,
            maladie_detectee=d_data.maladie_detectee,
            confiance=d_data.confiance,
            niveau_gravite=d_data.niveau_gravite,
            recommandations=d_data.recommandations,
            date_diagnostic=d_data.date_diagnostic,
        )
        db.add(db_diag)
        created.append(db_diag)

    db.commit()
    for d in created:
        db.refresh(d)
    return created


def get_journal_agricole(db: Session, user_id: int) -> list:
    """
    Construit le journal agricole : un résumé de l'état de santé de chaque parcelle.
    Pour chaque parcelle, retourne :
      - Infos de la parcelle
      - Nombre total de diagnostics
      - Dernière maladie détectée
      - Statut global (sain / malade)
    """
    parcelles = get_parcelles_by_user(db, user_id)
    journal = []

    for parcelle in parcelles:
        diagnostics = get_diagnostics_by_parcelle(db, parcelle.id)
        nb_diagnostics = len(diagnostics)

        derniere_maladie = None
        statut = "aucun_diagnostic"

        if nb_diagnostics > 0:
            # Le diagnostic le plus récent détermine l'état actuel
            dernier = diagnostics[0]  # Déjà trié par date desc
            derniere_maladie = dernier.maladie_detectee
            # On considère la parcelle saine si aucune maladie n'a été trouvée récemment
            statut = "sain" if derniere_maladie.lower() == "healthy" else "malade"

        journal.append(
            {
                "parcelle_id": parcelle.id,
                "nom_parcelle": parcelle.nom_parcelle,
                "description": parcelle.description,
                "surface": parcelle.surface,
                "latitude": parcelle.latitude,
                "longitude": parcelle.longitude,
                "nb_diagnostics": nb_diagnostics,
                "derniere_maladie": derniere_maladie,
                "statut": statut,
                "created_at": parcelle.created_at,
            }
        )

    return journal
