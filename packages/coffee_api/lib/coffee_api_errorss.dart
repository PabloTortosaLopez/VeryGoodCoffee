library coffee_api;

class AlreadyAddedException implements Exception {}

class HttpException implements Exception {
  final int code;
  final String? body;

  const HttpException({required this.code, this.body});

  @override
  String toString() => 'HTTP error $code: $body';
}
