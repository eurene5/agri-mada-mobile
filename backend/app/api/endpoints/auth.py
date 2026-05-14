"""
Endpoints d'authentification.
- POST /register : Créer un compte agriculteur
- POST /login : Se connecter et obtenir un token JWT
- GET /me : Consulter son profil
"""

from datetime import timedelta

from fastapi import APIRouter, Depends, HTTPException, status
from fastapi.security import OAuth2PasswordRequestForm
from sqlalchemy.orm import Session

from app.db.session import get_db
from app.core.config import settings
from app.core.security import create_access_token
from app.schemas.user import (
    UserCreate,
    UserResponse,
    Token,
    ForgotPasswordRequest,
    ForgotPasswordResponse,
)
from app.crud import create_user, get_user_by_tel, authenticate_user
from app.deps import get_current_user
from app.models.user import User

router = APIRouter(prefix="/auth", tags=["Authentification"])


@router.post(
    "/register",
    response_model=UserResponse,
    status_code=status.HTTP_201_CREATED,
    summary="Créer un compte agriculteur",
    description="Inscription d'un nouvel agriculteur avec nom, prénom, région et numéro de téléphone.",
)
def register(user_data: UserCreate, db: Session = Depends(get_db)):
    """Créer un nouveau compte agriculteur."""
    # Vérifier si le numéro de téléphone est déjà utilisé
    existing_user = get_user_by_tel(db, user_data.tel)
    if existing_user:
        raise HTTPException(
            status_code=status.HTTP_400_BAD_REQUEST,
            detail=f"Le numéro de téléphone {user_data.tel} est déjà enregistré.",
        )

    new_user = create_user(
        db=db,
        nom=user_data.nom,
        prenom=user_data.prenom,
        region=user_data.region,
        tel=user_data.tel,
        password=user_data.password,
    )
    return new_user


@router.post(
    "/login",
    response_model=Token,
    summary="Se connecter",
    description="Authentification par numéro de téléphone et mot de passe. Retourne un token JWT.",
)
def login(
    form_data: OAuth2PasswordRequestForm = Depends(),
    db: Session = Depends(get_db),
):
    """
    Connexion de l'agriculteur.
    Note : OAuth2PasswordRequestForm utilise 'username' et 'password'.
    Ici, 'username' correspond au numéro de téléphone.
    """
    user = authenticate_user(db, tel=form_data.username, password=form_data.password)
    if not user:
        raise HTTPException(
            status_code=status.HTTP_401_UNAUTHORIZED,
            detail="Numéro de téléphone ou mot de passe incorrect.",
            headers={"WWW-Authenticate": "Bearer"},
        )

    access_token_expires = timedelta(minutes=settings.ACCESS_TOKEN_EXPIRE_MINUTES)
    access_token = create_access_token(
        data={"sub": str(user.id)}, expires_delta=access_token_expires
    )
    return {"access_token": access_token, "token_type": "bearer"}


@router.get(
    "/me",
    response_model=UserResponse,
    summary="Mon profil",
    description="Retourne les informations du profil de l'utilisateur connecté.",
)
def read_current_user(current_user: User = Depends(get_current_user)):
    """Consulter le profil de l'utilisateur connecté."""
    return current_user


@router.post(
    "/forgot-password",
    response_model=ForgotPasswordResponse,
    summary="Initier la réinitialisation du mot de passe",
    description=(
        "Accepte un numéro de téléphone et retourne toujours un message "
        "générique pour éviter l'énumération des comptes."
    ),
)
def forgot_password(payload: ForgotPasswordRequest, db: Session = Depends(get_db)):
    """MVP sans OTP/SMS: confirmation générique côté client."""
    _ = get_user_by_tel(db, payload.tel)
    return {
        "message": (
            "Si ce numéro est associé à un compte, des instructions seront envoyées."
        )
    }
