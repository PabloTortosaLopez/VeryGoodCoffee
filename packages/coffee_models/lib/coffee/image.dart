import 'package:equatable/equatable.dart';

abstract class Image extends Equatable {
  String get raw;

  const Image();

  factory Image.url({
    required String url,
  }) =>
      _UrlImage(url);

  factory Image.path({
    required String path,
  }) =>
      _PathImage(path);

  R when<R>({
    required R Function(String url) urlImage,
    required R Function(String path) pathImage,
  }) {
    final value = this;
    if (value is _UrlImage) {
      return urlImage(value.url);
    } else if (value is _PathImage) {
      return pathImage(value.path);
    } else {
      throw StateError('Unhandled type: $value');
    }
  }
}

class _UrlImage extends Image {
  final String url;

  @override
  String get raw => url;

  const _UrlImage(this.url);
  @override
  List<Object?> get props => [url];
}

class _PathImage extends Image {
  final String path;

  @override
  String get raw => path;

  const _PathImage(this.path);

  @override
  List<Object?> get props => [path];
}
