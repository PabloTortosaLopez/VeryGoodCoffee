enum CoffeeEndpoint {
  random,
}

class CoffeeURLFactory {
  const CoffeeURLFactory();

  String getUrl({required CoffeeEndpoint endpoint}) {
    return _getAuthRoute() + _getEndpointComponent(endpoint);
  }

  String _getAuthRoute() {
    return 'https://coffee.alexflipnote.dev';
  }

  String _getEndpointComponent(CoffeeEndpoint endpoint) {
    switch (endpoint) {
      case CoffeeEndpoint.random:
        return '/random.json';
    }
  }
}
