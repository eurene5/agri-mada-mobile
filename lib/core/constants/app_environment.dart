abstract final class AppEnvironment {
  static const String _appEnv = String.fromEnvironment(
    'APP_ENV',
    defaultValue: 'dev',
  );

  static const String _apiBaseUrlOverride = String.fromEnvironment(
    'API_BASE_URL',
    defaultValue: '',
  );

  static bool get isProduction => _appEnv == 'prod';

  static bool get isStaging => _appEnv == 'staging';

  static String get apiBaseUrl {
    if (_apiBaseUrlOverride.isNotEmpty) {
      return _apiBaseUrlOverride;
    }

    if (isProduction) {
      return 'https://api.agrimada.mg/api';
    }

    if (isStaging) {
      return 'https://staging-api.agrimada.mg/api';
    }

    // Android emulator loopback vers machine hote de developpement.
    return 'http://10.0.2.2:8000/api';
  }
}
