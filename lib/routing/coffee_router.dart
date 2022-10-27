import '../favorites/favorites.dart';
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
              child: const SampleItemListView(),
            ),
            // routes: <GoRoute>[
            //   GoRoute(
            //     name: 'detail',
            //     path: 'detail/:cid',
            //     builder: (context, state) =>
            //         const SampleItemDetailsView(state.params['cid']),
            //   ),
            // ],
          ),
          // GoRoute(
          //   path: 'settings',
          //   builder: (context, state) =>
          //       //SettingsView(controller: settingsController),
          //       SettingsView(controller: state.extra as SettingsController),
          // ),
        ],
        // TODO: Add Error Handler

        // TODO Add Redirect
      ),
    ],
    // errorPageBuilder: (context, state) => MaterialPage<void>(
    //   key: state.pageKey,
    //   child: ErrorScreen(error: state.error),
    // ),
  );
}
