import 'package:cubit_test/features/post/post_screen.dart';
import 'package:cubit_test/my_bottom_bar.dart';
import 'package:cubit_test/features/auth/auth_gate.dart';
import 'package:cubit_test/features/home/home_screen.dart';
import 'package:cubit_test/features/order_create/order_screen.dart';
import 'package:cubit_test/repositories/models/trade_order.dart';
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
  ),
  GoRoute(
    path: '/post',
    name: '/post',
    builder: (context, state) => PostScreen(
      order: state.extra as TradeOrder,
    ),
  )
]);
