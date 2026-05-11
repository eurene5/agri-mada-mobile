"""
Configuration centrale du backend Agri-Mada.
Charge les variables d'environnement depuis le fichier .env
"""

from pydantic_settings import BaseSettings
from typing import Optional


class Settings(BaseSettings):
    # --- Base de données ---
    DATABASE_URL: str = "sqlite:///./agrimada_dev.db"

    # --- Sécurité JWT ---
    SECRET_KEY: str = "dev-secret-key-change-me-in-production"
    ALGORITHM: str = "HS256"
    ACCESS_TOKEN_EXPIRE_MINUTES: int = 1440  # 24 heures

    # --- Application ---
    APP_NAME: str = "Agri-Mada API"
    APP_VERSION: str = "1.0.0"
    DEBUG: bool = True

    class Config:
        env_file = ".env"
        case_sensitive = True


settings = Settings()
