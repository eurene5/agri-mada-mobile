import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:agri_mada/l10n/app_localizations.dart';

import '../core/providers/locale_provider.dart';
import 'theme/app_theme.dart';
import 'router.dart';

class AgriMadaApp extends ConsumerWidget {
  const AgriMadaApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(routerProvider);
    final locale = ref.watch(localeProvider);

    return MaterialApp.router(
      title: 'AgriMada',
      theme: AppTheme.light,
      locale: locale,
      supportedLocales: const [
        Locale('fr'),
        Locale('mg'),
      ],
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      routerConfig: router,
      debugShowCheckedModeBanner: false,
    );
  }
}
