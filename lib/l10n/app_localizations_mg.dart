// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Malagasy (`mg`).
class AppLocalizationsMg extends AppLocalizations {
  AppLocalizationsMg([String locale = 'mg']) : super(locale);

  @override
  String get splashSubtitle => 'Mamorona aretina vary, tsy misy aterineto';

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
  String get scanRecBlbEvacuateWater =>
      'Avoahy ny rano ao amin\'ny tanimbary misy aretina';

  @override
  String get scanRecBlbApplyCopper => 'Ampiharo hydroxyde de cuivre (2-3 g/L)';

  @override
  String get scanRecBlbAvoidNitrogen => 'Hialao ny azota be loatra';

  @override
  String get scanRecBlbUseResistantVarieties =>
      'Ampiasao karazana vary mafy orina amin\'ny fiainana manaraka';

  @override
  String get scanRecBrownSpotFertilize =>
      'Hamafiso ny fanatsarana ny fertilisation (potassium)';

  @override
  String get scanRecBrownSpotApplyFungicide =>
      'Ampiharo fongicide mifototra amin\'ny mancozèbe';

  @override
  String get scanRecBrownSpotDrainage => 'Antoka ny drainage tsara';

  @override
  String get scanRecBrownSpotAvoidStress => 'Hialao ny stress hydrique';

  @override
  String get scanRecLeafSmutTreatSeeds =>
      'Tsabohy ny voan-bary alohan\'ny fambolena';

  @override
  String get scanRecLeafSmutApplyFungicide => 'Ampiharo fongicide systémique';

  @override
  String get scanRecLeafSmutRemovePlants =>
      'Esory ary doavy ny zavamaniry misy aretina';

  @override
  String get scanRecLeafSmutRotation => 'Soso-kevitr\'ny fihodinana voly';

  @override
  String get scanRecHealthy =>
      'Zavamaniry salama. Tohizy ny fanao tsara amin\'ny fambolena.';

  @override
  String get scanRecHealthyWater => 'Ataovy tsara ny fitantanana ny rano';

  @override
  String get scanRecHealthyFertilization => 'Fametrahana zezika voalanjalanja';

  @override
  String get scanRecHealthyMonitoring => 'Fanaraha-maso matetika ny tanimbary';

  @override
  String get scanRecHealthyRotation => 'Fihodinana voly';

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

  @override
  String get registerTitle => 'Hisoratra anarana';

  @override
  String get registerHello => 'Salama!';

  @override
  String get registerWelcome => 'Tongasoa eto amin\'ny AgriMada';

  @override
  String get registerNameLabel => 'Anarana feno';

  @override
  String get registerEmailLabel => 'Mailaka';

  @override
  String get registerPasswordLabel => 'Teny miafina';

  @override
  String get registerConfirmPasswordLabel => 'Hamarino ny teny miafina';

  @override
  String get registerSubmit => 'Hisoratra anarana';

  @override
  String get registerAcceptTerms =>
      'Manaiky ny Fepetra fampiasana sy ny Politika momba ny fiainana manokana aho';

  @override
  String get registerAcceptError => 'Mba ekeo ny Fepetra fampiasana';

  @override
  String get registerHasAccount => 'Efa manana kaonty?';

  @override
  String get registerLoginLink => 'Hiditra';

  @override
  String get registerSuccess => 'Soa aman-tsara ny fisoratana anarana';

  @override
  String get preventionTitle => 'Misoroka ny aretina';

  @override
  String get preventionSubtitle => 'Arovy ny fambolena vary';

  @override
  String get preventionAstuceTitle => 'Torohay fisorohana';

  @override
  String get preventionAstuceDesc =>
      'Fihetsika tsotra anio ho an\'ny vary salama sy vokatra tsara kokoa rahampitso';

  @override
  String get preventionAstuceMoment => 'Torohay amin\'izao fotoana izao';

  @override
  String get preventionWaterManagement =>
      'Tantano tsara ny fitantanana ny rano';

  @override
  String get preventionWaterDesc =>
      'Ny fitantanana ny rano tsara dia mametra ny fivoaran\'ny aretina toy ny pyriculariose, bactériose ary fusariose.';

  @override
  String get preventionPourquoi => 'Fa maninona no mandaitra izany?';

  @override
  String get preventionPourquoiDesc =>
      'Ny rano be sy ny hamandoana dia mampiroborobo ny holatra sy bakteria. Ny fitantanana ny rano tsara dia manamafy ny fanoherana voajanahary ny vary.';

  @override
  String get preventionBonASavoir => 'Tsara ho fantatra';

  @override
  String get preventionBonASavoirDesc =>
      'Ny zavamaniry mavitrika, ny tany misy oksizenina tsara ary ny rano voatantana tsara dia fanalahidin\'ny vary salama.';

