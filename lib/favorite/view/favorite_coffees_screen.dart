import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:transparent_image/transparent_image.dart';

import '../favorite.dart';

class FavoriteCoffeesScreen extends StatelessWidget {
  const FavoriteCoffeesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Favorites'),
      ),
      body: BlocBuilder<FavoriteBloc, FavoriteState>(
        builder: (context, state) {
          //TODO: AJUSTAR COMO LA OTRA PANTALLA, dar opcion de recargar lista y borrar lista?
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
