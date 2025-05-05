import 'package:go_router/go_router.dart';

import '../features/metronome/pages/metronome_page_expert.dart';
import '../features/metronome/pages/metronome_page_simple.dart';
import 'not_found_screen.dart';

enum AppRoute {
  metronomeExpert,
  metronomeSimple,
}

final goRouter = GoRouter(
  initialLocation: '/${AppRoute.metronomeSimple.name}',
  debugLogDiagnostics: false,
  routes: [
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
