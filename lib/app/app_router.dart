import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'main_shell_screen.dart';
import '../features/auth/presentation/login_screen.dart';
import '../features/home/presentation/home_screen.dart';
import '../features/explore/presentation/explore_screen.dart';

final GlobalKey<NavigatorState> _rootNavigatorKey = GlobalKey<NavigatorState>();
final GlobalKey<NavigatorState> _shellNavigatorKey = GlobalKey<NavigatorState>();

final GoRouter appRouter = GoRouter(
  navigatorKey: _rootNavigatorKey,
  initialLocation: '/login',
  routes: [
    GoRoute(
      path: '/login',
      builder: (context, state) => const LoginScreen(),
    ),
    ShellRoute(
      navigatorKey: _shellNavigatorKey,
      builder: (context, state, child) {
        return MainShellScreen(child: child);
      },
      routes: [
        GoRoute(
          path: '/',
          builder: (context, state) => const HomeScreen(),
        ),
        GoRoute(
          path: '/explore',
          builder: (context, state) => const ExploreScreen(),
        ),
      ],
    ),
  ],
);