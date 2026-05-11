import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'app/app.dart';
import 'core/local_db/isar_service.dart';
import 'core/ai/tflite_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // --- Initialisation des services hors-ligne ---
  await IsarService.instance.init();
  await TFLiteService.instance.init();

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  runApp(
    const ProviderScope(
      child: AgriMadaApp(),
    ),
  );
}