  @override
  String get preventionCommentFaire => 'Ahoana no fanaovana izany?';

  @override
  String get guidesTitle => 'Torolalana momba ny aretina';

  @override
  String get guidesSubtitle => 'Takelaka famantarana tsy misy aterineto';

  @override
  String get guidesSymptoms => 'Soritr\'aretina';

  @override
  String get guidesCauses => 'Antony';

  @override
  String get guidesTreatments => 'Fitsaboana';

  @override
  String get drawerMenuTitle => 'Menio';

  @override
  String get drawerHomeTitle => 'Fandraisana';

  @override
  String get drawerHomeSubtitle => 'Hiverina amin\'ny fandraisana';

  @override
  String get drawerPlotsTitle => 'Tanimbary';

  @override
  String get drawerPlotsSubtitle => 'Fanaraha-maso ny tanimbary';

  @override
  String get drawerHistoryTitle => 'Tantara';

  @override
  String get drawerHistorySubtitle => 'Lisitry ny fanadihadiana';

  @override
  String get drawerGuidesTitle => 'Torolalana momba ny aretina';

  @override
  String get drawerGuidesSubtitle => 'Takelaka famantarana tsy misy aterineto';

  @override
  String get drawerSettingsTitle => 'Fikirakirana';

  @override
  String get drawerSettingsSubtitle => 'Fiteny sy safidy';

  @override
  String get drawerStorage => 'Fitehirizana';

  @override
  String get drawerMemoryUsed => 'Fitehirizana ampiasaina amin\'ity finday ity';

  @override
  String get drawerLogout => 'Hivoaka';

  @override
  String drawerLastUpdate(String date) {
    return 'Fanavaozana farany : $date';
  }

  @override
  String get drawerEmbeddedModel => 'Modely IA anaty';

  @override
  String get settingsTitle => 'Fikirakirana';

  @override
  String get settingsPhoneUnavailable => 'Tsy misy nomerao';

  @override
  String get settingsRegionUnavailable => 'Tsy misy faritra';

  @override
  String get settingsLanguage => 'Fiteny';

  @override
  String get settingsLogout => 'Hivoaka';

  @override
  String get resetPasswordTitle => 'Hadino ny teny miafina';

  @override
  String get resetPasswordHeadline => 'Hamerina ny teny miafina';

  @override
  String get resetPasswordInstruction =>
      'Ampidiro ny nomeraon-telefaoninao handraisana ny toromarika.';

  @override
  String get resetPasswordPhoneLabel => 'Telefaonina';

  @override
  String get resetPasswordPhoneHint => '0341234567';

  @override
  String get resetPasswordPhoneRequired => 'Tsy maintsy fenoina';

  @override
  String get resetPasswordPhoneInvalid => 'Nomerao tsy mitombina';

  @override
  String get resetPasswordBackToLogin => 'Hiverina amin\'ny fidirana';

  @override
  String get onboardingNext => 'Manaraka';

  @override
  String get onboardingStart => 'Hanomboka';

  @override
  String get onboardingSlide1Title => 'Alao sary ny ravina marary';

  @override
  String get onboardingSlide1Desc =>
      'Apetraho ao anatin\'ny tabilao ny ravina. Mijanòna eo amin\'ny 20-30 cm ary hazavana tsara.';

  @override
  String get onboardingSlide2Title => 'Manadihady ivelan\'ny tambajotra ny IA';

  @override
  String get onboardingSlide2Desc =>
      'Tsy mila aterineto. Mandeha mivantana amin\'ny findainao ny fitiliana.';

  @override
  String get onboardingSlide3Title => 'Jereo ny vokatra';

  @override
  String get onboardingSlide3Desc =>
      'Jereo ny hamafin\'ny aretina, ny fahamendrehan\'ny vokatra ary ny toro-hevitra mifanaraka aminy.';

  @override
  String get onboardingSlide4Title => 'Araho ny tanimbarinao';

  @override
  String get onboardingSlide4Desc =>
      'Tadiavo ao amin\'ny boky ny tantaran\'ny fitiliana ho an\'ny tanimbary tsirairay.';

  @override
  String get preventionTip1 =>
      'Ataovy tsara ny fivoahan\'ny rano eo amin\'ny tanimbary hisorohana ny rano miandrona.';

  @override
  String get preventionTip2 =>
      'Avadiho matetika ny fotoana feno rano sy maina (fitarihan-drano mitsitapatapaka).';

  @override
  String get preventionTip3 =>
      'Hialao ny rano be loatra mitohy (ampy ny 3-5 cm).';

  @override
  String get preventionTip4 =>
      'Hialao ny azota be loatra, mahatonga ny vary ho mora voan\'ny aretina.';

  @override
  String get preventionTip5 =>
      'Diovy matetika ny lakandrano sy ny fidirandrano mba hikorianan\'ny rano tsara.';

