import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'app/app.dart';
import 'core/ai/tflite_service.dart';
import 'core/local_db/isar_service.dart';
import 'core/utils/logger.dart';

final isTFLiteReadyProvider = Provider<bool>((_) => false);

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // --- Initialisation des services hors-ligne ---
  await IsarService.instance.init();
  var isTFLiteReady = false;
  try {
    await TFLiteService.instance.init();
    isTFLiteReady = true;
  } catch (e, st) {
    AppLogger.error(
      'Initialisation TFLite échouée: démarrage en mode dégradé sans IA',
      error: e,
      stackTrace: st,
    );
  }

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  runApp(
    ProviderScope(
      overrides: [
        isTFLiteReadyProvider.overrideWithValue(isTFLiteReady),
      ],
      child: const AgriMadaApp(),
    ),
  );
}
