// Modèle Isar - Diagnostic local (résultat IA hors-ligne)
// Les maladies détectables correspondent aux labels du modèle :
//   - Bacterial leaf blight
//   - Brown spot
//   - Leaf smut

import 'package:isar/isar.dart';

part 'diagnostic_local.g.dart';

@collection
class DiagnosticLocal {
  Id id = Isar.autoIncrement;

  // Lien vers la parcelle locale
  late int parcelleLocalId;

  late String maladieDetectee; // Label retourné par TFLite
  double? confiance; // Score entre 0.0 et 1.0
  String? niveauGravite; // faible / modéré / sévère
  String? recommandations;
  String? imagePath; // Chemin local de la photo prise

  late DateTime dateDiagnostic;

  // false = pas encore envoyé au serveur FastAPI
  bool isSynced = false;

  // Optionnel : ID serveur après synchro
  int? serverId;
}
