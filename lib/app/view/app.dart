import 'package:coffee_api/coffee_api.dart';
import 'package:coffee_repositories/coffee_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../favorite/favorite.dart';
import '../../home/home.dart';
import '../../routing/routes.dart';
import '../app.dart';

class MyApp extends StatelessWidget {
  const MyApp({
    super.key,
    required this.settingsController,
  });

  final SettingsController settingsController;

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<CoffeeRouter>(
          lazy: false, // Necessary to allow immediate access
          create: (_) => CoffeeRouter(),
        ),
        Provider<CoffeeClient>(
          create: (_) => CoffeeClient(),
        ),
        Provider<LocalCoffeeClient>(
          create: (_) => LocalCoffeeClient(),
        ),
      ],
      child: _RepositoryInitializer(
        child: _BlocInitializer(
          child: AnimatedBuilder(
            animation: settingsController,
            builder: (BuildContext context, Widget? child) {
              final router =
                  Provider.of<CoffeeRouter>(context, listen: false).router;
              return MaterialApp.router(
                restorationScopeId: 'very_good_coffee_app',
                localizationsDelegates: const [
                  AppLocalizations.delegate,
                  GlobalMaterialLocalizations.delegate,
                  GlobalWidgetsLocalizations.delegate,
                  GlobalCupertinoLocalizations.delegate,
                ],
                supportedLocales: const [
                  Locale.fromSubtags(languageCode: 'en'),
                  Locale.fromSubtags(languageCode: 'es'),
                ],
                onGenerateTitle: (BuildContext context) =>
                    AppLocalizations.of(context)!.appTitle,
                theme: ThemeData(),
                darkTheme: ThemeData.dark(),
                themeMode: settingsController.themeMode,
                routerConfig: router,
              );
            },
          ),
        ),
      ),
    );
  }
}

class _RepositoryInitializer extends StatelessWidget {
  final Widget child;
  const _RepositoryInitializer({
    required this.child,
  }) : super();

  @override
  Widget build(BuildContext context) {
    final liveClient = Provider.of<CoffeeClient>(context, listen: false);
    final localClient = Provider.of<LocalCoffeeClient>(context, listen: false);

    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(
          create: (_) => CoffeeRepository(
            coffeeClient: liveClient,
            localCoffeeClient: localClient,
          ),
        ),
      ],
      child: child,
    );
  }
}

class _BlocInitializer extends StatelessWidget {
  final Widget child;
  const _BlocInitializer({
    required this.child,
  }) : super();

  @override
  Widget build(BuildContext context) {
    final coffeeRepository = RepositoryProvider.of<CoffeeRepository>(context);
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => HomeCubit(
            coffeeRepository: coffeeRepository,
          ),
        ),
        BlocProvider(
          create: (_) => FavoriteBloc(
            coffeeRepository: coffeeRepository,
          ),
        ),
        BlocProvider(
          lazy: false, // Necessary to eagerly load a coffee image
          create: (_) => AddFavoriteCubit(
            coffeeRepository: coffeeRepository,
          ),
        )
      ],
      child: child,
    );
  }
}
