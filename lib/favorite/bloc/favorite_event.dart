part of 'favorite_bloc.dart';

abstract class FavoriteEvent extends Equatable {
  const FavoriteEvent();

  @override
  List<Object> get props => [];
}

class FavoriteLoadEvent extends FavoriteEvent {
  const FavoriteLoadEvent();
}

class FavoriteRemoveEvent extends FavoriteEvent {
  const FavoriteRemoveEvent({required this.coffee});

  final Coffee coffee;

  @override
  List<Object> get props => [coffee];
}
