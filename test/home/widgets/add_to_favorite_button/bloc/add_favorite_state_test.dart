import 'package:flutter_test/flutter_test.dart';
import 'package:very_good_coffee/home/home.dart';

void main() {
  group('AddFavoriteState', () {
    test('supporst value equality', () {
      expect(AddFavoriteState.initial(), equals(AddFavoriteState.initial()));
    });

    group('copyWith', () {
      test('updates values', () {
        expect(
            AddFavoriteState.initial()
                .copyWith(
                  addFavoriteStatus: AddFavoriteStatus.adding,
                )
                .addFavoriteStatus,
            equals(AddFavoriteStatus.adding));
      });
    });
  });
}