  @override
  String get splashStatusInitializing => 'Eo am-panombohana...';

  @override
  String get splashStatusDegraded => 'Fanombohana tsy feno.';

  @override
  String get splashStatusAiReady => 'Vonona ny IA';

  @override
  String get splashStatusAiUnavailable => 'Tsy misy ny IA';

  @override
  String get splashStatusSessionActive => 'Kaonty mavitrika';

  @override
  String get splashStatusSessionGuest => 'Kaonty vahiny';

  @override
  String get exportCsvDate => 'Daty';

  @override
  String get exportCsvPlot => 'Tanimbary';

  @override
  String get exportCsvDisease => 'Aretina';

  @override
  String get exportCsvSeverity => 'Hamafiny';

  @override
  String get exportCsvConfidence => 'Fahamendrehana(%)';

  @override
  String get exportCsvRecommendations => 'Toro-hevitra';

  @override
  String get exportCsvTreatment => 'Fitsaboana natao';

  @override
  String get exportPdfGeneratedBy =>
      'Navoakan\'ny AgriMada - Fambolena manara-penitra';

  @override
  String get exportPdfTitle => 'Tantaran\'ny tanimbary';

  @override
  String get exportPdfAllPlots => 'Tanimbary rehetra';

  @override
  String exportPdfPlotLabel(String plot) {
    return 'Tanimbary: $plot';
  }

  @override
  String exportPdfDateLabel(String date) {
    return 'Daty hamoahana: $date';
  }

  @override
  String get guideDisease1Name => 'Aretin\'ny bakteria (Brûlure bactérienne)';

  @override
  String get guideDisease1Desc =>
      'Aretin\'ny bakteria izay mahatonga ny ravina ho malazo. Ny fambara voalohany dia mipoitra toy ny pentina fotsy-maitso eo amoron\'ny ravina, izay mitatra haingana ary lasa fotsy-mavo.';

  @override
  String get guideDisease1Symptoms =>
      '• Pentina fotsy-maitso eo amoron\'ny hazondravina\n• Malazo miendrika V eo amin\'ny sisiny\n• Misy rano mavo rehefa mando ny andro\n• Ravina maina ary mivadika fotsy';

  @override
  String get guideDisease1Causes =>
      '• Hamandoana be sy hafanana ambony\n• Azota be loatra\n• Rano miandrona maharitra\n• Karazam-bary mora voa';

  @override
  String get guideDisease2Name => 'Pentina mainty (Tache brune)';

  @override
  String get guideDisease2Desc =>
      'Aretin\'ny holatra matetika amin\'ny vary, indrindra amin\'ny tany mahantra. Mipoitra eo amin\'ny ravina ny pentina mainty lavalava, ka mampihena ny fahafahan\'ny zavamaniry mamelona.';

  @override
  String get guideDisease2Symptoms =>
      '• Pentina mainty lavalava eo amin\'ny ravina\n• Misy faribolana eo amin\'ny fery\n• Voam-bary misy pentina raha mafy ny aretina\n• Mihena ny vokatra';

  @override
  String get guideDisease2Causes =>
      '• Tsy fisian\'ny potasioma\n• Tany mahantra sy tsy tsara fivoahan-drano\n• Tsy fahampian-drano\n• Hamandoana be';

  @override
  String get guideDisease3Name => 'Aretin\'ny holatra (Charbon foliaire)';

  @override
  String get guideDisease3Desc =>
      'Aretin\'ny holatra izay hita amin\'ny tsorakazo mainty eo amin\'ny ravin-bary. Mivoatra ao anatin\'ny ravina ny holatra ary mamorona faritra mainty feno voany.';

  @override
  String get guideDisease3Symptoms =>
      '• Pentina mainty misy zoro eo amin\'ny ravina\n• Fery eo amin\'ny fonon-dravina\n• Vovoka mainty\n• Mihamalemy ny zavamaniry';

  @override
  String get guideDisease3Causes =>
      '• Hamandoana ambony maharitra\n• Hafanana antonony (20-25°C)\n• Famafazana mifanety loatra\n• Fivoahan-drano ratsy';

  @override
  String get guideDisease4Name => 'Zavamaniry salama';

  @override
  String get guideDisease4Desc =>
      'Tsy ahitana soritr\'aretina ny varinao. Tohizo ny fampiharana ny fomba fambolena tsara mba hitazomana ny fahasalaman\'ny volinao.';

  @override
  String get guideDisease4Symptoms =>
      '• Ravina maitso sy matanjaka\n• Fitomboana ara-dalàna\n• Tsy misy fery na fiovan\'ny loko\n• Fitsimohana ara-dalàna';

  @override
  String get guideDisease4Causes => 'Fomba fambolena tsara :';
}
