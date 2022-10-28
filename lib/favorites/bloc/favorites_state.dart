import 'package:coffee_models/coffee_models.dart';
import 'package:equatable/equatable.dart';

enum FavoritesLoadState {
  loading,
  succeded,
  failed,
}

class FavoritesState extends Equatable {
  final List<Coffee> favoriteCoffees;
  final FavoritesLoadState loadState;

  const FavoritesState({
    required this.favoriteCoffees,
    required this.loadState,
  });

  bool get isLoading => loadState == FavoritesLoadState.loading;
  bool get hasError => loadState == FavoritesLoadState.failed;
  bool get favoriteCoffeesLoaded => loadState == FavoritesLoadState.succeded;
  bool get emptyFavoriteCoffees => favoriteCoffees.isEmpty;

  factory FavoritesState.initial() => const FavoritesState(
        favoriteCoffees: [],
        loadState: FavoritesLoadState.loading,
      );

  FavoritesState copyWith({
    List<Coffee>? favoriteCoffees,
    FavoritesLoadState? loadState,
  }) =>
      FavoritesState(
        favoriteCoffees: favoriteCoffees ?? this.favoriteCoffees,
        loadState: loadState ?? this.loadState,
      );

  @override
  List<Object?> get props => [
        favoriteCoffees,
        loadState,
      ];
}
