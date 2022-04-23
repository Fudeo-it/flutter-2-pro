import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:news_app/models/article.dart';
import 'package:news_app/models/everything_response.dart';
import 'package:news_app/repositories/news_repository.dart';
import 'package:news_app/services/news_service.dart';

import 'news_repository_test.mocks.dart';

@GenerateMocks([NewsService])
void main() {
  late NewsRepository newsRepository;
  late NewsService newsService;

  setUp(() {
    newsService = MockNewsService();
    newsRepository = NewsRepository(newsService: newsService);
  });

  test('fetching articles from newsRepository', () async {
    when(newsService.everything()).thenAnswer(
      (_) async => EverythingResponse(
        status: '200',
        totalResults: 2,
        articles: [
          const Article(
            title: 'title1',
            description: 'description1',
            url: 'url1',
          ),
          const Article(
            title: 'title2',
            description: 'description2',
            url: 'url2',
          ),
        ],
      ),
    );

    final articles = await newsRepository.news();

    expect(articles, isNotNull);
    expect(articles, isNotEmpty);
    expect(articles.length, 2);

    expect(articles.first.title, 'title1');
    expect(articles.first.description, 'description1');
    expect(articles.first.url, 'url1');

    expect(articles.last.title, 'title2');
    expect(articles.last.description, 'description2');
    expect(articles.last.url, 'url2');
  });

  test('no articles from newsRepository', () async {
    when(newsService.everything()).thenAnswer(
      (_) async => EverythingResponse(
        status: '200',
        totalResults: 0,
        articles: const [],
      ),
    );

    final articles = await newsRepository.news();

    expect(articles, isNotNull);
    expect(articles, isEmpty);
  });

  test('exception from newsRepository', () async {
    when(newsService.everything()).thenThrow(Exception());

    List<Article>? articles;
    try {
      articles = await newsRepository.news();
    } catch (error) {
      expect(error, isNotNull);
    }

    expect(articles, isNull);
  });
}
