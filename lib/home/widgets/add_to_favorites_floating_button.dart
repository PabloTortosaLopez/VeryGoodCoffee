import 'package:coffee_models/coffee_models.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:very_good_coffee/favorites/bloc/favorites_bloc.dart';
import 'package:very_good_coffee/favorites/bloc/favorites_event.dart';

import '../bloc/home_cubit.dart';

class AddToFavoritesFloatingButton extends StatelessWidget {
  const AddToFavoritesFloatingButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final enabled =
        context.select((HomeCubit cubit) => cubit.state.coffeeLoaded);

    final coffee = context.select((HomeCubit cubit) => cubit.state.coffee);

    return FloatingActionButton(
      backgroundColor: enabled ? Colors.pink : Colors.grey,
      onPressed: enabled
          ? () {
              context
                  .read<FavoritesBloc>()
                  .add(FavoritesAddEvent(coffee: coffee!));

              // context.read<FavoritesBloc>().add(const FavoritesAddEvent(
              //     coffee: Coffee(
              //         imageUrl:
              //             'https://coffee.alexflipnote.dev/J_q19leiBp8_coffee.jpg')));
            }
          : null,
      child: const Icon(Icons.favorite),
    );
  }
}
