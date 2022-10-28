import 'dart:async';

import 'package:coffee_repositories/coffee_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:very_good_coffee/favorites/bloc/favorites_event.dart';
import 'package:very_good_coffee/favorites/bloc/favorites_state.dart';

class FavoritesBloc extends Bloc<FavoritesEvent, FavoritesState> {
  final CoffeeRepository _coffeeRepository;

  FavoritesBloc({
    required CoffeeRepository coffeeRepository,
  })  : _coffeeRepository = coffeeRepository,
        super(
          FavoritesState.initial(),
        ) {
    // on<FavoritesEvent>(_onFavoritesEvent);
    on<FavoritesLoadEvent>((event, emit) async {
      await _onFavoritesLoadEvent(event, emit);
    });

    on<FavoritesAddEvent>((event, emit) async {
      await _onFavoritesAddEvent(event, emit);
    });
  }

  // FutureOr<void> _onFavoritesEvent(
  //   FavoritesEvent event,
  //   Emitter<FavoritesState> emit,
  // ) async {
  //   if (event is FavoritesLoadEvent) {}
  // }

  Future<void> _onFavoritesLoadEvent(
    FavoritesLoadEvent event,
    Emitter<FavoritesState> emit,
  ) async {
    await _loadFavoriteCoffees(emit);
  }

  Future<void> _onFavoritesAddEvent(
    FavoritesAddEvent event,
    Emitter<FavoritesState> emit,
  ) async {
    final coffeeToAdd = event.coffee;

    if (state.favoriteCoffees.contains(coffeeToAdd)) {
      /// Nothing to do
    } else {
      emit(
        state.copyWith(
          loadState: FavoritesLoadState.loading,
        ),
      );

      try {
        final updatedFavoriteCoffees =
            await _coffeeRepository.addCoffeeToFavorites(coffeeToAdd);
        emit(
          state.copyWith(
            loadState: FavoritesLoadState.succeded,
            favoriteCoffees: updatedFavoriteCoffees,
          ),
        );
      } on Exception catch (e) {
        emit(
          state.copyWith(
            /// We dont want to crash the favorite coffees if add to favorites request fails
            loadState: FavoritesLoadState.succeded,
          ),
        );
      }
    }
  }

  Future<void> _loadFavoriteCoffees(
    Emitter<FavoritesState> emit,
  ) async {
    emit(
      state.copyWith(
        loadState: FavoritesLoadState.loading,
      ),
    );

    try {
      final favoriteCoffees = await _coffeeRepository.loadFavoriteCoffees();
      emit(
        state.copyWith(
          loadState: FavoritesLoadState.succeded,
          favoriteCoffees: favoriteCoffees,
        ),
      );
    } on Exception catch (e) {
      emit(
        state.copyWith(
          loadState: FavoritesLoadState.failed,
        ),
      );
    }
  }
}
