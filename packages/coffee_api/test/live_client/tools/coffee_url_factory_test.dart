import 'package:coffee_api/coffee_api.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const mockBaseUrl = 'https://coffee.alexflipnote.dev';

  group('CoffeeURLFactory', () {
    CoffeeURLFactory subject = const CoffeeURLFactory();
    test('generates expected random coffee URL', () {
      const expectedUrl = '$mockBaseUrl/random.json';

      expect(
        subject.getUrl(endpoint: CoffeeEndpoint.random),
        equals(expectedUrl),
      );
    });
  });
}
