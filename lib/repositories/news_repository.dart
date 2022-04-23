import 'package:news_app/services/pigeon.g.dart';

class NewsRepository {
  final ArticleApi newsService;

  NewsRepository({required this.newsService});

  Future<List<Article?>> news() async {
    try {
      return await newsService.articles();
    } catch (error) {
      throw Error();
    }
  }
}
