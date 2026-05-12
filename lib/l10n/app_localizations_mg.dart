// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Malagasy (`mg`).
class AppLocalizationsMg extends AppLocalizations {
  AppLocalizationsMg([String locale = 'mg']) : super(locale);

  @override
  String get loginForgotPasswordTitle => 'Hadino ny teny miafina ?';

  @override
  String get loginEmailLabel => 'Mailaka';

  @override
  String get loginEmailHint => 'anarana@ohatra.com';

  @override
  String get loginEmailRequired => 'Ampidiro azafady ny mailakao';

  @override
  String get loginEmailInvalid => 'Mailaka tsy manan-kery';

  @override
  String get commonCancel => 'Hanafoana';

  @override
  String get commonSend => 'Alefa';

  @override
  String get featureComingSoon => 'Tsy ho ela dia ho azo ampiasaina';

  @override
  String get registerComingSoon => 'Fisoratana anarana tsy ho ela';

  @override
  String get loginTitle => 'Fidirana';

  @override
  String get loginPasswordLabel => 'Teny miafina';

  @override
  String get loginPasswordRequired => 'Ampidiro azafady ny teny miafina';

  @override
  String get loginForgotPassword => 'Hadino ny teny miafina ?';

  @override
  String get loginSubmit => 'Hiditra';

  @override
  String get loginNoAccount => 'Tsy mbola manana kaonty ?';

  @override
  String get loginRegister => 'Hisoratra anarana';

  @override
  String get loginHello => 'Miarahaba !';

  @override
  String get loginWelcome => 'Tongasoa eto amin\'ny AgriMada';

  @override
  String get welcomeHeadline => 'Ny faharanitan-tsaina ho an\'ny tanimbary';

  @override
  String get welcomeBody =>
      'Vary salama sy voaaro miaraka amin\'ny fahaiza-manaon\'i AgriMada.';

  @override
  String get welcomeStart => 'Hanomboka';

  @override
  String get homeSoonMessage => 'Tsy ho ela dia ho tonga';

  @override
  String get homeServicesTitle => 'Tolotra';

  @override
  String get homeMenuSemantics => 'Hanokatra menio';

  @override
  String homeHelloUser(String name) {
    return 'Miarahaba, $name!';
  }

  @override
  String get homeFarmerDefault => 'Mpamboly';

  @override
  String get homeReadyForAnalysis => 'Vonona hanao fanadihadiana ?';

  @override
  String get homeOfflineMode => 'Fomba ivelan\'ny tambajotra';

  @override
  String get homeSearchPlaceholder => 'mitady...';

  @override
  String get homeSummaryTitle => 'Topi-maso ny toeram-pamokaranao';

  @override
  String get homeSystemReady => 'Vonona ny rafitra';

  @override
  String homeRegisteredPlots(int count) {
    return '$count tanim-bary voasoratra';
  }

  @override
  String get homeServicePlotsTitle => 'Tanimbary';

  @override
  String get homeServicePlotsDescription =>
      'Araho ny tanimbary, ny velarana volena ary ny sata ara-pahasalamany';

  @override
  String get homeServiceCropsTitle => 'Satan\'ny voly';

  @override
  String get homeServiceCropsDescription =>
      'Jereo ny sata ankapobeny sy ny haavon\'ny loza amin\'izao fotoana';

  @override
  String get homeServiceSolutionsTitle => 'Vahaolana ara-pambolena';

  @override
  String get homeServiceSolutionsDescription =>
      'Fantaro ireo fitsaboana biolojika sy vahaolana eo an-toerana soso-kevitra';

  @override
  String get homeServicePreventionTitle => 'Fisorohana aretina';

  @override
  String get homeServicePreventionDescription =>
      'Ianaro ny fanao tsara hiarovana ny tanimbary sy hisorohana fatiantoka';

  @override
  String get homeScanPlantSemantics => 'Hanadihady zavamaniry';

  @override
  String get homeTabHome => 'Fandraisana';

  @override
  String get homeTabJournal => 'Boky';

  @override
  String get scanIaUnavailable =>
      'Tsy misy ny diagnostika IA, andramo indray azafady';

  @override
  String get scanSelectPlot => 'Hisafidy parcelle (parcelle)';

  @override
  String get scanNoPlotTitle => 'Tsy misy parcelle (parcelle)';

  @override
  String get scanNoPlotDescription =>
      'Mamorona parcelle (parcelle) aloha ao amin\'ny boky ara-pambolena vao manao scan.';

  @override
  String get commonOk => 'OK';

  @override
  String get scanGoToJournal => 'Handeha any amin\'ny boky';

  @override
  String get scanLoading => 'Mandeha ny fanadihadiana...';

  @override
  String get scanPointCamera => 'Tondroy ny fakan-tsary\namin\'ny ravin-bary';

  @override
  String get scanOfflineAnalysis => 'Atao eto an-toerana ny fanadihadiana';

