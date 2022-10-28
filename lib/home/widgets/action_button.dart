import 'package:auto_size_text/auto_size_text.dart';

import '../../routing/routes.dart';

enum CoffeeButtonType { goTofavorites, reloadCoffee }

class CoffeeActionButton extends StatefulWidget {
  final CoffeeButtonType buttonType;
  final VoidCallback onPressed;

  const CoffeeActionButton(
      {Key? key, required this.buttonType, required this.onPressed})
      : super(key: key);

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
          child: AutoSizeText(
            _title,
            maxFontSize: 24,
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
