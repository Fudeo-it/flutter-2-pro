import 'package:equatable/equatable.dart';

class Article extends Equatable {
  final String title;
  final String description;
  final String? urlToImage;
  final String url;
  final String? publishedAt;
  final String? content;

  const Article({
    required this.title,
    required this.description,
    this.urlToImage,
    required this.url,
    this.publishedAt,
    this.content,
  });

  factory Article.fromJson(Map<String, dynamic> json) => Article(
        title: json['title'],
        description: json['description'],
        url: json['url'],
        urlToImage: json['urlToImage'],
        publishedAt: json['publishedAt'],
        content: json['content'],
      );

  @override
  List<Object?> get props => [url];
}
