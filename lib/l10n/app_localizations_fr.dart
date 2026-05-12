// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for French (`fr`).
class AppLocalizationsFr extends AppLocalizations {
  AppLocalizationsFr([String locale = 'fr']) : super(locale);

  @override
  String get loginForgotPasswordTitle => 'Mot de passe oublie ?';

  @override
  String get loginEmailLabel => 'Email';

  @override
  String get loginEmailHint => 'nom@exemple.com';

  @override
  String get loginEmailRequired => 'Veuillez entrer votre email';

  @override
  String get loginEmailInvalid => 'Email invalide';

  @override
  String get commonCancel => 'Annuler';

  @override
  String get commonSend => 'Envoyer';

  @override
  String get featureComingSoon => 'Fonctionnalite bientot disponible';

  @override
  String get registerComingSoon => 'Inscription bientot disponible';

  @override
  String get loginTitle => 'Connexion';

  @override
  String get loginPasswordLabel => 'Mot de passe';

  @override
  String get loginPasswordRequired => 'Veuillez entrer votre mot de passe';

  @override
  String get loginForgotPassword => 'Mot de passe oublie ?';

  @override
  String get loginSubmit => 'Se connecter';

  @override
  String get loginNoAccount => 'Pas encore de compte ?';

  @override
  String get loginRegister => 'S\'inscrire';

  @override
  String get loginHello => 'Bonjour !';

  @override
  String get loginWelcome => 'Bienvenue sur AgriMada';

  @override
  String get welcomeHeadline => 'L\'intelligence au service de vos rizieres';

  @override
  String get welcomeBody =>
      'Un riz sain et protege grace a l\'expertise AgriMada.';

  @override
  String get welcomeStart => 'Commencer';

  @override
  String get homeSoonMessage => 'Bientot disponible';

  @override
  String get homeServicesTitle => 'Nos Services';

  @override
  String get homeMenuSemantics => 'Ouvrir le menu';

  @override
  String homeHelloUser(String name) {
    return 'Bonjour, $name!';
  }

  @override
  String get homeFarmerDefault => 'Agriculteur';

  @override
  String get homeReadyForAnalysis => 'Pret pour une analyse ?';

  @override
  String get homeOfflineMode => 'Mode hors ligne';

  @override
  String get homeSearchPlaceholder => 'recherche...';

  @override
  String get homeSummaryTitle => 'Resume de votre exploitation';

  @override
  String get homeSystemReady => 'Systeme pret';

  @override
  String homeRegisteredPlots(int count) {
    return '$count parcelle(s) enregistree(s)';
  }

  @override
  String get homeServicePlotsTitle => 'Mes parcelles';

  @override
  String get homeServicePlotsDescription =>
      'Suivez vos rizieres, surfaces cultivees et l\'etat sanitaire de chaque parcelle';

  @override
  String get homeServiceCropsTitle => 'Etat des cultures';

  @override
  String get homeServiceCropsDescription =>
      'Consultez l\'etat global de vos cultures et les niveaux de risque actuels';

  @override
  String get homeServiceSolutionsTitle => 'Solutions agricoles';

  @override
  String get homeServiceSolutionsDescription =>
      'Decouvrez les traitements biologiques et solutions locales recommandees';

  @override
  String get homeServicePreventionTitle => 'Prevenir les maladies';

  @override
  String get homeServicePreventionDescription =>
      'Apprenez les bonnes pratiques pour proteger vos rizieres et eviter les pertes';

  @override
  String get homeScanPlantSemantics => 'Scanner une plante';

  @override
  String get homeTabHome => 'Accueil';

  @override
  String get homeTabJournal => 'Journal';

  @override
  String get scanIaUnavailable =>
      'Diagnostic IA indisponible, veuillez reessayer';

  @override
  String get scanSelectPlot => 'Choisir une parcelle';

  @override
  String get scanNoPlotTitle => 'Aucune parcelle';

  @override
  String get scanNoPlotDescription =>
      'Creez d\'abord une parcelle dans votre journal agricole avant de scanner.';

  @override
  String get commonOk => 'OK';

  @override
  String get scanGoToJournal => 'Aller au journal';

  @override
  String get scanLoading => 'Analyse en cours...';

  @override
  String get scanPointCamera => 'Pointez la camera vers\nla feuille de riz';

