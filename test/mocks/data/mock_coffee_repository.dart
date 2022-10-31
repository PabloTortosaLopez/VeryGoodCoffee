import 'package:coffee_models/coffee_models.dart';
import 'package:coffee_repositories/coffee_repository.dart';
import 'package:mocktail/mocktail.dart';

class MockedCoffee extends Mock implements Coffee {}

class MockCoffeeRepository with Mock implements CoffeeRepository {
  Coffee mockedCoffee = MockedCoffee();
  Exception? mockedException;
  List<Coffee> mockedFavoriteCoffees = [
    MockedCoffee(),
    MockedCoffee(),
    MockedCoffee()
  ];

  @override
  Future<Coffee> loadRandomCoffee() async {
    if (mockedException != null) {
      throw mockedException!;
    }

    return mockedCoffee;
  }

  @override
  Future<List<Coffee>> loadFavoriteCoffees() async {
    if (mockedException != null) {
      throw mockedException!;
    }
    return mockedFavoriteCoffees;
  }

  @override
  Future<void> addCoffeeToFavorites(Coffee coffee) async {
    if (mockedException != null) {
      throw mockedException!;
    }
  }
}
