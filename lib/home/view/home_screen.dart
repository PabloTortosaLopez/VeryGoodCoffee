import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:transparent_image/transparent_image.dart';

import '../../routing/routes.dart';
import '../home.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          CoffeeActionButton(
            buttonType: CoffeeButtonType.goTofavorites,
            onPressed: () => context.goNamed(RouteNames.favoritesRouteName),
          ),
          CoffeeActionButton(
            buttonType: CoffeeButtonType.reloadCoffee,
            onPressed: () => context.read<HomeCubit>().reloadRandomCoffee(),
          ),
        ],
      ),
      body: const _CoffeeImageView(),
      floatingActionButton: const AddToFavoritesButton(),
    );
  }
}

class _CoffeeImageView extends StatelessWidget {
  const _CoffeeImageView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                  placeholder: kTransparentImage,
                  image: url,
                ),
              ),
            );

          case HomeLoadState.failed:
            return const Center(
              child: Text(
                  'Failed to load data, try again or see your favorite coffees'),
            );
        }
      },
    );
  }
}
