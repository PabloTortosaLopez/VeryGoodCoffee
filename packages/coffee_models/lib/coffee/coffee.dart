import 'package:equatable/equatable.dart';

import '../coffee_models.dart';

class Coffee extends Equatable {
  final Image image;

  const Coffee({
    required this.image,
  });

  factory Coffee.fromJson(Map<String, dynamic> json) {
    return Coffee(image: Image.url(url: json['file']));
  }

  factory Coffee.fromLocal(String path) {
    return Coffee(image: Image.path(path: path));
  }

  @override
  List<Object?> get props => [image];
}
