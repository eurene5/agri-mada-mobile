"""
Schémas Pydantic - Diagnostic.
Définissent le format des données pour les résultats d'analyse IA synchronisés.
"""

from datetime import datetime
from typing import Optional, List
from pydantic import BaseModel, Field


# --- Schémas d'entrée ---

class DiagnosticCreate(BaseModel):
    """Données d'un diagnostic envoyé depuis l'application mobile."""
    parcelle_id: int = Field(..., description="ID de la parcelle concernée")
    maladie_detectee: str = Field(
        ...,
        max_length=100,
        examples=["Bacterial leaf blight"],
        description="Résultat de l'IA : Bacterial leaf blight, Brown spot, Leaf smut",
    )
    confiance: Optional[float] = Field(
        None,
        ge=0.0,
        le=1.0,
        examples=[0.92],
        description="Score de confiance du modèle (0.0 à 1.0)",
    )
    niveau_gravite: Optional[str] = Field(
        None,
        max_length=50,
        examples=["modéré"],
        description="Niveau : faible, modéré, sévère",
    )
    recommandations: Optional[str] = Field(
        None,
        max_length=1000,
        examples=["Appliquer un traitement biologique à base de cuivre"],
    )
    date_diagnostic: datetime = Field(
        ..., description="Date/heure de l'analyse effectuée hors-ligne sur le téléphone"
    )


class DiagnosticSync(BaseModel):
    """
    Format de synchronisation en bloc des diagnostics.
    L'application mobile envoie tous les diagnostics non synchronisés d'un coup.
    """
    diagnostics: List[DiagnosticCreate]


# --- Schémas de sortie ---

class DiagnosticResponse(BaseModel):
    """Données d'un diagnostic renvoyées par l'API."""
    id: int
    user_id: int
    parcelle_id: int
    maladie_detectee: str
    confiance: Optional[float] = None
    niveau_gravite: Optional[str] = None
    recommandations: Optional[str] = None
    date_diagnostic: datetime
    synced_at: datetime

    class Config:
        from_attributes = True


class DiagnosticSyncResponse(BaseModel):
    """Réponse après synchronisation en bloc des diagnostics."""
    total_received: int
    total_created: int
    message: str
    diagnostics_crees: List[DiagnosticResponse] = []
