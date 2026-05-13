import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../features/auth/presentation/screens/splash_screen.dart';
import '../features/auth/presentation/screens/welcome_screen.dart';
import '../features/auth/presentation/screens/login_screen.dart';
import '../features/auth/presentation/screens/register_screen.dart';
import '../features/auth/presentation/screens/reset_password_screen.dart';
import '../features/home/presentation/screens/home_screen.dart';
import '../features/home/presentation/screens/settings_screen.dart';
import '../features/scan/presentation/screens/scanning_screen.dart';
import '../features/scan/presentation/screens/scan_result_screen.dart';
import '../features/journal/presentation/screens/journal_screen.dart';
import '../features/onboarding/presentation/screens/onboarding_screen.dart';
import '../core/local_db/session_service.dart';

abstract final class AppRoutes {
  static const String splash = '/';
  static const String welcome = '/welcome';
  static const String login = '/login';
  static const String register = '/register';
  static const String reset = '/reset';
  static const String home = '/home';
  static const String settings = '/settings';
  static const String scanning = '/scanning';
  static const String scanResult = '/scan-result';
  static const String journal = '/journal';
  static const String onboarding = '/onboarding';
}

final routerProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: AppRoutes.splash,
    redirect: (context, state) async {
      final isOnboardingDone = await SessionService.instance.isOnboardingDone();
      final isLoggedIn = await SessionService.instance.isLoggedIn();
      final route = state.matchedLocation;
      final isSplashRoute = route == AppRoutes.splash;
      final isAuthRoute = route == AppRoutes.welcome ||
          route == AppRoutes.login ||
          route == AppRoutes.register ||
          route == AppRoutes.reset;
      final isProtectedRoute = route == AppRoutes.home ||
          route == AppRoutes.settings ||
          route == AppRoutes.scanning ||
          route == AppRoutes.scanResult ||
          route == AppRoutes.journal;
      final isOnboardingConsultationMode =
          state.uri.queryParameters['mode'] == 'help';

      if (!isOnboardingDone && route != AppRoutes.onboarding) {
        return AppRoutes.onboarding;
      }

      if (isOnboardingDone &&
          route == AppRoutes.onboarding &&
          !isOnboardingConsultationMode) {
        return isLoggedIn ? AppRoutes.home : AppRoutes.welcome;
      }

      if (!isLoggedIn && isProtectedRoute) {
        return AppRoutes.login;
      }

      if (isLoggedIn && (isSplashRoute || isAuthRoute)) {
        return AppRoutes.home;
      }

      if (!isLoggedIn && isSplashRoute) {
        return AppRoutes.welcome;
      }

      return null;
    },
    routes: [
      GoRoute(
        path: AppRoutes.splash,
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        path: AppRoutes.welcome,
        builder: (context, state) => const WelcomeScreen(),
      ),
      GoRoute(
        path: AppRoutes.login,
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: AppRoutes.register,
        builder: (context, state) => const RegisterScreen(),
      ),
      GoRoute(
        path: AppRoutes.reset,
        builder: (context, state) => const ResetPasswordScreen(),
      ),
      GoRoute(
        path: AppRoutes.home,
        builder: (context, state) => const HomeScreen(),
      ),
      GoRoute(
        path: AppRoutes.settings,
        builder: (context, state) => const SettingsScreen(),
      ),
      GoRoute(
        path: AppRoutes.scanning,
        builder: (context, state) => const ScanningScreen(),
      ),
      GoRoute(
        path: AppRoutes.scanResult,
        builder: (context, state) => const ScanResultScreen(),
      ),
      GoRoute(
        path: AppRoutes.journal,
        builder: (context, state) => const JournalScreen(),
      ),
      GoRoute(
        path: AppRoutes.onboarding,
        builder: (context, state) => OnboardingScreen(
          consultationMode: state.uri.queryParameters['mode'] == 'help',
        ),
      ),
    ],
  );
});
