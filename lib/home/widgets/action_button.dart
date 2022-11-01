import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

enum CoffeeButtonType { goTofavorites, reloadCoffee }

// ignore: must_be_immutable
class CoffeeActionButton extends StatelessWidget {
  final CoffeeButtonType buttonType;
  final VoidCallback onPressed;

  CoffeeActionButton({
    Key? key,
    required this.buttonType,
    required this.onPressed,
  }) : super(key: key);

  String _title = '';

  IconData _buttonIcon = Icons.circle;

  @override
  Widget build(BuildContext context) {
    setUpButtonComponents(context);
    return Row(
      children: [
        Center(
          child: Text(
            _title,
          ),
        ),
        IconButton(
          icon: Icon(_buttonIcon),
          onPressed: onPressed,
        ),
      ],
    );
  }

  void setUpButtonComponents(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;
    switch (buttonType) {
      case CoffeeButtonType.goTofavorites:
        _title = localizations.favorites;
        _buttonIcon = Icons.favorite;
        return;
      case CoffeeButtonType.reloadCoffee:
        _title = localizations.coffee;
        _buttonIcon = Icons.coffee;
        return;
    }
  }
}
