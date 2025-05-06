import 'package:flutter_metronome/playground.dart';
import 'package:go_router/go_router.dart';

import '../features/metronome/pages/metronome_page_expert.dart';
import '../features/metronome/pages/metronome_page_simple.dart';
import '../home.dart';
import 'not_found_screen.dart';

enum AppRoute {
  home,
  playground,
  metronomeExpert,
  metronomeSimple,
}

final goRouter = GoRouter(
  initialLocation: '/',
  debugLogDiagnostics: false,
  routes: [
    GoRoute(
      path: '/',
      name: AppRoute.home.name,
      builder: (context, state) => const Home(),
    ),
    GoRoute(
      path: '/${AppRoute.playground.name}',
      name: AppRoute.playground.name,
      builder: (context, state) => const Playground(),
    ),
    GoRoute(
      path: '/${AppRoute.metronomeExpert.name}',
      name: AppRoute.metronomeExpert.name,
      builder: (context, state) => const MetronomePageExpert(),
    ),
    GoRoute(
      path: '/${AppRoute.metronomeSimple.name}',
      name: AppRoute.metronomeSimple.name,
      builder: (context, state) => const MetronomePageSimple(),
    ),
  ],
  errorBuilder: (context, state) => const NotFoundScreen(),
);
