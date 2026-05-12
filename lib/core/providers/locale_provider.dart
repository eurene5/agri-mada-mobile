import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../local_db/session_service.dart';

final localeProvider = StateNotifierProvider<LocaleNotifier, Locale>(
  (_) => LocaleNotifier(),
);

class LocaleNotifier extends StateNotifier<Locale> {
  LocaleNotifier() : super(const Locale('fr')) {
    _init();
  }

  Future<void> _init() async {
    final code = await SessionService.instance.getLocaleCode();
    if (code == 'fr' || code == 'mg') {
      state = Locale(code!);
    }
  }

  Future<void> setLocale(Locale locale) async {
    state = locale;
    await SessionService.instance.saveLocaleCode(locale.languageCode);
  }

  Locale getLocale() => state;
}
