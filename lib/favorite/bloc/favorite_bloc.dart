import 'dart:async';

import 'package:coffee_repositories/coffee_repository.dart';
import 'package:coffee_models/coffee_models.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'favorite_state.dart';
part 'favorite_event.dart';

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

    on<FavoriteAddEvent>((event, emit) async {
      await _onFavoriteAddEvent(event, emit);
    });

    on<FavoriteResetAlertEvent>((event, emit) async {
      await _onFavoriteResetAlertEvent(event, emit);
    });
  }

  Future<void> _onFavoriteResetAlertEvent(
    FavoriteResetAlertEvent event,
    Emitter<FavoriteState> emit,
  ) async {
    emit(
      state.copyWith(
        showAlert: false,
        alreadyAdded: false,
        loadState: FavoriteLoadState.succeded,
      ),
    );
  }

  Future<void> _onFavoriteLoadEvent(
    FavoriteLoadEvent event,
    Emitter<FavoriteState> emit,
  ) async {
    await _loadFavoriteCoffees(emit);
  }

  Future<void> _onFavoriteAddEvent(
    FavoriteAddEvent event,
    Emitter<FavoriteState> emit,
  ) async {
    final coffeeToAdd = event.coffee;

    if (state.isCoffeeAlreadyAdded(coffeeToAdd)) {
      emit(
        state.copyWith(
          alreadyAdded: true,
        ),
      );
    } else {
      emit(
        state.copyWith(
          loadState: FavoriteLoadState.loading,
        ),
      );

      try {
        final updatedFavoriteCoffees =
            await _coffeeRepository.addCoffeeToFavorites(coffeeToAdd);
        emit(
          state.copyWith(
            loadState: FavoriteLoadState.succeded,
            favoriteCoffees: updatedFavoriteCoffees,
            showAlert: true,
          ),
        );
      } on Exception catch (_) {
        emit(
          state.copyWith(
            loadState: FavoriteLoadState.failed,
            showAlert: true,
          ),
        );
      }
    }
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