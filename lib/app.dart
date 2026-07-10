import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'core/router/app_router.dart';
import 'core/theme/app_theme.dart';
import 'features/auth/presentation/providers/auth_notifier.dart';

class CauceApp extends ConsumerStatefulWidget {
  const CauceApp({super.key});

  @override
  ConsumerState<CauceApp> createState() => _CauceAppState();
}

class _CauceAppState extends ConsumerState<CauceApp> {
  @override
  void initState() {
    super.initState();
    // Restaura sesión al arrancar la app
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(authNotifierProvider.notifier).restoreSession();
    });
  }

  @override
  Widget build(BuildContext context) {
    final router = ref.watch(appRouterProvider);
    return MaterialApp.router(
      title: 'Cauce',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      routerConfig: router,
    );
  }
}