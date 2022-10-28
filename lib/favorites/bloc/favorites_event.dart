import 'package:coffee_models/coffee_models.dart';
import 'package:equatable/equatable.dart';

abstract class FavoritesEvent extends Equatable {
  const FavoritesEvent();

  @override
  List<Object> get props => [];
}

class FavoritesLoadEvent extends FavoritesEvent {}

class FavoritesSuccededEvent extends FavoritesEvent {
  const FavoritesSuccededEvent({required this.favoriteCoffess});

  final List<Coffee> favoriteCoffess;

  @override
  List<Object> get props => [favoriteCoffess];
}

//class FavoritesFailedEvent extends FavoritesEvent {}

class FavoritesRemoveEvent extends FavoritesEvent {
  const FavoritesRemoveEvent({required this.coffee});

  final Coffee coffee;

  @override
  List<Object> get props => [coffee];
}

class FavoritesAddEvent extends FavoritesEvent {
  const FavoritesAddEvent({required this.coffee});

  final Coffee coffee;

  @override
  List<Object> get props => [coffee];
}
