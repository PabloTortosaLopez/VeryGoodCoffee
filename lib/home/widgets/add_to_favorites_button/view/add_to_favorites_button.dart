import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:very_good_coffee/app/app.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../../../favorite/favorite.dart';
import '../../../home.dart';

class AddToFavoritesButton extends StatelessWidget {
  const AddToFavoritesButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;
    final coffee = context.select((HomeCubit cubit) => cubit.state.coffee);

    return BlocConsumer<AddFavoriteCubit, AddFavoriteState>(
      listenWhen: (previous, current) =>
          previous.showAlert != current.showAlert,
      listener: (context, state) {
        if (state.showAlert) {
          String snackTitle;
          Color snackColor;

          switch (state.addFavoriteStatus) {
            case AddFavoriteStatus.alreadyAdded:
              snackTitle = localizations.coffeeAlreadyAdded;
              snackColor = Colors.amber;
              break;
            case AddFavoriteStatus.succeded:
              snackTitle = localizations.coffeeAddedToFavorites;
              snackColor = Colors.green;
              break;
            default:
              snackTitle = localizations.somethinWrongHappened;
              snackColor = Colors.red;
              break;
          }

          /// Reloads favorite coffees
          if (state.hasSucceded) {
            context.read<FavoriteBloc>().add(const FavoriteLoadEvent());
          }

          showCoffeeSnakcBar(
            context: context,
            backgroundColor: snackColor,
            title: snackTitle,
            onFinished: () {
              context.read<AddFavoriteCubit>().resetStatus();
            },
          );
        }
      },
      builder: (context, state) {
        final enabled = coffee != null && state.enableButton;
        return LoadingIndicator(
          isLoading: state.isLoading,
          child: FloatingActionButton(
            backgroundColor: enabled ? Colors.pink : Colors.grey,
            onPressed: enabled
                ? () {
                    context
                        .read<AddFavoriteCubit>()
                        .addCoffeeToFavorites(coffee);
                  }
                : null,
            child: state.isLoading ? null : const Icon(Icons.favorite),
          ),
        );
      },
    );
  }
}

class LoadingIndicator extends StatelessWidget {
  final Widget child;
  final bool isLoading;
  const LoadingIndicator({
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
