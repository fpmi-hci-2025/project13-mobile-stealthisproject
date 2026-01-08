import 'package:go_router/go_router.dart';
import '../screens/home_screen.dart';
import '../screens/search_results_screen.dart';
import '../screens/seat_selection_screen.dart';
import '../screens/booking_screen.dart';
import '../screens/dashboard_screen.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const HomeScreen(),
    ),
    GoRoute(
      path: '/search-results',
      builder: (context, state) => const SearchResultsScreen(),
    ),
    GoRoute(
      path: '/seat-selection',
      builder: (context, state) => const SeatSelectionScreen(),
    ),
    GoRoute(
      path: '/booking',
      builder: (context, state) => const BookingScreen(),
    ),
    GoRoute(
      path: '/dashboard',
      builder: (context, state) => const DashboardScreen(),
    ),
  ],
);