  @override
  String get scanOfflineAnalysis => 'L\'analyse se fait hors ligne';

  @override
  String get scanHeaderTitle => 'Scanner une feuille';

  @override
  String get scanCancel => 'ANNULER';

  @override
  String get scanResultSaveFailed => 'Impossible d\'enregistrer le diagnostic';

  @override
  String get scanResultSaved => 'Diagnostic enregistre';

  @override
  String get scanResultBackSemantics => 'Retour';

  @override
  String get scanResultTitle => 'Resultat de l\'analyse';

  @override
  String get scanResultSubtitle => 'Analyse hors ligne terminee';

  @override
  String get diseaseBacterialLeafBlight => 'Brulure bacterienne';

  @override
  String get diseaseBrownSpot => 'Tache brune';

  @override
  String get diseaseLeafSmut => 'Charbon foliaire';

  @override
  String get diseaseHealthy => 'Plante saine';

  @override
  String scanResultConfidence(String value) {
    return '$value% de confiance';
  }

  @override
  String get scanShareTitle => 'Diagnostic AgriMada';

  @override
  String get scanShareCulture => 'Culture: Riz';

  @override
  String scanShareDisease(String disease) {
    return 'Maladie: $disease';
  }

  @override
  String scanShareConfidence(String value) {
    return 'Confiance: $value%';
  }

  @override
  String scanShareDate(String date) {
    return 'Date: $date';
  }

  @override
  String get scanSeverityTitle => 'Niveau de gravite';

  @override
  String get scanSeverityLow => 'Faible';

  @override
  String get scanSeverityMedium => 'Moyen';

  @override
  String get scanSeverityHigh => 'Eleve';

  @override
  String get scanSeverityNoneStatus => 'Aucune - Plante saine';

  @override
  String get scanSeverityLowStatus => 'Faible - Surveiller';

  @override
  String get scanSeverityMediumStatus => 'Modere - Intervention conseillee';

  @override
  String get scanSeverityHighStatus => 'Eleve - Intervention urgente';

  @override
  String get scanRecommendationsTitle => 'Recommandations adaptees';

  @override
  String get scanRecommendationItemTitle => 'Recommandation';

  @override
  String get scanTip => 'Astuce : evitez l\'arrosage excessif pendant 3 jours';

  @override
  String get scanRescanSemantics => 'Refaire un scan';

  @override
  String get scanRescan => 'Refaire un scan';

  @override
  String get scanSaveJournalSemantics => 'Enregistrer dans le journal';

  @override
  String get commonSave => 'Enregistrer';

  @override
  String get scanShareSemantics => 'Partager le resultat';

  @override
  String get scanShare => 'Partager le resultat';

  @override
  String journalError(String error) {
    return 'Erreur: $error';
  }

  @override
  String get journalNewPlot => 'Nouvelle parcelle';

  @override
  String get journalTitle => 'Journal agricole';

  @override
  String get journalSubtitle => 'Suivi de vos parcelles';

  @override
  String get journalTotal => 'Total';

  @override
  String get journalHealthyPlural => 'Saines';

  @override
  String get journalSickPlural => 'Malades';

  @override
  String get journalStatusSick => 'Malade';

  @override
  String get journalStatusHealthy => 'Sain';

  @override
  String get journalStatusNotAnalyzed => 'Non analyse';

  @override
  String journalAreaHa(String surface) {
    return '$surface ha';
  }

  @override
  String journalAnalysesCount(int count) {
    return '$count analyse(s)';
  }

  @override
  String journalLastDiagnostic(String disease, String date) {
    return 'Dernier : $disease - $date';
  }

  @override
  String get journalScan => 'Scanner';

  @override
  String get journalNoDiagnosticYet => 'Aucun diagnostic encore';

  @override
  String get journalScanNow => 'Scanner maintenant';

  @override
  String get journalEmptyTitle => 'Aucune parcelle';

  @override
  String get journalEmptyDescription =>
      'Ajoutez votre premiere parcelle\npour commencer le suivi.';

  @override
  String get journalAddPlot => 'Ajouter une parcelle';

  @override
  String get journalPlotNameLabel => 'Nom de la parcelle *';

  @override
  String get journalDescriptionOptional => 'Description (optionnel)';

  @override
  String get journalSurfaceOptional => 'Surface (ha, optionnel)';

  @override
  String get journalNameRequired => 'Nom requis';
}
