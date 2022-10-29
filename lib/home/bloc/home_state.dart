part of 'home_cubit.dart';

enum HomeLoadState {
  loading,
  succeded,
  failed,
}

class HomeState extends Equatable {
  final Coffee? coffee;
  final HomeLoadState loadState;

  const HomeState({
    required this.coffee,
    required this.loadState,
  });

  bool get isLoading => loadState == HomeLoadState.loading;
  bool get hasError => loadState == HomeLoadState.failed;
  bool get coffeeLoaded => loadState == HomeLoadState.succeded;

  factory HomeState.initial() => const HomeState(
        coffee: null,
        loadState: HomeLoadState.loading,
      );

  HomeState copyWith({
    Coffee? Function()? coffee,
    HomeLoadState? loadState,
  }) =>
      HomeState(
        coffee: coffee != null ? coffee() : this.coffee,
        loadState: loadState ?? this.loadState,
      );

  @override
  List<Object?> get props => [
        coffee,
        loadState,
      ];
}
