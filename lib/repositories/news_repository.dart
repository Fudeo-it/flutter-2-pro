import 'package:news_app/models/article.dart';
import 'package:news_app/services/news_service.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

class NewsRepository {
  final NewsService newsService;

  NewsRepository({required this.newsService});

  Future<List<Article>> news() async {
    try {
      final response = await newsService.everything();

      return response.articles;
    } catch (error, stackTrace) {
      await Sentry.captureException(
        error,
        stackTrace: stackTrace,
      );

      throw Error();
    }
  }
}
