import 'dart:async';

import 'package:coffee_repositories/coffee_repository.dart';
import 'package:coffee_models/coffee_models.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'favorite_state.dart';
part 'favorite_event.dart';

///This is intentionally a BLoC to handle future functionalities,
/// e.g. delete an image, delete them all, save them in the device's gallery etc..
class FavoriteBloc extends Bloc<FavoriteEvent, FavoriteState> {
  final CoffeeRepository _coffeeRepository;

  FavoriteBloc({
    required CoffeeRepository coffeeRepository,
  })  : _coffeeRepository = coffeeRepository,
        super(
          FavoriteState.initial(),
        ) {
    on<FavoriteLoadEvent>((event, emit) async {
      await _onFavoriteLoadEvent(event, emit);
    });

    add(const FavoriteLoadEvent());
  }

  Future<void> _onFavoriteLoadEvent(
    FavoriteLoadEvent event,
    Emitter<FavoriteState> emit,
  ) async {
    await _loadFavoriteCoffees(emit);
  }

  Future<void> _loadFavoriteCoffees(
    Emitter<FavoriteState> emit,
  ) async {
    emit(
      state.copyWith(
        loadState: FavoriteLoadState.loading,
      ),
    );

    try {
      final favoriteCoffees = await _coffeeRepository.loadFavoriteCoffees();
      emit(
        state.copyWith(
          loadState: FavoriteLoadState.succeded,
          favoriteCoffees: favoriteCoffees,
        ),
      );
    } on Exception catch (_) {
      emit(
        state.copyWith(
          loadState: FavoriteLoadState.failed,
        ),
      );
    }
  }
}
