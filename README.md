# AgriMada Mobile

> Diagnostiquer les maladies du riz, hors ligne.

Application mobile Flutter pour aider les agriculteurs malgaches à identifier et gérer les maladies du riz, même sans connexion internet.

---

## Table des matières

- [Fonctionnalités](#fonctionnalités)
- [Stack technique](#stack-technique)
- [Architecture](#architecture)
- [Prérequis](#prérequis)
- [Installation](#installation)
- [Génération de code](#génération-de-code)
- [Lancer l'application](#lancer-lapplication)
- [Build Android](#build-android)
- [Build iOS](#build-ios)
- [Tests](#tests)
- [Structure du projet](#structure-du-projet)
- [Variables d'environnement](#variables-denvironnement)
- [Contribution](#contribution)

---

## Fonctionnalités

- **Scan** — Photographie une plante et diagnostique la maladie via IA
- **Journal** — Historique des diagnostics par parcelle
- **Authentification** — Connexion sécurisée via API REST
- **Mode hors-ligne** — Fonctionne sans connexion internet

---

## Stack technique

| Rôle | Package | Version |
|---|---|---|
| Framework | Flutter | 3.x (stable) |
| Langage | Dart | 3.x (null safety) |
| State | Riverpod | ^2.5.1 |
| Navigation | GoRouter | ^13.2.0 |
| Réseau | Dio + Retrofit | 5.x / 4.7.2 |
| Sérialisation | json_serializable + freezed | ^6.8.0 / ^2.5.2 |
| Erreurs | fpdart (Either) | ^1.1.0 |
| Tests | flutter_test + mocktail | — / ^1.0.3 |

---

## Architecture

Le projet suit la **Clean Architecture** en couches strictes :

```
Presentation  →  Domain  ←  Data
```

- **Domain** — entités `@freezed`, repositories abstraits, use cases. Zéro dépendance Flutter.
- **Data** — implémentations des repositories, modèles `@JsonSerializable`, datasources Retrofit.
- **Presentation** — widgets `ConsumerWidget`, providers `@riverpod`, états `@freezed`.

Organisation **feature-first** :

```
lib/features/[feature]/
├── data/
│   ├── datasources/
│   ├── models/
│   └── repositories/
├── domain/
│   ├── entities/
│   ├── repositories/
│   └── usecases/
└── presentation/
    ├── providers/
    ├── screens/
    └── widgets/
```

---

## Prérequis

| Outil | Version minimale | Vérification |
|---|---|---|
| Flutter | 3.x (stable channel) | `flutter --version` |
| Dart | 3.x | `dart --version` |
| Java JDK | 17 | `java -version` |
| Android SDK | API 21+ | Android Studio / sdkmanager |
| Xcode | 15+ (iOS seulement) | `xcode-select --version` |

> **Windows** : Assurez-vous que `JAVA_HOME` pointe sur JDK 17 et que `flutter` est dans le `PATH`.

```bash
# Vérifier l'environnement Flutter complet
flutter doctor -v
```

---

## Installation

```bash
# 1. Cloner le dépôt
git clone https://github.com/votre-org/agri-mada-mobile.git
cd agri-mada-mobile

# 2. Installer les dépendances
flutter pub get
```

---

## Génération de code

Plusieurs packages utilisent la **génération de code** (`freezed`, `json_serializable`, `riverpod_generator`, `retrofit_generator`). Cette étape est **obligatoire** après chaque modification des fichiers annotés.

```bash
# Génération unique (à faire après clone ou modification de modèles)
dart run build_runner build --delete-conflicting-outputs

# Génération en mode watch (développement actif)
dart run build_runner watch --delete-conflicting-outputs
```

Fichiers générés (commités dans le dépôt) :

| Suffixe | Généré par |
|---|---|
| `*.freezed.dart` | `freezed` |
| `*.g.dart` | `json_serializable`, `riverpod_generator`, `retrofit_generator` |

> Si vous modifiez une entité `@freezed`, un modèle `@JsonSerializable` ou un provider `@riverpod`, relancez `build_runner build`.

---

## Lancer l'application

```bash
# Lister les appareils disponibles
flutter devices

# Lancer en mode debug (émulateur ou appareil physique)
flutter run

# Lancer sur un appareil spécifique
flutter run -d <device-id>

# Lancer en mode release (performances maximales)
flutter run --release
```

---

## Build Android

### APK universel (debug)

```bash
flutter build apk --debug
# Sortie : build/app/outputs/flutter-apk/app-debug.apk
```

### APK release universel (toutes architectures)

```bash
flutter build apk --release
# Sortie : build/app/outputs/flutter-apk/app-release.apk (~49 MB)
```

### APK release arm64 uniquement (recommandé pour la plupart des Android modernes)

```bash
flutter build apk --release --target-platform android-arm64
# Sortie : build/app/outputs/flutter-apk/app-release.apk (~18 MB)
```

### APKs séparés par architecture (distribution)

```bash
flutter build apk --release --split-per-abi
# Sorties :
#   build/app/outputs/flutter-apk/app-armeabi-v7a-release.apk
#   build/app/outputs/flutter-apk/app-arm64-v8a-release.apk
#   build/app/outputs/flutter-apk/app-x86_64-release.apk
```

### App Bundle (Google Play)

```bash
flutter build appbundle --release
# Sortie : build/app/outputs/bundle/release/app-release.aab
```

### Installer sur un appareil physique via ADB

```bash
# Connecter l'appareil en USB, activer le débogage USB
adb devices

# Installer l'APK
adb install build/app/outputs/flutter-apk/app-release.apk

# Ou installer + lancer directement
adb install -r build/app/outputs/flutter-apk/app-release.apk
```

> **Note** : Le build release utilise actuellement la clé debug. Pour la production, configurez `android/app/key.properties` avec votre keystore (voir [Flutter signing docs](https://docs.flutter.dev/deployment/android#signing-the-app)).

---

## Build iOS

> Requiert macOS + Xcode 15+

```bash
# Installer les dépendances CocoaPods
cd ios && pod install && cd ..

# Build release (Simulator)
flutter build ios --release --simulator

# Build release (Device — nécessite un compte développeur Apple)
flutter build ios --release

# Ouvrir dans Xcode pour archiver / distribuer
open ios/Runner.xcworkspace
```

---

## Tests

```bash
# Tous les tests unitaires et widget
flutter test

# Avec couverture de code
flutter test --coverage

# Afficher le rapport de couverture (lcov requis)
genhtml coverage/lcov.info -o coverage/html
open coverage/html/index.html

# Un fichier de test spécifique
flutter test test/features/auth/presentation/providers/auth_provider_test.dart

# Tests en mode verbose
flutter test --reporter expanded
```

> La couverture cible est **≥ 80%** sur `domain/` et `presentation/providers/`.

### Analyse statique

```bash
# Analyse du code (zéro warning obligatoire)
dart analyze

# Vérification du formatage
dart format . --set-exit-if-changed

# Corriger le formatage automatiquement
dart format .
```

---

## Structure du projet

```
lib/
├── main.dart
├── app/
│   ├── app.dart                   # Widget racine
│   ├── router.dart                # Routes GoRouter
│   └── theme/
│       ├── app_theme.dart
│       ├── app_colors.dart        # Palette de couleurs
│       ├── app_typography.dart    # Styles de texte
│       └── app_spacing.dart       # Constantes d'espacement
├── core/
│   ├── constants/
│   │   └── api_constants.dart     # URL, timeouts, endpoints
│   ├── errors/
│   │   ├── failure.dart           # Sealed class Failure
│   │   └── app_exception.dart
│   ├── utils/
│   │   └── logger.dart
│   └── widgets/                   # Composants atomiques partagés
└── features/
    ├── auth/                      # Authentification
    ├── home/                      # Écran d'accueil
    ├── journal/                   # Journal des diagnostics
    └── scan/                      # Scan et diagnostic

test/                              # Miroir de lib/ pour les tests
integration_test/                  # Tests e2e Patrol
assets/
├── fonts/Poppins/
└── images/
```

---

## Variables d'environnement

L'URL de l'API est définie dans `lib/core/constants/api_constants.dart` :

```dart
static const String baseUrl = 'https://api.agrimada.mg/v1';
```

Pour un environnement de développement local, modifiez `baseUrl` ou utilisez `--dart-define` au lancement :

```bash
flutter run --dart-define=API_BASE_URL=http://192.168.1.10:8000/v1
```

---

## Contribution

1. Créer une branche `feature/nom-feature` ou `fix/nom-bug`
2. Respecter la Clean Architecture — aucune logique métier dans les widgets
3. Tout nouveau fichier `.dart` doit avoir son `_test.dart` correspondant
4. Lancer `dart analyze` et `flutter test` avant chaque commit
5. Les fichiers générés (`*.g.dart`, `*.freezed.dart`) doivent être commités après `build_runner`

```bash
# Checklist pré-commit
dart analyze
dart format . --set-exit-if-changed
flutter test --coverage
```

---

*Flutter 3.x · Dart 3.x · Android API 21+ · iOS 12+*
