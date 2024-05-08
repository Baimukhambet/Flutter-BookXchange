import 'package:cubit_test/my_bottom_bar.dart';
import 'package:cubit_test/features/auth/auth_gate.dart';
import 'package:cubit_test/features/home/home_screen.dart';
import 'package:cubit_test/features/order/order_screen.dart';
import 'package:go_router/go_router.dart';

final router = GoRouter(initialLocation: '/auth', routes: [
  GoRoute(
    path: '/main',
    builder: (context, state) => MyBottomBar(),
  ),
  GoRoute(
    path: '/auth',
    builder: (context, state) => AuthGate(),
  ),
  GoRoute(
    path: '/order',
    builder: (context, state) => OrderScreen(),
  )
]);
