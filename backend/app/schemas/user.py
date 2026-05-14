"""
Schémas Pydantic - Utilisateur.
Définissent le format des données envoyées et reçues par l'API pour les utilisateurs.
"""

from datetime import datetime
from typing import Optional
from pydantic import BaseModel, Field


# --- Schémas d'entrée ---

class UserCreate(BaseModel):
    """Données requises pour créer un compte agriculteur."""
    nom: str = Field(..., min_length=1, max_length=100, examples=["Rakoto"])
    prenom: str = Field(..., min_length=1, max_length=100, examples=["Jean"])
    region: str = Field(..., min_length=1, max_length=150, examples=["Analamanga"])
    tel: str = Field(
        ...,
        min_length=6,
        max_length=20,
        examples=["0341234567"],
        description="Numéro de téléphone unique, utilisé comme identifiant de connexion",
    )
    password: str = Field(..., min_length=4, max_length=100)


class UserLogin(BaseModel):
    """Données pour se connecter."""
    tel: str = Field(..., examples=["0341234567"])
    password: str


class ForgotPasswordRequest(BaseModel):
    """Données pour initier une réinitialisation du mot de passe."""
    tel: str = Field(
        ...,
        min_length=6,
        max_length=20,
        examples=["0341234567"],
        description="Numéro de téléphone associé au compte",
    )


# --- Schémas de sortie ---

class UserResponse(BaseModel):
    """Données renvoyées par l'API après création ou consultation d'un utilisateur."""
    id: int
    nom: str
    prenom: str
    region: str
    tel: str
    is_active: bool
    created_at: datetime

    class Config:
        from_attributes = True  # Permet de convertir depuis un objet SQLAlchemy


class Token(BaseModel):
    """Token JWT retourné après authentification."""
    access_token: str
    token_type: str = "bearer"


class TokenData(BaseModel):
    """Données extraites d'un token JWT."""
    user_id: Optional[int] = None


class ForgotPasswordResponse(BaseModel):
    """Réponse générique pour limiter l'énumération de comptes."""
    message: str
