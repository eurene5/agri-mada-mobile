"""
Modèle SQLAlchemy - Diagnostic (Résultat d'analyse IA).
Chaque diagnostic est lié à un utilisateur et à une parcelle.
Les maladies détectées correspondent aux labels du modèle TFLite :
  - Bacterial leaf blight
  - Brown spot
  - Leaf smut
"""

from datetime import datetime, timezone
from sqlalchemy import Column, Integer, String, Float, DateTime, ForeignKey
from sqlalchemy.orm import relationship

from app.db.session import Base


class Diagnostic(Base):
    __tablename__ = "diagnostics"

    id = Column(Integer, primary_key=True, index=True, autoincrement=True)
    user_id = Column(
        Integer, ForeignKey("users.id", ondelete="CASCADE"), nullable=False, index=True
    )
    parcelle_id = Column(
        Integer,
        ForeignKey("parcelles.id", ondelete="CASCADE"),
        nullable=False,
        index=True,
    )
    maladie_detectee = Column(
        String(100),
        nullable=False,
        comment="Résultat IA : Bacterial leaf blight, Brown spot, Leaf smut",
    )
    confiance = Column(
        Float,
        nullable=True,
        comment="Score de confiance du modèle IA (0.0 à 1.0)",
    )
    niveau_gravite = Column(
        String(50),
        nullable=True,
        comment="Niveau estimé : faible, modéré, sévère",
    )
    recommandations = Column(
        String(1000),
        nullable=True,
        comment="Recommandations agricoles générées localement",
    )
    date_diagnostic = Column(
        DateTime,
        nullable=False,
        comment="Date/heure à laquelle l'analyse a été faite hors-ligne",
    )
    synced_at = Column(
        DateTime,
        default=lambda: datetime.now(timezone.utc),
        nullable=False,
        comment="Date/heure de la synchronisation avec le serveur",
    )

    # --- Relations ---
    user = relationship("User", back_populates="diagnostics")
    parcelle = relationship("Parcelle", back_populates="diagnostics")

    def __repr__(self):
        return f"<Diagnostic {self.maladie_detectee} - Parcelle {self.parcelle_id}>"
