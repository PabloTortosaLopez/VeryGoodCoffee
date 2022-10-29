part of 'favorite_bloc.dart';

abstract class FavoriteEvent extends Equatable {
  const FavoriteEvent();

  @override
  List<Object> get props => [];
}

class FavoriteLoadEvent extends FavoriteEvent {
  const FavoriteLoadEvent();
}

class FavoriteSuccededEvent extends FavoriteEvent {
  const FavoriteSuccededEvent({required this.favoriteCoffess});

  final List<Coffee> favoriteCoffess;

  @override
  List<Object> get props => [favoriteCoffess];
}

class FavoriteRemoveEvent extends FavoriteEvent {
  const FavoriteRemoveEvent({required this.coffee});

  final Coffee coffee;

  @override
  List<Object> get props => [coffee];
}

class FavoriteAddEvent extends FavoriteEvent {
  const FavoriteAddEvent({required this.coffee});

  final Coffee coffee;

  @override
  List<Object> get props => [coffee];
}

class FavoriteResetAlertEvent extends FavoriteEvent {
  const FavoriteResetAlertEvent();
}
