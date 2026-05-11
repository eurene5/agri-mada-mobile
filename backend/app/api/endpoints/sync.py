"""
Endpoints de synchronisation.
Reçoit les données créées hors-ligne par l'application Flutter
et les sauvegarde dans la base PostgreSQL du serveur.

- POST /parcelles : Synchroniser les parcelles créées hors-ligne
- POST /diagnostics : Synchroniser les diagnostics créés hors-ligne
"""

from fastapi import APIRouter, Depends, HTTPException, status
from sqlalchemy.orm import Session

from app.db.session import get_db
from app.deps import get_current_user
from app.models.user import User
from app.schemas.parcelle import ParcelleSync, ParcelleSyncResponse
from app.schemas.diagnostic import DiagnosticSync, DiagnosticSyncResponse
from app.crud import bulk_create_parcelles, bulk_create_diagnostics

router = APIRouter(prefix="/sync", tags=["Synchronisation"])


@router.post(
    "/parcelles",
    response_model=ParcelleSyncResponse,
    summary="Synchroniser les parcelles",
    description=(
        "Reçoit un ensemble de parcelles créées hors-ligne sur le téléphone "
        "et les sauvegarde sur le serveur. Nécessite une connexion internet."
    ),
)
def sync_parcelles(
    data: ParcelleSync,
    db: Session = Depends(get_db),
    current_user: User = Depends(get_current_user),
):
    """Synchronisation en bloc des parcelles créées hors-ligne."""
    created = bulk_create_parcelles(
        db=db,
        user_id=current_user.id,
        parcelles_data=data.parcelles,
    )
    return ParcelleSyncResponse(
        total_received=len(data.parcelles),
        total_created=len(created),
        message=f"{len(created)} parcelle(s) synchronisée(s) avec succès.",
        parcelles_creees=created,
    )


@router.post(
    "/diagnostics",
    response_model=DiagnosticSyncResponse,
    summary="Synchroniser les diagnostics",
    description=(
        "Reçoit un ensemble de diagnostics IA effectués hors-ligne sur le téléphone "
        "et les sauvegarde sur le serveur. Chaque diagnostic doit être lié à une "
        "parcelle existante appartenant à l'utilisateur."
    ),
)
def sync_diagnostics(
    data: DiagnosticSync,
    db: Session = Depends(get_db),
    current_user: User = Depends(get_current_user),
):
    """Synchronisation en bloc des diagnostics créés hors-ligne."""
    created = bulk_create_diagnostics(
        db=db,
        user_id=current_user.id,
        diagnostics_data=data.diagnostics,
    )

    skipped = len(data.diagnostics) - len(created)
    message = f"{len(created)} diagnostic(s) synchronisé(s) avec succès."
    if skipped > 0:
        message += f" {skipped} ignoré(s) (parcelle introuvable ou non autorisée)."

    return DiagnosticSyncResponse(
        total_received=len(data.diagnostics),
        total_created=len(created),
        message=message,
        diagnostics_crees=created,
    )
