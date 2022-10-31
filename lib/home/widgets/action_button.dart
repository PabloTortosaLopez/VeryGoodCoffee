import 'package:flutter/material.dart';

enum CoffeeButtonType { goTofavorites, reloadCoffee }

/// A simple widget with text and a tappable icon
class CoffeeActionButton extends StatefulWidget {
  final CoffeeButtonType buttonType;
  final VoidCallback onPressed;

  const CoffeeActionButton({
    Key? key,
    required this.buttonType,
    required this.onPressed,
  }) : super(key: key);

  @override
  State<CoffeeActionButton> createState() => _CoffeeActionButtonState();
}

class _CoffeeActionButtonState extends State<CoffeeActionButton> {
  String _title = '';

  IconData _buttonIcon = Icons.circle;

  @override
  void initState() {
    super.initState();
    setUpButtonComponents();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Center(
          child: Text(
            _title,
          ),
        ),
        IconButton(
          icon: Icon(_buttonIcon),
          onPressed: widget.onPressed,
        ),
      ],
    );
  }

  void setUpButtonComponents() {
    switch (widget.buttonType) {
      case CoffeeButtonType.goTofavorites:
        _title = 'Favorites';
        _buttonIcon = Icons.favorite;
        return;
      case CoffeeButtonType.reloadCoffee:
        _title = 'Coffee';
        _buttonIcon = Icons.coffee;
        return;
    }
  }
}