  @override
  String get scanHeaderTitle => 'Hijery ravina';

  @override
  String get scanCancel => 'HANAFOANA';

  @override
  String get scanResultSaveFailed => 'Tsy afaka mitahiry ny diagnostika';

  @override
  String get scanResultSaved => 'Voatahiry ny diagnostika';

  @override
  String get scanResultBackSemantics => 'Miverina';

  @override
  String get scanResultTitle => 'Vokatry ny fanadihadiana';

  @override
  String get scanResultSubtitle =>
      'Vita ny fanadihadiana ivelan\'ny tambajotra';

  @override
  String get diseaseBacterialLeafBlight =>
      'May bakteria amin\'ny ravina (Brulure bacterienne)';

  @override
  String get diseaseBrownSpot => 'Tasy volontany (Tache brune)';

  @override
  String get diseaseLeafSmut => 'Arina amin\'ny ravina (Charbon foliaire)';

  @override
  String get diseaseHealthy => 'Zavamaniry salama';

  @override
  String scanResultConfidence(String value) {
    return '$value% fitokisana';
  }

  @override
  String get scanShareTitle => 'Diagnostika AgriMada';

  @override
  String get scanShareCulture => 'Voly: Vary';

  @override
  String scanShareDisease(String disease) {
    return 'Aretina: $disease';
  }

  @override
  String scanShareConfidence(String value) {
    return 'Fitokisana: $value%';
  }

  @override
  String scanShareDate(String date) {
    return 'Daty: $date';
  }

  @override
  String get scanSeverityTitle => 'Haavon\'ny hamafin\'ny aretina';

  @override
  String get scanSeverityLow => 'Ambany';

  @override
  String get scanSeverityMedium => 'Antonony';

  @override
  String get scanSeverityHigh => 'Avo';

  @override
  String get scanSeverityNoneStatus => 'Tsy misy - Zavamaniry salama';

  @override
  String get scanSeverityLowStatus => 'Ambany - Araho maso';

  @override
  String get scanSeverityMediumStatus =>
      'Antonony - Mila fandraisana andraikitra';

  @override
  String get scanSeverityHighStatus => 'Avo - Mila vonjy maika';

  @override
  String get scanRecommendationsTitle => 'Soso-kevitra mifanaraka';

  @override
  String get scanRecommendationItemTitle => 'Soso-kevitra';

  @override
  String get scanTip =>
      'Torohevitra : aza manondraka be loatra mandritra ny 3 andro';

  @override
  String get scanRescanSemantics => 'Hanao scan indray';

  @override
  String get scanRescan => 'Hanao scan indray';

  @override
  String get scanSaveJournalSemantics => 'Hotehirizina ao amin\'ny boky';

  @override
  String get commonSave => 'Tehirizo';

  @override
  String get scanShareSemantics => 'Hizara ny vokatra';

  @override
  String get scanShare => 'Hizara ny vokatra';

  @override
  String journalError(String error) {
    return 'Hadisoana: $error';
  }

  @override
  String get journalNewPlot => 'Parcelle vaovao (parcelle)';

  @override
  String get journalTitle => 'Boky ara-pambolena';

  @override
  String get journalSubtitle => 'Fanaraha-maso ny parcelle (parcelle)';

  @override
  String get journalTotal => 'Fitambarany';

  @override
  String get journalHealthyPlural => 'Salama';

  @override
  String get journalSickPlural => 'Marary';

  @override
  String get journalStatusSick => 'Marary';

  @override
  String get journalStatusHealthy => 'Salama';

  @override
  String get journalStatusNotAnalyzed => 'Tsy nohadihadiana';

  @override
  String journalAreaHa(String surface) {
    return '$surface ha';
  }

  @override
  String journalAnalysesCount(int count) {
    return 'Fanadihadiana $count';
  }

  @override
  String journalLastDiagnostic(String disease, String date) {
    return 'Farany : $disease - $date';
  }

  @override
  String get journalScan => 'Hijery';

  @override
  String get journalNoDiagnosticYet => 'Tsy mbola misy diagnostika';

  @override
  String get journalScanNow => 'Hijery izao';

  @override
  String get journalEmptyTitle => 'Tsy misy parcelle (parcelle)';

  @override
  String get journalEmptyDescription =>
      'Ampio ny parcelle (parcelle) voalohany\nhanombohana ny fanaraha-maso.';

  @override
  String get journalAddPlot => 'Hanampy parcelle (parcelle)';

  @override
  String get journalPlotNameLabel => 'Anaran\'ny parcelle (parcelle) *';

  @override
  String get journalDescriptionOptional => 'Fanazavana (tsy voatery)';

  @override
  String get journalSurfaceOptional => 'Velarana (ha, tsy voatery)';

  @override
  String get journalNameRequired => 'Ilaina ny anarana';
}
