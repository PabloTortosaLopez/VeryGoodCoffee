import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:very_good_coffee/favorites/bloc/favorites_bloc.dart';
import 'package:very_good_coffee/favorites/bloc/favorites_state.dart';

/// Displays a list of SampleItems.
class FavoriteCoffeesScreen extends StatelessWidget {
  const FavoriteCoffeesScreen({super.key});

  static const routeName = '/';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sample Items'),
      ),
      body: BlocBuilder<FavoritesBloc, FavoritesState>(
        builder: (context, state) {
          if (state.isLoading) {
            return const Center(
              child: Text('Loading'),
            );
          }
          if (state.hasError) {
            return const Center(
              child: Text('Failed'),
            );
          }

          if (state.favoriteCoffeesLoaded) {
            if (state.emptyFavoriteCoffees) {
              return const Center(
                child: Text('No favorite Coffees yet'),
              );
            } else {
              return ListView.builder(
                shrinkWrap: true,
                restorationId: 'sampleItemListView',
                itemCount: state.favoriteCoffees.length,
                itemBuilder: (BuildContext _, int index) {
                  final item = state.favoriteCoffees[index];

                  return FadeInImage.memoryNetwork(
                    placeholder: kTransparentImage,
                    image: item.imageUrl,
                    // width: 200,
                    // height: 200,
                  );
                },
              );
            }
          }
          return Container();
        },
      ),
    );
  }
}
