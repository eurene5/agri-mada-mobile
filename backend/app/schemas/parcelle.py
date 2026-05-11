"""
Schémas Pydantic - Parcelle.
Définissent le format des données pour la gestion des parcelles (journal agricole).
"""

from datetime import datetime
from typing import Optional, List
from pydantic import BaseModel, Field


# --- Schémas d'entrée ---

class ParcelleCreate(BaseModel):
    """Données pour créer une parcelle depuis l'application mobile."""
    nom_parcelle: str = Field(
        ..., min_length=1, max_length=200, examples=["Champ Nord"]
    )
    description: Optional[str] = Field(
        None, max_length=500, examples=["Rizière proche de la rivière"]
    )
    surface: Optional[float] = Field(
        None, ge=0, examples=[2.5], description="Surface en hectares"
    )
    latitude: Optional[float] = Field(None, examples=[-18.9137])
    longitude: Optional[float] = Field(None, examples=[47.5361])


class ParcelleSync(BaseModel):
    """
    Format de synchronisation en bloc des parcelles.
    L'application mobile envoie une liste de parcelles créées hors-ligne.
    """
    parcelles: List[ParcelleCreate]


# --- Schémas de sortie ---

class ParcelleResponse(BaseModel):
    """Données d'une parcelle renvoyées par l'API."""
    id: int
    user_id: int
    nom_parcelle: str
    description: Optional[str] = None
    surface: Optional[float] = None
    latitude: Optional[float] = None
    longitude: Optional[float] = None
    created_at: datetime
    nb_diagnostics: int = 0
    derniere_maladie: Optional[str] = None

    class Config:
        from_attributes = True


class ParcelleSyncResponse(BaseModel):
    """Réponse après synchronisation en bloc des parcelles."""
    total_received: int
    total_created: int
    message: str
    parcelles_creees: List[ParcelleResponse] = []
