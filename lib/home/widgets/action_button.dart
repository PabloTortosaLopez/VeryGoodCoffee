import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

enum CoffeeButtonType { goTofavorites, reloadCoffee }

class CoffeeActionButton extends StatelessWidget {
  final CoffeeButtonType buttonType;
  final VoidCallback onPressed;

  const CoffeeActionButton({
    Key? key,
    required this.buttonType,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;
    return Row(
      children: [
        Center(
          child: Text(
            _setUpTitle(localizations),
          ),
        ),
        IconButton(
          icon: Icon(_setUpIcon()),
          onPressed: onPressed,
        ),
      ],
    );
  }

  IconData _setUpIcon() {
    switch (buttonType) {
      case CoffeeButtonType.goTofavorites:
        return Icons.favorite;
      case CoffeeButtonType.reloadCoffee:
        return Icons.coffee;
    }
  }

  String _setUpTitle(AppLocalizations localizations) {
    switch (buttonType) {
      case CoffeeButtonType.goTofavorites:
        return localizations.favorites;
      case CoffeeButtonType.reloadCoffee:
        return localizations.coffee;
    }
  }
}
