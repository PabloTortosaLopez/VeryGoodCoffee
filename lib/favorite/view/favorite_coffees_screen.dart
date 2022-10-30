import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../favorite.dart';

class FavoriteCoffeesScreen extends StatelessWidget {
  const FavoriteCoffeesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Favorites'),
      ),
      body: const _FavoriteCoffeesView(),
    );
  }
}

class _FavoriteCoffeesView extends StatelessWidget {
  const _FavoriteCoffeesView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FavoriteBloc, FavoriteState>(
      builder: (context, state) {
        switch (state.loadState) {
          case FavoriteLoadState.loading:
            return const Center(
              child: CircularProgressIndicator.adaptive(),
            );
          case FavoriteLoadState.succeded:
            return _CoffeeList(
              state: state,
            );
          case FavoriteLoadState.failed:
            return InkWell(
              onTap: () =>
                  context.read<FavoriteBloc>().add(const FavoriteLoadEvent()),
              child: const Center(
                child: Text('TRY AGAIN'),
              ),
            );
        }
      },
    );
  }
}

class _CoffeeList extends StatelessWidget {
  final FavoriteState state;

  const _CoffeeList({
    Key? key,
    required this.state,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return state.emptyFavoriteCoffees
        ? const Center(
            child: Text('No favorite Coffees yet'),
          )
        : ListView.builder(
            restorationId: 'favoriteCoffeesList',
            itemCount: state.favoriteCoffees.length,
            itemBuilder: (BuildContext _, int index) {
              final coffeeImage = state.favoriteCoffees[index].image;

              return coffeeImage.when(
                imagePath: (path) => Image.file(
                  File(
                    path, // The path has already been verified to exist by retrieving it.
                  ),
                ),
                imageUrl: (_) {
                  assert(false, 'This case should never occur here');
                  return const SizedBox.shrink();
                },
              );
            },
          );
  }
}
