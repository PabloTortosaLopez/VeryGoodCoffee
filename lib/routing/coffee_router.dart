import 'package:flutter/material.dart';

import '../favorite/favorite.dart';
import '../home/home.dart';
import 'routes.dart';

class CoffeeRouter {
  late final router = GoRouter(
    routes: [
      GoRoute(
        name: RouteNames.rootRouteName,
        path: '/',
        builder: (context, state) => const HomeScreen(),
        pageBuilder: (context, state) => MaterialPage(
          key: state.pageKey,
          child: const HomeScreen(),
        ),
        routes: <GoRoute>[
          GoRoute(
            name: RouteNames.favoritesRouteName,
            path: 'favorites',
            pageBuilder: (context, state) => MaterialPage(
              key: state.pageKey,
              child: const FavoriteCoffeesScreen(),
            ),
          ),
        ],
      ),
    ],
  );
}
