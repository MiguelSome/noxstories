import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'app/app_router.dart';
import 'core/constants/app_theme.dart';

void main() {
  runApp(
    const ProviderScope(
      child: NoxStoriesApp(),
    ),
  );
}

class NoxStoriesApp extends StatelessWidget {
  const NoxStoriesApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'NoxStories',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.darkTheme,
      routerConfig: appRouter,
    );
  }
}
