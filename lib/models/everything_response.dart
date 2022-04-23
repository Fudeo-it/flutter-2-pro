import 'package:news_app/models/article.dart';

class EverythingResponse {
  final String status;
  final int totalResults;
  final List<Article> articles;

  EverythingResponse({
    required this.status,
    required this.totalResults,
    required this.articles,
  });

  factory EverythingResponse.fromJson(Map<String, dynamic> json) =>
      EverythingResponse(
        status: json['status'],
        totalResults: json['totalResults'],
        articles: (json['articles'] as List<dynamic>)
            .map((e) => Article.fromJson(e as Map<String, dynamic>))
            .toList(),
      );
}
