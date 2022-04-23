import 'package:flutter_test/flutter_test.dart';
import 'package:news_app/services/news_service.dart';

void main() {
  late NewsService service;

  setUp(() {
    service = NewsService();
  });

  test('REST call to everything endpoint', () async {
    final response = await service.everything();

    expect(response, isNotNull);

    expect(response.status, isNotNull);
    expect(response.totalResults, isNotNull);
    expect(response.totalResults, isPositive);
    expect(response.articles, isNotNull);
    expect(response.articles, isNotEmpty);

    for (var article in response.articles) {
      expect(article.title, isNotNull);
      expect(article.description, isNotNull);
      expect(article.url, isNotNull);
    }
  });
}