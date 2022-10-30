import 'package:coffee_repositories/coffee_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:coffee_models/coffee_models.dart';
import 'package:equatable/equatable.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final CoffeeRepository _coffeeRepository;

  HomeCubit({
    required CoffeeRepository coffeeRepository,
  })  : _coffeeRepository = coffeeRepository,
        super(HomeState.initial()) {
    _loadCoffee();
  }

  void _loadCoffee() async {
    if (!state.isLoading) {
      emit(
        state.copyWith(
          /// We want to delete the current Coffee instance, if any
          coffee: () => null,
          loadState: HomeLoadState.loading,
        ),
      );
    }
    try {
      final coffee = await _coffeeRepository.loadRandomCoffee();

      emit(
        state.copyWith(
          coffee: () => coffee,
          loadState: HomeLoadState.succeded,
        ),
      );
    } on Exception catch (_) {
      emit(
        state.copyWith(
          loadState: HomeLoadState.failed,
        ),
      );
    }
  }

  void reloadRandomCoffee() {
    if (state.isLoading) {
      /// Nothing to do
      return;
    } else {
      _loadCoffee();
    }
  }
}
