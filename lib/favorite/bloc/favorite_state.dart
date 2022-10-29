part of 'favorite_bloc.dart';

enum FavoriteLoadState {
  loading,
  succeded,
  failed,
}

class FavoriteState extends Equatable {
  final List<Coffee> favoriteCoffees;
  final FavoriteLoadState loadState;
  final bool showAlert;
  final bool alreadyAdded;

  const FavoriteState({
    required this.favoriteCoffees,
    required this.loadState,
    required this.showAlert,
    required this.alreadyAdded,
  });

  bool get isLoading => loadState == FavoriteLoadState.loading;
  bool get hasError => loadState == FavoriteLoadState.failed;
  bool get favoriteCoffeesLoaded => loadState == FavoriteLoadState.succeded;
  bool get emptyFavoriteCoffees => favoriteCoffees.isEmpty;
  bool get shouldShowAlert => showAlert || alreadyAdded;

  bool isCoffeeAlreadyAdded(Coffee? coffee) => favoriteCoffees.contains(coffee);

  factory FavoriteState.initial() => const FavoriteState(
        favoriteCoffees: [],
        loadState: FavoriteLoadState.loading,
        showAlert: false,
        alreadyAdded: false,
      );

  FavoriteState copyWith({
    List<Coffee>? favoriteCoffees,
    FavoriteLoadState? loadState,
    bool? showAlert,
    bool? alreadyAdded,
  }) =>
      FavoriteState(
        favoriteCoffees: favoriteCoffees ?? this.favoriteCoffees,
        loadState: loadState ?? this.loadState,
        showAlert: showAlert ?? this.showAlert,
        alreadyAdded: alreadyAdded ?? this.alreadyAdded,
      );

  @override
  List<Object?> get props => [
        favoriteCoffees,
        loadState,
        showAlert,
        alreadyAdded,
      ];
}
