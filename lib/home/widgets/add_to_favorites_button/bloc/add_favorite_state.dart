part of 'add_favorite_cubit.dart';

enum AddFavoriteStatus {
  idle,
  adding,
  alreadyAdded,
  failed,
  succeded,
}

class AddFavoriteState extends Equatable {
  final AddFavoriteStatus addFavoriteStatus;

  const AddFavoriteState({
    required this.addFavoriteStatus,
  });

  factory AddFavoriteState.initial() =>
      const AddFavoriteState(addFavoriteStatus: AddFavoriteStatus.idle);

  bool get enableButton => addFavoriteStatus == AddFavoriteStatus.idle;
  bool get isLoading => addFavoriteStatus == AddFavoriteStatus.adding;
  bool get hasError => addFavoriteStatus == AddFavoriteStatus.failed;
  bool get hasSucceded => addFavoriteStatus == AddFavoriteStatus.succeded;
  bool get alreadyAdded => addFavoriteStatus == AddFavoriteStatus.alreadyAdded;

  bool get showAlert => alreadyAdded || hasError || hasSucceded;

  AddFavoriteState copyWith({
    AddFavoriteStatus? addFavoriteStatus,
  }) =>
      AddFavoriteState(
        addFavoriteStatus: addFavoriteStatus ?? this.addFavoriteStatus,
      );

  @override
  List<Object?> get props => [
        addFavoriteStatus,
      ];
}
