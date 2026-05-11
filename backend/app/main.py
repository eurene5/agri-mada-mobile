"""
Agri-Mada Backend — Point d'entrée principal.

Application FastAPI pour la centralisation et la synchronisation
des données de l'application mobile de détection des maladies du riz.

Démarrer le serveur :
    uvicorn app.main:app --reload
    
Documentation interactive :
    http://localhost:8000/docs (Swagger UI)
    http://localhost:8000/redoc (ReDoc)
"""

from fastapi import FastAPI
from fastapi.middleware.cors import CORSMiddleware

from app.core.config import settings
from app.db.session import engine, Base
from app.api.router import api_router

# --- Importer tous les modèles pour que SQLAlchemy les enregistre ---
from app.models.user import User  # noqa: F401
from app.models.parcelle import Parcelle  # noqa: F401
from app.models.diagnostic import Diagnostic  # noqa: F401


# --- Création de l'application FastAPI ---
app = FastAPI(
    title=settings.APP_NAME,
    version=settings.APP_VERSION,
    description=(
        "API backend pour l'application mobile Agri-Mada.\n\n"
        "## Fonctionnalités\n"
        "- **Authentification** : Inscription et connexion des agriculteurs (JWT)\n"
        "- **Synchronisation** : Réception des parcelles et diagnostics créés hors-ligne\n"
        "- **Journal Agricole** : Résumé de l'état de santé des parcelles\n\n"
        "## Architecture\n"
        "L'application mobile Flutter fonctionne 100% hors-ligne avec TensorFlow Lite "
        "et Isar Database. Ce backend sert uniquement de plateforme de centralisation "
        "et de sauvegarde lorsque l'agriculteur retrouve une connexion internet."
    ),
    docs_url="/docs",
    redoc_url="/redoc",
)

# --- CORS : autoriser l'application mobile à communiquer avec le serveur ---
app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],  # En production, restreindre aux domaines autorisés
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

# --- Création automatique des tables au démarrage ---
Base.metadata.create_all(bind=engine)

# --- Inclusion du routeur principal ---
app.include_router(api_router)


# --- Route de vérification (health check) ---
@app.get(
    "/",
    tags=["Santé"],
    summary="Vérification du serveur",
    description="Endpoint de vérification : retourne un message confirmant que le serveur est en ligne.",
)
def health_check():
    """Vérifier que le serveur est en ligne."""
    return {
        "status": "ok",
        "app": settings.APP_NAME,
        "version": settings.APP_VERSION,
        "message": "Serveur Agri-Mada en ligne. Bienvenue !",
    }
