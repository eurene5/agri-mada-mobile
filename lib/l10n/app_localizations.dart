import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_fr.dart';
import 'app_localizations_mg.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
      : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('fr'),
    Locale('mg')
  ];

  /// Sous-titre écran splash
  ///
  /// In fr, this message translates to:
  /// **'Diagnostiquer les maladies du riz, hors ligne'**
  String get splashSubtitle;

  /// Titre de la fenêtre mot de passe oublié
  ///
  /// In fr, this message translates to:
  /// **'Mot de passe oublié ?'**
  String get loginForgotPasswordTitle;

  /// Libellé du champ email
  ///
  /// In fr, this message translates to:
  /// **'Email'**
  String get loginEmailLabel;

  /// Placeholder email
  ///
  /// In fr, this message translates to:
  /// **'nom@exemple.com'**
  String get loginEmailHint;

  /// Validation email requis
  ///
  /// In fr, this message translates to:
  /// **'Veuillez entrer votre email'**
  String get loginEmailRequired;

  /// Validation email invalide
  ///
  /// In fr, this message translates to:
  /// **'Email invalide'**
  String get loginEmailInvalid;

  /// Action annuler
  ///
  /// In fr, this message translates to:
  /// **'Annuler'**
  String get commonCancel;

  /// Action envoyer
  ///
  /// In fr, this message translates to:
  /// **'Envoyer'**
  String get commonSend;

  /// Message fonctionnalité bientôt disponible
  ///
  /// In fr, this message translates to:
  /// **'Fonctionnalité bientôt disponible'**
  String get featureComingSoon;

  /// Message inscription bientôt disponible
  ///
  /// In fr, this message translates to:
  /// **'Inscription bientôt disponible'**
  String get registerComingSoon;

  /// Titre écran login
  ///
  /// In fr, this message translates to:
  /// **'Connexion'**
  String get loginTitle;

  /// Libellé mot de passe
  ///
  /// In fr, this message translates to:
  /// **'Mot de passe'**
  String get loginPasswordLabel;

  /// Validation mot de passe requis
  ///
  /// In fr, this message translates to:
  /// **'Veuillez entrer votre mot de passe'**
  String get loginPasswordRequired;

  /// Lien mot de passe oublié
  ///
  /// In fr, this message translates to:
  /// **'Mot de passe oublié ?'**
  String get loginForgotPassword;

  /// Bouton connexion
  ///
  /// In fr, this message translates to:
  /// **'Se connecter'**
  String get loginSubmit;

  /// Texte pas de compte
  ///
  /// In fr, this message translates to:
  /// **'Pas encore de compte ?'**
  String get loginNoAccount;

  /// Lien inscription
  ///
  /// In fr, this message translates to:
  /// **'S\'inscrire'**
  String get loginRegister;

  /// Texte salutation login
  ///
  /// In fr, this message translates to:
  /// **'Bonjour !'**
  String get loginHello;

  /// Sous-titre login
  ///
  /// In fr, this message translates to:
  /// **'Ravie de vous revoir sur AgriMada'**
  String get loginWelcome;

  /// Titre ecran bienvenue
  ///
  /// In fr, this message translates to:
  /// **'L\'intelligence au service de vos rizières'**
  String get welcomeHeadline;

  /// Description ecran bienvenue
  ///
  /// In fr, this message translates to:
  /// **'Un riz sain et protégé grâce à l\'expertise AgriMada.'**
  String get welcomeBody;

  /// Bouton commencer
  ///
  /// In fr, this message translates to:
  /// **'Commencer'**
  String get welcomeStart;

  /// Snack bar bientôt disponible
  ///
  /// In fr, this message translates to:
  /// **'Bientôt disponible'**
  String get homeSoonMessage;

  /// Titre section services
  ///
  /// In fr, this message translates to:
  /// **'Nos Services'**
  String get homeServicesTitle;

  /// Semantique bouton menu
  ///
  /// In fr, this message translates to:
  /// **'Ouvrir le menu'**
  String get homeMenuSemantics;

  /// Salutation utilisateur
  ///
  /// In fr, this message translates to:
  /// **'Bonjour, {name}!'**
  String homeHelloUser(String name);

  /// Prénom par défaut si absent
  ///
  /// In fr, this message translates to:
  /// **'Agriculteur'**
  String get homeFarmerDefault;

  /// Sous-texte accueil
  ///
  /// In fr, this message translates to:
  /// **'Prêt pour une analyse ?'**
  String get homeReadyForAnalysis;

  /// Indicateur mode hors ligne
  ///
  /// In fr, this message translates to:
  /// **'Mode hors ligne'**
  String get homeOfflineMode;

  /// Placeholder recherche
  ///
  /// In fr, this message translates to:
  /// **'recherche...'**
  String get homeSearchPlaceholder;

  /// Titre carte résumé
  ///
  /// In fr, this message translates to:
  /// **'Résumé de votre exploitation'**
  String get homeSummaryTitle;

  /// Statut système prêt
  ///
  /// In fr, this message translates to:
  /// **'Système prêt'**
  String get homeSystemReady;

  /// Nombre de parcelles
  ///
  /// In fr, this message translates to:
  /// **'{count} parcelle(s) enregistrée(s)'**
  String homeRegisteredPlots(int count);

  /// Service mes parcelles
  ///
  /// In fr, this message translates to:
  /// **'Mes parcelles'**
  String get homeServicePlotsTitle;

  /// Description service mes parcelles
  ///
  /// In fr, this message translates to:
  /// **'Suivez vos rizières, surfaces cultivées et l\'état sanitaire de chaque parcelle'**
  String get homeServicePlotsDescription;

  /// Service état des cultures
  ///
  /// In fr, this message translates to:
  /// **'État des cultures'**
  String get homeServiceCropsTitle;

  /// Description service état cultures
  ///
  /// In fr, this message translates to:
  /// **'Consultez l\'état global de vos cultures et les niveaux de risque actuels'**
  String get homeServiceCropsDescription;

  /// Service solutions agricoles
  ///
  /// In fr, this message translates to:
  /// **'Solutions agricoles'**
  String get homeServiceSolutionsTitle;

  /// Description service solutions
  ///
  /// In fr, this message translates to:
  /// **'Découvrez les traitements biologiques et solutions locales recommandées'**
  String get homeServiceSolutionsDescription;

  /// Service prevention
  ///
  /// In fr, this message translates to:
  /// **'Prévenir les maladies'**
  String get homeServicePreventionTitle;

  /// Description service prevention
  ///
  /// In fr, this message translates to:
  /// **'Apprenez les bonnes pratiques pour protéger vos rizières et éviter les pertes'**
  String get homeServicePreventionDescription;

  /// Semantique bouton scan
  ///
  /// In fr, this message translates to:
  /// **'Scanner une plante'**
  String get homeScanPlantSemantics;

  /// Label onglet accueil
  ///
  /// In fr, this message translates to:
  /// **'Accueil'**
  String get homeTabHome;

  /// Label onglet journal
  ///
  /// In fr, this message translates to:
  /// **'Journal'**
  String get homeTabJournal;

  /// Message indisponibilite IA
  ///
  /// In fr, this message translates to:
  /// **'Diagnostic IA indisponible, veuillez réessayer'**
  String get scanIaUnavailable;

  /// Titre selection parcelle
  ///
  /// In fr, this message translates to:
  /// **'Choisir une parcelle'**
  String get scanSelectPlot;

  /// Titre dialogue aucune parcelle
  ///
  /// In fr, this message translates to:
  /// **'Aucune parcelle'**
  String get scanNoPlotTitle;

  /// Description dialogue aucune parcelle
  ///
  /// In fr, this message translates to:
  /// **'Créez d\'abord une parcelle dans votre journal agricole avant de scanner.'**
  String get scanNoPlotDescription;

  /// Action OK
  ///
  /// In fr, this message translates to:
  /// **'OK'**
  String get commonOk;

  /// Action aller au journal
  ///
  /// In fr, this message translates to:
  /// **'Aller au journal'**
  String get scanGoToJournal;

  /// Texte chargement scan
  ///
  /// In fr, this message translates to:
  /// **'Analyse en cours...'**
  String get scanLoading;

  /// Instruction caméra
  ///
  /// In fr, this message translates to:
  /// **'Pointez la caméra vers\nla feuille de riz'**
  String get scanPointCamera;

  /// Info analyse hors ligne
  ///
  /// In fr, this message translates to:
  /// **'L\'analyse se fait hors ligne'**
  String get scanOfflineAnalysis;

  /// Titre ecran scan
  ///
  /// In fr, this message translates to:
  /// **'Scanner une feuille'**
  String get scanHeaderTitle;

  /// Bouton annuler scan
  ///
  /// In fr, this message translates to:
  /// **'ANNULER'**
  String get scanCancel;

  /// Message echec sauvegarde diagnostic
  ///
  /// In fr, this message translates to:
  /// **'Impossible d\'enregistrer le diagnostic'**
  String get scanResultSaveFailed;

  /// Message sauvegarde diagnostic réussie
  ///
  /// In fr, this message translates to:
  /// **'Diagnostic enregistré'**
  String get scanResultSaved;

  /// Semantique bouton retour
  ///
  /// In fr, this message translates to:
  /// **'Retour'**
  String get scanResultBackSemantics;

  /// Titre écran résultat
  ///
  /// In fr, this message translates to:
  /// **'Résultat de l\'analyse'**
  String get scanResultTitle;

  /// Sous-titre écran résultat
  ///
  /// In fr, this message translates to:
  /// **'Analyse hors ligne terminée'**
  String get scanResultSubtitle;

  /// Nom localisé maladie BLB
  ///
  /// In fr, this message translates to:
  /// **'Brûlure bactérienne'**
  String get diseaseBacterialLeafBlight;

  /// Nom localisé maladie brown spot
  ///
  /// In fr, this message translates to:
  /// **'Tache brune'**
  String get diseaseBrownSpot;

  /// Nom localisé maladie leaf smut
  ///
  /// In fr, this message translates to:
  /// **'Charbon foliaire'**
  String get diseaseLeafSmut;

  /// Nom localisé état sain
  ///
  /// In fr, this message translates to:
  /// **'Plante saine'**
  String get diseaseHealthy;

  /// Badge de confiance
  ///
  /// In fr, this message translates to:
  /// **'{value}% de confiance'**
  String scanResultConfidence(String value);

  /// Titre partage diagnostic
  ///
  /// In fr, this message translates to:
  /// **'Diagnostic AgriMada'**
  String get scanShareTitle;

  /// Ligne culture partage
  ///
  /// In fr, this message translates to:
  /// **'Culture: Riz'**
  String get scanShareCulture;

  /// Ligne maladie partage
  ///
  /// In fr, this message translates to:
  /// **'Maladie: {disease}'**
  String scanShareDisease(String disease);

  /// Ligne confiance partage
  ///
  /// In fr, this message translates to:
  /// **'Confiance: {value}%'**
  String scanShareConfidence(String value);

  /// Ligne date partage
  ///
  /// In fr, this message translates to:
  /// **'Date: {date}'**
  String scanShareDate(String date);

  /// Titre carte gravité
  ///
  /// In fr, this message translates to:
  /// **'Niveau de gravité'**
  String get scanSeverityTitle;

  /// Niveau faible
  ///
  /// In fr, this message translates to:
  /// **'Faible'**
  String get scanSeverityLow;

  /// Niveau moyen
  ///
  /// In fr, this message translates to:
  /// **'Moyen'**
  String get scanSeverityMedium;

  /// Niveau élevé
  ///
  /// In fr, this message translates to:
  /// **'Élevé'**
  String get scanSeverityHigh;

  /// Texte statut gravité aucune
  ///
  /// In fr, this message translates to:
  /// **'Aucune - Plante saine'**
  String get scanSeverityNoneStatus;

  /// Texte statut gravité faible
  ///
  /// In fr, this message translates to:
  /// **'Faible - Surveiller'**
  String get scanSeverityLowStatus;

  /// Texte statut gravité modérée
  ///
  /// In fr, this message translates to:
  /// **'Modéré - Intervention conseillée'**
  String get scanSeverityMediumStatus;

  /// Texte statut gravité élevée
  ///
  /// In fr, this message translates to:
  /// **'Élevé - Intervention urgente'**
  String get scanSeverityHighStatus;

  /// Titre recommandations
  ///
  /// In fr, this message translates to:
  /// **'Recommandations adaptées'**
  String get scanRecommendationsTitle;

  /// Titre item recommandation
  ///
  /// In fr, this message translates to:
  /// **'Recommandation'**
  String get scanRecommendationItemTitle;

  /// Recommandation BLB 1
  ///
  /// In fr, this message translates to:
  /// **'Évacuer l\'eau des rizières infectées'**
  String get scanRecBlbEvacuateWater;

  /// Recommandation BLB 2
  ///
  /// In fr, this message translates to:
  /// **'Appliquer du cuivre hydroxyde (2-3 g/L)'**
  String get scanRecBlbApplyCopper;

  /// Recommandation BLB 3
  ///
  /// In fr, this message translates to:
  /// **'Éviter l\'excès d\'azote'**
  String get scanRecBlbAvoidNitrogen;

  /// Recommandation BLB 4
  ///
  /// In fr, this message translates to:
  /// **'Utiliser des variétés résistantes lors du prochain cycle'**
  String get scanRecBlbUseResistantVarieties;

  /// Recommandation Brown Spot 1
  ///
  /// In fr, this message translates to:
  /// **'Améliorer la fertilisation (potassium)'**
  String get scanRecBrownSpotFertilize;

  /// Recommandation Brown Spot 2
  ///
  /// In fr, this message translates to:
  /// **'Appliquer un fongicide à base de mancozèbe'**
  String get scanRecBrownSpotApplyFungicide;

  /// Recommandation Brown Spot 3
  ///
  /// In fr, this message translates to:
  /// **'Assurer un drainage correct'**
  String get scanRecBrownSpotDrainage;

  /// Recommandation Brown Spot 4
  ///
  /// In fr, this message translates to:
  /// **'Éviter le stress hydrique'**
  String get scanRecBrownSpotAvoidStress;

  /// Recommandation Leaf Smut 1
  ///
  /// In fr, this message translates to:
  /// **'Traiter les semences avant plantation'**
  String get scanRecLeafSmutTreatSeeds;

  /// Recommandation Leaf Smut 2
  ///
  /// In fr, this message translates to:
  /// **'Appliquer des fongicides systémiques'**
  String get scanRecLeafSmutApplyFungicide;

  /// Recommandation Leaf Smut 3
  ///
  /// In fr, this message translates to:
  /// **'Retirer et brûler les plants infectés'**
  String get scanRecLeafSmutRemovePlants;

  /// Recommandation Leaf Smut 4
  ///
  /// In fr, this message translates to:
  /// **'Rotation des cultures recommandée'**
  String get scanRecLeafSmutRotation;

  /// Recommandation plante saine
  ///
  /// In fr, this message translates to:
  /// **'Plante en bonne santé. Continuez les bonnes pratiques agricoles.'**
  String get scanRecHealthy;

  /// Recommandation plante saine eau
  ///
  /// In fr, this message translates to:
  /// **'Maintenir une bonne gestion de l\'eau'**
  String get scanRecHealthyWater;

  /// Recommandation plante saine fertilisation
  ///
  /// In fr, this message translates to:
  /// **'Fertilisation équilibrée'**
  String get scanRecHealthyFertilization;

  /// Recommandation plante saine surveillance
  ///
  /// In fr, this message translates to:
  /// **'Surveillance régulière des parcelles'**
  String get scanRecHealthyMonitoring;

  /// Recommandation plante saine rotation
  ///
  /// In fr, this message translates to:
  /// **'Rotation des cultures'**
  String get scanRecHealthyRotation;

  /// Astuce résultat scan
  ///
  /// In fr, this message translates to:
  /// **'Astuce : évitez l\'arrosage excessif pendant 3 jours'**
  String get scanTip;

  /// Sémantique bouton refaire scan
  ///
  /// In fr, this message translates to:
  /// **'Refaire un scan'**
  String get scanRescanSemantics;

  /// Bouton refaire scan
  ///
  /// In fr, this message translates to:
  /// **'Refaire un scan'**
  String get scanRescan;

  /// Sémantique bouton enregistrer journal
  ///
  /// In fr, this message translates to:
  /// **'Enregistrer dans le journal'**
  String get scanSaveJournalSemantics;

  /// Action enregistrer
  ///
  /// In fr, this message translates to:
  /// **'Enregistrer'**
  String get commonSave;

  /// Sémantique bouton partager
  ///
  /// In fr, this message translates to:
  /// **'Partager le résultat'**
  String get scanShareSemantics;

  /// Bouton partager
  ///
  /// In fr, this message translates to:
  /// **'Partager le résultat'**
  String get scanShare;

  /// Message d'erreur écran journal
  ///
  /// In fr, this message translates to:
  /// **'Erreur: {error}'**
  String journalError(String error);

  /// Bouton nouvelle parcelle
  ///
  /// In fr, this message translates to:
  /// **'Nouvelle parcelle'**
  String get journalNewPlot;

  /// Titre écran journal
  ///
  /// In fr, this message translates to:
  /// **'Journal agricole'**
  String get journalTitle;

  /// Sous-titre écran journal
  ///
  /// In fr, this message translates to:
  /// **'Suivi de vos parcelles'**
  String get journalSubtitle;

  /// Stat total
  ///
  /// In fr, this message translates to:
  /// **'Total'**
  String get journalTotal;

  /// Stat saines
  ///
  /// In fr, this message translates to:
  /// **'Saines'**
  String get journalHealthyPlural;

  /// Stat malades
  ///
  /// In fr, this message translates to:
  /// **'Malades'**
  String get journalSickPlural;

  /// Badge statut malade
  ///
  /// In fr, this message translates to:
  /// **'Malade'**
  String get journalStatusSick;

  /// Badge statut sain
  ///
  /// In fr, this message translates to:
  /// **'Sain'**
  String get journalStatusHealthy;

  /// Badge statut non analysé
  ///
  /// In fr, this message translates to:
  /// **'Non analysé'**
  String get journalStatusNotAnalyzed;

  /// Affichage surface en hectares
  ///
  /// In fr, this message translates to:
  /// **'{surface} ha'**
  String journalAreaHa(String surface);

  /// Nombre d'analyses
  ///
  /// In fr, this message translates to:
  /// **'{count} analyse(s)'**
  String journalAnalysesCount(int count);

  /// Dernier diagnostic
  ///
  /// In fr, this message translates to:
  /// **'Dernier : {disease} - {date}'**
  String journalLastDiagnostic(String disease, String date);

  /// Action scanner
  ///
  /// In fr, this message translates to:
  /// **'Scanner'**
  String get journalScan;

  /// Texte aucun diagnostic
  ///
  /// In fr, this message translates to:
  /// **'Aucun diagnostic encore'**
  String get journalNoDiagnosticYet;

  /// Action scanner maintenant
  ///
  /// In fr, this message translates to:
  /// **'Scanner maintenant'**
  String get journalScanNow;

  /// Titre état vide journal
  ///
  /// In fr, this message translates to:
  /// **'Aucune parcelle'**
  String get journalEmptyTitle;

  /// Description état vide journal
  ///
  /// In fr, this message translates to:
  /// **'Ajoutez votre première parcelle\npour commencer le suivi.'**
  String get journalEmptyDescription;

  /// Bouton ajouter une parcelle
  ///
  /// In fr, this message translates to:
  /// **'Ajouter une parcelle'**
  String get journalAddPlot;

  /// Libellé nom parcelle
  ///
  /// In fr, this message translates to:
  /// **'Nom de la parcelle *'**
  String get journalPlotNameLabel;

  /// Libellé description optionnelle
  ///
  /// In fr, this message translates to:
  /// **'Description (optionnel)'**
  String get journalDescriptionOptional;

  /// Libellé surface optionnelle
  ///
  /// In fr, this message translates to:
  /// **'Surface (ha, optionnel)'**
  String get journalSurfaceOptional;

  /// Validation nom parcelle requis
  ///
  /// In fr, this message translates to:
  /// **'Nom requis'**
  String get journalNameRequired;

  /// Titre écran inscription
  ///
  /// In fr, this message translates to:
  /// **'Inscription'**
  String get registerTitle;

  /// Salutation inscription
  ///
  /// In fr, this message translates to:
  /// **'Bonjour!'**
  String get registerHello;

  /// Sous-titre inscription
  ///
  /// In fr, this message translates to:
  /// **'Bienvenue sur AgriMada'**
  String get registerWelcome;

  /// Libellé nom complet
  ///
  /// In fr, this message translates to:
  /// **'Nom complet'**
  String get registerNameLabel;

  /// Libellé email inscription
  ///
  /// In fr, this message translates to:
  /// **'Email'**
  String get registerEmailLabel;

  /// Libellé mot de passe inscription
  ///
  /// In fr, this message translates to:
  /// **'Mot de passe'**
  String get registerPasswordLabel;

  /// Libellé confirmer mot de passe
  ///
  /// In fr, this message translates to:
  /// **'Confirmer mot de passe'**
  String get registerConfirmPasswordLabel;

  /// Bouton inscription
  ///
  /// In fr, this message translates to:
  /// **'S\'inscrire'**
  String get registerSubmit;

  /// Texte conditions inscription
  ///
  /// In fr, this message translates to:
  /// **'J\'accepte les Conditions d\'utilisation et la Politique de confidentialité'**
  String get registerAcceptTerms;

  /// Erreur conditions non acceptées
  ///
  /// In fr, this message translates to:
  /// **'Veuillez accepter les Conditions d\'utilisation'**
  String get registerAcceptError;

  /// Lien connexion inscription
  ///
  /// In fr, this message translates to:
  /// **'Déjà un compte?'**
  String get registerHasAccount;

  /// Texte lien connexion
  ///
  /// In fr, this message translates to:
  /// **'Se connecter'**
  String get registerLoginLink;

  /// Succès inscription
  ///
  /// In fr, this message translates to:
  /// **'Inscription réussie'**
  String get registerSuccess;

  /// Titre page prévention
  ///
  /// In fr, this message translates to:
  /// **'Prévenir les maladies'**
  String get preventionTitle;

  /// Sous-titre prévention
  ///
  /// In fr, this message translates to:
  /// **'Prévenez vos rizicultures'**
  String get preventionSubtitle;

  /// Titre astuce prévention
  ///
  /// In fr, this message translates to:
  /// **'Astuce de prévention'**
  String get preventionAstuceTitle;

  /// Description astuce prévention
  ///
  /// In fr, this message translates to:
  /// **'Des gestes simples aujourd\'hui pour un riz sain et une meilleure récolte demain'**
  String get preventionAstuceDesc;

  /// Titre astuce du moment
  ///
  /// In fr, this message translates to:
  /// **'Astuce du moment'**
  String get preventionAstuceMoment;

  /// Sous-titre gestion eau
  ///
  /// In fr, this message translates to:
  /// **'Maintenez une bonne gestion de l\'eau'**
  String get preventionWaterManagement;

  /// Description gestion eau
  ///
  /// In fr, this message translates to:
  /// **'Une bonne gestion de l\'eau limite le développement des maladies comme la pyriculariose, la bactériose et la fusariose.'**
  String get preventionWaterDesc;

  /// Titre pourquoi efficace
  ///
  /// In fr, this message translates to:
  /// **'Pourquoi c\'est efficace ?'**
  String get preventionPourquoi;

  /// Description pourquoi efficace
  ///
  /// In fr, this message translates to:
  /// **'L\'excès d\'eau et l\'humidité favorisent les champignons et bactéries. Une bonne gestion de l\'eau renforce la résistance naturelle du riz.'**
  String get preventionPourquoiDesc;

  /// Titre bon à savoir
  ///
  /// In fr, this message translates to:
  /// **'Bon à savoir'**
  String get preventionBonASavoir;

  /// Description bon à savoir
  ///
  /// In fr, this message translates to:
  /// **'Des plantes vigoureuses, un sol bien oxygéné et une eau bien gérée sont les clés d\'un riz en bonne santé.'**
  String get preventionBonASavoirDesc;

  /// Titre comment faire
  ///
  /// In fr, this message translates to:
  /// **'Comment faire ?'**
  String get preventionCommentFaire;

  /// Titre page guides
  ///
  /// In fr, this message translates to:
  /// **'Guides des maladies'**
  String get guidesTitle;

  /// Sous-titre guides
  ///
  /// In fr, this message translates to:
  /// **'Fiches d\'identification hors ligne'**
  String get guidesSubtitle;

  /// Section symptômes
  ///
  /// In fr, this message translates to:
  /// **'Symptômes'**
  String get guidesSymptoms;

  /// Section causes
  ///
  /// In fr, this message translates to:
  /// **'Causes'**
  String get guidesCauses;

  /// Section traitements
  ///
  /// In fr, this message translates to:
  /// **'Traitements'**
  String get guidesTreatments;

  /// Titre du menu
  ///
  /// In fr, this message translates to:
  /// **'Menu'**
  String get drawerMenuTitle;

  /// Titre accueil drawer
  ///
  /// In fr, this message translates to:
  /// **'Accueil'**
  String get drawerHomeTitle;

  /// Sous-titre accueil drawer
  ///
  /// In fr, this message translates to:
  /// **'Revenir à la page d\'accueil'**
  String get drawerHomeSubtitle;

  /// Titre parcelles drawer
  ///
  /// In fr, this message translates to:
  /// **'Mes parcelles'**
  String get drawerPlotsTitle;

  /// Sous-titre parcelles drawer
  ///
  /// In fr, this message translates to:
  /// **'Suivi de vos rizières et surfaces'**
  String get drawerPlotsSubtitle;

  /// Titre historique drawer
  ///
  /// In fr, this message translates to:
  /// **'Historique'**
  String get drawerHistoryTitle;

  /// Sous-titre historique drawer
  ///
  /// In fr, this message translates to:
  /// **'Liste de vos analyses passées'**
  String get drawerHistorySubtitle;

  /// Titre guides dans le drawer
  ///
  /// In fr, this message translates to:
  /// **'Guides des maladies'**
  String get drawerGuidesTitle;

  /// Sous-titre guides dans le drawer
  ///
  /// In fr, this message translates to:
  /// **'Fiches d\'identification hors ligne'**
  String get drawerGuidesSubtitle;

  /// Titre paramètres dans le drawer
  ///
  /// In fr, this message translates to:
  /// **'Paramètres'**
  String get drawerSettingsTitle;

  /// Sous-titre paramètres dans le drawer
  ///
  /// In fr, this message translates to:
  /// **'Langue et préférences'**
  String get drawerSettingsSubtitle;

  /// Titre stockage
  ///
  /// In fr, this message translates to:
  /// **'Stockage'**
  String get drawerStorage;

  /// Texte mémoire utilisée
  ///
  /// In fr, this message translates to:
  /// **'Mémoire utilisée sur ce smartphone'**
  String get drawerMemoryUsed;

  /// Bouton déconnexion drawer
  ///
  /// In fr, this message translates to:
  /// **'Déconnexion'**
  String get drawerLogout;

  /// Dernière mise à jour du modèle
  ///
  /// In fr, this message translates to:
  /// **'Dernière MAJ : {date}'**
  String drawerLastUpdate(String date);

  /// Texte modèle embarqué
  ///
  /// In fr, this message translates to:
  /// **'Modèle IA embarqué'**
  String get drawerEmbeddedModel;

  /// Titre écran paramètres
  ///
  /// In fr, this message translates to:
  /// **'Paramètres'**
  String get settingsTitle;

  /// Téléphone indisponible
  ///
  /// In fr, this message translates to:
  /// **'Téléphone indisponible'**
  String get settingsPhoneUnavailable;

  /// Région indisponible
  ///
  /// In fr, this message translates to:
  /// **'Région indisponible'**
  String get settingsRegionUnavailable;

  /// Paramètre langue
  ///
  /// In fr, this message translates to:
  /// **'Langue'**
  String get settingsLanguage;

  /// Bouton déconnexion paramètres
  ///
  /// In fr, this message translates to:
  /// **'Se déconnecter'**
  String get settingsLogout;

  /// Titre écran mot de passe oublié
  ///
  /// In fr, this message translates to:
  /// **'Mot de passe oublié'**
  String get resetPasswordTitle;

  /// Titre réinitialisation
  ///
  /// In fr, this message translates to:
  /// **'Réinitialiser le mot de passe'**
  String get resetPasswordHeadline;

  /// Instructions réinitialisation
  ///
  /// In fr, this message translates to:
  /// **'Entrez votre numéro de téléphone pour recevoir les instructions.'**
  String get resetPasswordInstruction;

  /// Label téléphone
  ///
  /// In fr, this message translates to:
  /// **'Téléphone'**
  String get resetPasswordPhoneLabel;

  /// Hint téléphone
  ///
  /// In fr, this message translates to:
  /// **'0341234567'**
  String get resetPasswordPhoneHint;

  /// Erreur champ requis
  ///
  /// In fr, this message translates to:
  /// **'Champ requis'**
  String get resetPasswordPhoneRequired;

  /// Erreur numéro invalide
  ///
  /// In fr, this message translates to:
  /// **'Numero invalide'**
  String get resetPasswordPhoneInvalid;

  /// Lien retour connexion
  ///
  /// In fr, this message translates to:
  /// **'Retour à la connexion'**
  String get resetPasswordBackToLogin;

  /// Bouton suivant onboarding
  ///
  /// In fr, this message translates to:
  /// **'Suivant'**
  String get onboardingNext;

  /// Bouton commencer onboarding
  ///
  /// In fr, this message translates to:
  /// **'Commencer'**
  String get onboardingStart;

  /// Titre slide 1
  ///
  /// In fr, this message translates to:
  /// **'Photographiez la feuille malade'**
  String get onboardingSlide1Title;

  /// Desc slide 1
  ///
  /// In fr, this message translates to:
  /// **'Placez la feuille dans le cadre. Gardez 20-30 cm de distance et une bonne lumière naturelle.'**
  String get onboardingSlide1Desc;

  /// Titre slide 2
  ///
  /// In fr, this message translates to:
  /// **'L\'IA analyse hors ligne'**
  String get onboardingSlide2Title;

  /// Desc slide 2
  ///
  /// In fr, this message translates to:
  /// **'Pas besoin d\'internet. Le diagnostic fonctionne directement sur votre téléphone.'**
  String get onboardingSlide2Desc;

  /// Titre slide 3
  ///
  /// In fr, this message translates to:
  /// **'Consultez le diagnostic'**
  String get onboardingSlide3Title;

  /// Desc slide 3
  ///
  /// In fr, this message translates to:
  /// **'Visualisez la gravité détectée, la confiance de l\'analyse et les recommandations adaptées.'**
  String get onboardingSlide3Desc;

  /// Titre slide 4
  ///
  /// In fr, this message translates to:
  /// **'Suivez vos parcelles'**
  String get onboardingSlide4Title;

  /// Desc slide 4
  ///
  /// In fr, this message translates to:
  /// **'Retrouvez l\'historique des analyses de chaque parcelle dans le journal agricole.'**
  String get onboardingSlide4Desc;

  /// Tip 1 prevention
  ///
  /// In fr, this message translates to:
  /// **'Assurez un drainage efficace de la parcelle pour éviter la stagnation d\'eau.'**
  String get preventionTip1;

  /// Tip 2 prevention
  ///
  /// In fr, this message translates to:
  /// **'Alternez les phases d\'inondation et d\'assèchement (en irrigation intermittente).'**
  String get preventionTip2;

  /// Tip 3 prevention
  ///
  /// In fr, this message translates to:
  /// **'Évitez un niveau d\'eau trop élevé en permanence (3-5 cm suffisent).'**
  String get preventionTip3;

  /// Tip 4 prevention
  ///
  /// In fr, this message translates to:
  /// **'Évitez l\'excès d\'azote, qui rend les plantes plus sensibles aux maladies.'**
  String get preventionTip4;

  /// Tip 5 prevention
  ///
  /// In fr, this message translates to:
  /// **'Nettoyez régulièrement les canaux et entrées d\'eau pour une meilleure circulation.'**
  String get preventionTip5;

  /// Statut splash initialisation
  ///
  /// In fr, this message translates to:
  /// **'Initialisation en cours...'**
  String get splashStatusInitializing;

  /// Statut splash dégradé
  ///
  /// In fr, this message translates to:
  /// **'Initialisation partielle, mode degradé.'**
  String get splashStatusDegraded;

  /// Statut splash IA prête
  ///
  /// In fr, this message translates to:
  /// **'IA prête'**
  String get splashStatusAiReady;

  /// Statut splash IA indisponible
  ///
  /// In fr, this message translates to:
  /// **'IA indisponible'**
  String get splashStatusAiUnavailable;

  /// Statut splash session active
  ///
  /// In fr, this message translates to:
  /// **'Session active'**
  String get splashStatusSessionActive;

  /// Statut splash session invité
  ///
  /// In fr, this message translates to:
  /// **'Session invité'**
  String get splashStatusSessionGuest;

  /// En-tête date CSV
  ///
  /// In fr, this message translates to:
  /// **'Date'**
  String get exportCsvDate;

  /// En-tête parcelle CSV
  ///
  /// In fr, this message translates to:
  /// **'Parcelle'**
  String get exportCsvPlot;

  /// En-tête maladie CSV
  ///
  /// In fr, this message translates to:
  /// **'Maladie'**
  String get exportCsvDisease;

  /// En-tête gravité CSV
  ///
  /// In fr, this message translates to:
  /// **'Gravité'**
  String get exportCsvSeverity;

  /// En-tête confiance CSV
  ///
  /// In fr, this message translates to:
  /// **'Confiance(%)'**
  String get exportCsvConfidence;

  /// En-tête reco CSV
  ///
  /// In fr, this message translates to:
  /// **'Recommandations'**
  String get exportCsvRecommendations;

  /// En-tête traitement CSV
  ///
  /// In fr, this message translates to:
  /// **'Traitement appliqué'**
  String get exportCsvTreatment;

  /// Footer PDF
  ///
  /// In fr, this message translates to:
  /// **'Généré par AgriMada - Agriculture intelligente'**
  String get exportPdfGeneratedBy;

  /// Titre PDF
  ///
  /// In fr, this message translates to:
  /// **'Export journal agricole'**
  String get exportPdfTitle;

  /// Toutes parcelles PDF
  ///
  /// In fr, this message translates to:
  /// **'Toutes les parcelles'**
  String get exportPdfAllPlots;

  /// Label parcelle PDF
  ///
  /// In fr, this message translates to:
  /// **'Parcelle: {plot}'**
  String exportPdfPlotLabel(String plot);

  /// Label date PDF
  ///
  /// In fr, this message translates to:
  /// **'Date d\'export: {date}'**
  String exportPdfDateLabel(String date);

  /// No description provided for @guideDisease1Name.
  ///
  /// In fr, this message translates to:
  /// **'Brûlure bactérienne'**
  String get guideDisease1Name;

  /// No description provided for @guideDisease1Desc.
  ///
  /// In fr, this message translates to:
  /// **'Maladie bactérienne qui provoque le flétrissement des feuilles. Les premiers symptômes apparaissent sous forme de lésions gris-vert le long des bords des feuilles, qui s\'étendent rapidement et deviennent jaune-blanchâtre.'**
  String get guideDisease1Desc;

  /// No description provided for @guideDisease1Symptoms.
  ///
  /// In fr, this message translates to:
  /// **'• Lésions gris-vert le long des nervures\n• Flétrissement en V sur les bords\n• Exsudat bactérien jaune par temps humide\n• Feuilles qui sèchent et blanchissent'**
  String get guideDisease1Symptoms;

  /// No description provided for @guideDisease1Causes.
  ///
  /// In fr, this message translates to:
  /// **'• Forte humidité et températures élevées\n• Excès d\'azote\n• Eau stagnante prolongée\n• Variétés sensibles'**
  String get guideDisease1Causes;

  /// No description provided for @guideDisease2Name.
  ///
  /// In fr, this message translates to:
  /// **'Tache brune'**
  String get guideDisease2Name;

  /// No description provided for @guideDisease2Desc.
  ///
  /// In fr, this message translates to:
  /// **'Maladie fongique courante du riz, surtout dans les sols carencés. Les taches brunes ovales apparaissent sur les feuilles, réduisant la capacité photosynthétique de la plante.'**
  String get guideDisease2Desc;

  /// No description provided for @guideDisease2Symptoms.
  ///
  /// In fr, this message translates to:
  /// **'• Taches brunes ovales sur les feuilles\n• Anneaux concentriques sur les lésions\n• Grains tachetés dans les cas sévères\n• Réduction du rendement'**
  String get guideDisease2Symptoms;

  /// No description provided for @guideDisease2Causes.
  ///
  /// In fr, this message translates to:
  /// **'• Carence en potassium\n• Sols pauvres et mal drainés\n• Stress hydrique\n• Forte humidité relative'**
  String get guideDisease2Causes;

  /// No description provided for @guideDisease3Name.
  ///
  /// In fr, this message translates to:
  /// **'Charbon foliaire'**
  String get guideDisease3Name;

  /// No description provided for @guideDisease3Desc.
  ///
  /// In fr, this message translates to:
  /// **'Maladie fongique qui se manifeste par des tiges noires sur les feuilles de riz. Le champignon se développe dans les tissus foliaires et forme des sores noirs remplis de spores.'**
  String get guideDisease3Desc;

  /// No description provided for @guideDisease3Symptoms.
  ///
  /// In fr, this message translates to:
  /// **'• Taches noires angulaires sur les feuilles\n• Lésions sur les gaines foliaires\n• Spores noires poudreuses\n• Affaiblissement général de la plante'**
  String get guideDisease3Symptoms;

  /// No description provided for @guideDisease3Causes.
  ///
  /// In fr, this message translates to:
  /// **'• Humidité élevée prolongée\n• Températures modérées (20-25°C)\n• Densité de semis élevée\n• Mauvais drainage'**
  String get guideDisease3Causes;

  /// No description provided for @guideDisease4Name.
  ///
  /// In fr, this message translates to:
  /// **'Plante saine'**
  String get guideDisease4Name;

  /// No description provided for @guideDisease4Desc.
  ///
  /// In fr, this message translates to:
  /// **'Votre plant de riz ne présente aucun signe de maladie. Continuez à appliquer les bonnes pratiques agricoles pour maintenir la santé de vos cultures.'**
  String get guideDisease4Desc;

  /// No description provided for @guideDisease4Symptoms.
  ///
  /// In fr, this message translates to:
  /// **'• Feuilles vertes et vigoureuses\n• Croissance régulière\n• Pas de lésions ni de décoloration\n• Tallage normal'**
  String get guideDisease4Symptoms;

  /// No description provided for @guideDisease4Causes.
  ///
  /// In fr, this message translates to:
  /// **'Bonnes pratiques agricoles :'**
  String get guideDisease4Causes;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['fr', 'mg'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'fr':
      return AppLocalizationsFr();
    case 'mg':
      return AppLocalizationsMg();
  }

  throw FlutterError(
      'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
      'an issue with the localizations generation tool. Please file an issue '
      'on GitHub with a reproducible sample app and the gen-l10n configuration '
      'that was used.');
}
