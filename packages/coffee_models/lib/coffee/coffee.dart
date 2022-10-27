import 'package:equatable/equatable.dart';

class Coffee extends Equatable {
  final String imageUrl;

  const Coffee({
    required this.imageUrl,
  });

  factory Coffee.fromJson(Map<String, dynamic> json) {
    return Coffee(imageUrl: json['file']);
  }

  factory Coffee.fromLocal(String url) {
    return Coffee(imageUrl: url);
  }

  @override
  List<Object?> get props => [imageUrl];
}
