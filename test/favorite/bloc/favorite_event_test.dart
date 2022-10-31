import 'package:flutter_test/flutter_test.dart';
import 'package:very_good_coffee/favorite/favorite.dart';

void main() {
  group('FavoriteEvent', () {
    group('FavoriteLoad', () {
      test('support value equality', () {
        const instanceA = FavoriteLoadEvent();
        const instanceB = FavoriteLoadEvent();
        expect(instanceA, instanceB);
      });
    });
  });
}
