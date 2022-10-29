import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../favorite/favorite.dart';
import '../home.dart';

class AddToFavoritesFloatingButton extends StatelessWidget {
  const AddToFavoritesFloatingButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final coffee = context.select((HomeCubit cubit) => cubit.state.coffee);

//TODO: Mejorar logica y extrar snackBar
    return BlocConsumer<FavoriteBloc, FavoriteState>(
      /// By checking shouldShowAlert here,
      /// we prevent the stack of snackBars from accumulating.
      listenWhen: (previous, current) =>
          previous.shouldShowAlert != current.shouldShowAlert,
      listener: (context, state) {
        if (state.shouldShowAlert) {
          String snackText;

          if (state.hasError) {
            snackText = 'Something wrong happened';
          } else {
            snackText = 'Coffee added to favorites!';
            if (state.alreadyAdded) {
              snackText = 'Coffee already added';
            }
          }

          final snackColor = state.hasError ? Colors.red : Colors.amber;

          final snackBar = SnackBar(
            content: Text(snackText),
            backgroundColor: snackColor,
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar).closed.then(
                (_) => {
                  context
                      .read<FavoriteBloc>()
                      .add(const FavoriteResetAlertEvent())
                },
              );
        }
      },

      builder: (context, state) {
        final alreadyAdded = state.isCoffeeAlreadyAdded(coffee);

        final enabled = coffee != null;
        return _LoadingIndicator(
          isLoading: state.isLoading,
          child: FloatingActionButton(
            backgroundColor: alreadyAdded ? Colors.pink : Colors.grey,
            onPressed: enabled
                ? () {
                    context
                        .read<FavoriteBloc>()
                        .add(FavoriteAddEvent(coffee: coffee));
                  }
                : null,
            child: state.isLoading ? null : const Icon(Icons.favorite),
          ),
        );
      },
    );
  }
}

//TODO: Extraer widget
class _LoadingIndicator extends StatelessWidget {
  final Widget child;
  final bool isLoading;
  const _LoadingIndicator({
    Key? key,
    required this.child,
    required this.isLoading,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: AlignmentDirectional.center,
      children: [
        child,
        if (isLoading) const CircularProgressIndicator.adaptive(),
      ],
    );
  }
}
