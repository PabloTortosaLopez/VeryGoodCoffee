import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:transparent_image/transparent_image.dart';
import '../../routing/routes.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../home.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          CoffeeActionButton(
            key: const Key('home_go_to_favorites_coffee_action_button'),
            buttonType: CoffeeButtonType.goTofavorites,
            onPressed: () => context.goNamed(RouteNames.favoritesRouteName),
          ),
          CoffeeActionButton(
            key: const Key('home_reload_coffee_coffee_action_button'),
            buttonType: CoffeeButtonType.reloadCoffee,
            onPressed: () => context.read<HomeCubit>().reloadRandomCoffee(),
          ),
        ],
      ),
      body: const CoffeeImageView(),
      floatingActionButton: const AddToFavoritesButton(),
    );
  }
}

class CoffeeImageView extends StatelessWidget {
  const CoffeeImageView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        switch (state.loadState) {
          case HomeLoadState.loading:
            return const Center(
              child: CircularProgressIndicator.adaptive(),
            );
          case HomeLoadState.succeded:
            final coffeeImage = state.coffee!.image;

            return coffeeImage.when(
              imagePath: (_) {
                assert(false, 'This case should never occur here');
                return const SizedBox.shrink();
              },
              imageUrl: (url) => Center(
                child: FadeInImage.memoryNetwork(
                  fadeInDuration: const Duration(milliseconds: 300),
                  placeholder: kTransparentImage,
                  image: url,
                ),
              ),
            );

          case HomeLoadState.failed:
            return Center(
              child: Text(localizations.failedToLoadRandomCoffee),
            );
        }
      },
    );
  }
}
