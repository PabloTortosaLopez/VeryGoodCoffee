import 'dart:developer';

import 'package:coffee_api/coffee_api.dart';
import 'package:coffee_models/coffee_models.dart';
import 'package:coffee_repositories/coffee_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
part 'add_favorite_state.dart';

class AddFavoriteCubit extends Cubit<AddFavoriteState> {
  final CoffeeRepository _coffeeRepository;

  AddFavoriteCubit({
    required CoffeeRepository coffeeRepository,
  })  : _coffeeRepository = coffeeRepository,
        super(AddFavoriteState.initial());

  void addCoffeeToFavorites(Coffee coffee) async {
    emit(
      state.copyWith(
        addFavoriteStatus: AddFavoriteStatus.adding,
      ),
    );

    try {
      await _coffeeRepository.addCoffeeToFavorites(coffee);

      emit(
        state.copyWith(
          addFavoriteStatus: AddFavoriteStatus.succeded,
        ),
      );
    } on AlreadyAddedException {
      emit(
        state.copyWith(
          addFavoriteStatus: AddFavoriteStatus.alreadyAdded,
        ),
      );
    } catch (exception) {
      log(exception.toString());
      emit(
        state.copyWith(
          addFavoriteStatus: AddFavoriteStatus.failed,
        ),
      );
    }
  }

  void resetStatus() {
    emit(
      state.copyWith(
        addFavoriteStatus: AddFavoriteStatus.idle,
      ),
    );
  }
}
