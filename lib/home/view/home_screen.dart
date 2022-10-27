import '../../routing/routes.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sample Items'),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              //context.go('/settings');
              //context.go('/favorites');
            },
          ),
        ],
      ),
      body: Center(
        child: InkWell(
          onTap: () {
            //context.go('/favorites');
            context.goNamed(RouteNames.favoritesRouteName);
          },
          child: const Text('My favorite Coffees'),
        ),
      ),
    );
  }
}
