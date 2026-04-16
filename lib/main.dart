import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'core/error/startup_error_page.dart';
import 'core/navigation/router.dart';
import 'core/startup/app_startup_provider.dart';
import 'core/theme/app_theme.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Lock orientation
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  // Global Flutter error handling
  FlutterError.onError = (details) {
    FlutterError.presentError(details);
    // TODO: Send to Crashlytics
  };

  // Run app inside a guarded zone for async errors
  runZonedGuarded(
        () {
      runApp(const ProviderScope(child: MyApp()));
    },
        (error, stackTrace) {
      // TODO: Send to Crashlytics
      debugPrint('Uncaught async error: $error');
    },
  );
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(goRouterProvider);

    return MaterialApp.router(
      title: 'Airoster',
      debugShowCheckedModeBanner: false,

      themeMode: ThemeMode.system,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,

      routerConfig: router,
    );
  }
}

class AppShell extends ConsumerWidget{
  const AppShell({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final startup = ref.watch(appStartupProvider);

    return startup.when(
      loading: () => const Center(), //splash page

      error: (error, stackTrace) => StartupErrorPage(
        error: error,
        onRetry: () {
          ref.invalidate(appStartupProvider);
        },
      ),

      data: (_) => const Center(), //home page
    );
  }
}