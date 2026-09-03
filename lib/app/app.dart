import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'routes.dart';
import 'theme.dart';

class EuroOneApp extends ConsumerWidget {
  const EuroOneApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(appRouterProvider);

    return MaterialApp.router(
      title: 'EuroONE',
      debugShowCheckedModeBanner: false,
      theme: buildEuroOneTheme(),
      routerConfig: router,
    );
  }
}
