part of 'favorite_bloc.dart';

enum FavoriteLoadState {
  loading,
  succeded,
  failed,
}

class FavoriteState extends Equatable {
  final List<Coffee> favoriteCoffees;
  final FavoriteLoadState loadState;

  const FavoriteState({
    required this.favoriteCoffees,
    required this.loadState,
  });

  bool get isLoading => loadState == FavoriteLoadState.loading;
  bool get hasError => loadState == FavoriteLoadState.failed;
  bool get favoriteCoffeesLoaded => loadState == FavoriteLoadState.succeded;
  bool get emptyFavoriteCoffees => favoriteCoffees.isEmpty;

  factory FavoriteState.initial() => const FavoriteState(
        favoriteCoffees: [],
        loadState: FavoriteLoadState.loading,
      );

  FavoriteState copyWith({
    List<Coffee>? favoriteCoffees,
    FavoriteLoadState? loadState,
  }) =>
      FavoriteState(
        favoriteCoffees: favoriteCoffees ?? this.favoriteCoffees,
        loadState: loadState ?? this.loadState,
      );

  @override
  List<Object?> get props => [
        favoriteCoffees,
        loadState,
      ];
}
