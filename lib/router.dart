import 'package:flutter_application_pizza/my_app.dart';
import 'package:flutter_application_pizza/pizza/presentation/pages/lista_pizzas_page.dart';
import 'package:go_router/go_router.dart';

final router = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const MyHomePage(
        title: "Home",
      ),
    ),
    GoRoute(
      path: '/pizza',
      builder: (context, state) => const ListaPizzasPage(),
    ),
  ],
);
