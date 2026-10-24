import 'package:azul_pass/domain/entities/buyer_entity.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../presentation/features/home/view/home_screen.dart';
import '../../presentation/features/matches/view/matches_screen.dart';
import '../../presentation/features/tickets/view/tickets_screen.dart';
import '../../presentation/features/info/view/info_screen.dart';
import '../../presentation/features/shop/view/shop_screen.dart';
import '../../presentation/features/matches/view/match_details_screen.dart';
import '../../presentation/features/tickets/view/sector_selection_screen.dart';
import '../../presentation/features/tickets/view/buyer_data_screen.dart';
import '../../presentation/features/tickets/view/payment_screen.dart';

/// Configuración centralizada de rutas usando GoRouter
final appRouter = GoRouter(
  initialLocation: '/', // Ruta inicial
  routes: [
    // ShellRoute: Mantiene la BottomNavigationBar visible mientras cambiamos de pestaña
    ShellRoute(
      builder: (context, state, child) {
        return ScaffoldWithNavBar(child: child);
      },
      routes: [
        GoRoute(
          path: '/',
          name: 'home', // Nombre de la ruta (útil para navegar por nombre)
          builder: (context, state) => const HomeScreen(),
        ),
        GoRoute(
          path: '/partidos',
          name: 'matches',
          builder: (context, state) => const MatchesScreen(),
          routes: [
            // Ruta anidada para detalles del partido
            GoRoute(
              path: ':id',
              name: 'match_detail',
              builder: (context, state) {
                final matchId = state.pathParameters['id']!;
                return MatchDetailScreen(matchId: matchId);
              },
              routes: [
                // Ruta anidada para selección de sector
                GoRoute(
                  path: 'sector',
                  name: 'sector_selection',
                  builder: (context, state) {
                    final matchId = state.pathParameters['id']!;
                    return SectorSelectionScreen(matchId: matchId);
                  },
                ),
                GoRoute(
                  path: 'datos',
                  name: 'buyer_data',
                  builder: (context, state) {
                    final matchId = state.pathParameters['id']!;
                    return BuyerDataScreen(matchId: matchId);
                  },
                ),
                GoRoute(
                  path: 'pago',
                  name: 'payment',
                  builder: (context, state) {
                    final matchId = state.pathParameters['id']!;
                    final buyer = state.extra as BuyerEntity; // Recibimos los datos del comprador

                    return PaymentScreen(matchId: matchId, buyer: buyer);
                  },
                ),
              ],
            ),
          ],
        ),
        GoRoute(
          path: '/tienda',
          name: 'shop',
          builder: (context, state) => const ShopScreen(),
        ),
        GoRoute(
          path: '/entradas',
          name: 'tickets',
          builder: (context, state) => const TicketsScreen(),
        ),
        GoRoute(
          path: '/info',
          name: 'info',
          builder: (context, state) => const InfoScreen(),
        ),
      ],
    ),
  ],
);

/// Widget que contiene la BottomNavigationBar
class ScaffoldWithNavBar extends StatelessWidget {
  final Widget child;

  const ScaffoldWithNavBar({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    // GoRouter nos dice en qué ruta estamos para resaltar el ícono correcto
    final currentPath = GoRouterState.of(context).uri.path;

    return Scaffold(
      body: child,
      bottomNavigationBar: NavigationBar(
        selectedIndex: _calculateSelectedIndex(currentPath),
        onDestinationSelected: (int index) {
          // Navegamos a la ruta correspondiente
          final routes = ['/', '/partidos', '/tienda', '/entradas', '/info'];
          context.go(routes[index]);
        },
        destinations: const [
          NavigationDestination(icon: Icon(Icons.home_outlined), selectedIcon: Icon(Icons.home, color: Color.fromARGB(255, 255, 255, 0)), label: 'Inicio'),
          NavigationDestination(icon: Icon(Icons.sports_soccer_outlined), selectedIcon: Icon(Icons.sports_soccer, color: Color.fromARGB(255, 252, 255, 0)), label: 'Partidos'),
          NavigationDestination(icon: Icon(Icons.shopping_cart_outlined), selectedIcon: Icon(Icons.shopping_cart, color: Color.fromARGB(255, 255, 255, 0)), label: 'Tienda'),
          NavigationDestination(icon: Icon(Icons.confirmation_number_outlined), selectedIcon: Icon(Icons.confirmation_number, color: Color.fromARGB(255, 255, 255, 0)), label: 'Entradas'),
          NavigationDestination(icon: Icon(Icons.info_outline), selectedIcon: Icon(Icons.info, color: Color.fromARGB(255, 255, 255, 0)), label: 'Info'),
        ],
      ),
    );
  }

  int _calculateSelectedIndex(String path) {
    if (path.startsWith('/partidos')) return 1;
    if (path.startsWith('/tienda')) return 2;
    if (path.startsWith('/entradas')) return 3;
    if (path.startsWith('/info')) return 4;
    return 0; // Default a Inicio
  }
}