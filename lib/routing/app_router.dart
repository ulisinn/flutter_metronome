import 'package:go_router/go_router.dart';

import '../features/metronome/pages/metronome_page.dart';
import 'not_found_screen.dart';

enum AppRoute {
  metronome,
}

final goRouter = GoRouter(
  initialLocation: '/',
  debugLogDiagnostics: false,
  routes: [
    GoRoute(
      path: '/',
      name: AppRoute.metronome.name,
      builder: (context, state) => const MetronomePage(),
    ),
  ],
  errorBuilder: (context, state) => const NotFoundScreen(),
);
