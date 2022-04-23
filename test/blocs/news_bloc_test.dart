import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:news_app/blocs/news/news_bloc.dart';
import 'package:news_app/models/article.dart';
import 'package:news_app/repositories/news_repository.dart';

import 'news_bloc_test.mocks.dart';

@GenerateMocks([NewsRepository])
void main() {
  late NewsRepository newsRepository;

  setUp(() {
    newsRepository = MockNewsRepository();
  });

  blocTest<NewsBloc, NewsState>('getting the news list',
      setUp: () => when(newsRepository.news()).thenAnswer((_) async => [
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
          ]),
      build: () => NewsBloc(newsRepository: newsRepository),
      act: (bloc) => bloc.fetchNews(),
      expect: () => [
            FetchingNewsState(),
            const FetchedNewsState([
              Article(
                title: 'title1',
                description: 'description1',
                url: 'url1',
              ),
              Article(
                title: 'title2',
                description: 'description2',
                url: 'url2',
              ),
            ]),
          ]);

  blocTest<NewsBloc, NewsState>(
    'getting an empty news list',
    setUp: () => when(newsRepository.news()).thenAnswer((_) async => []),
    build: () => NewsBloc(newsRepository: newsRepository),
    act: (bloc) => bloc.fetchNews(),
    expect: () => [
      FetchingNewsState(),
      NoNewsState(),
    ],
  );

  blocTest<NewsBloc, NewsState>(
    'throwing an error while getting news',
    setUp: () => when(newsRepository.news()).thenThrow(Error()),
    build: () => NewsBloc(newsRepository: newsRepository),
    act: (bloc) => bloc.fetchNews(),
    expect: () => [
      FetchingNewsState(),
      isA<ErrorNewsState>(),
    ],
  );
}
