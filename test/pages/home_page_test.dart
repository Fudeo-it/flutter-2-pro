import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:news_app/blocs/news/news_bloc.dart';
import 'package:news_app/cubits/selected_news_cubit.dart';
import 'package:news_app/models/article.dart';
import 'package:news_app/pages/home_page.dart';

class MockNewsBloc extends MockBloc<NewsEvent, NewsState> implements NewsBloc {}

class MockSelectedNewsCubit extends MockCubit<Article?>
    implements SelectedNewsCubit {}

void main() {
  testWidgets('test home with error message', (tester) async {
    final newsBloc = MockNewsBloc();
    final selectedNewsCubit = MockSelectedNewsCubit();

    whenListen(
      newsBloc,
      Stream.fromIterable([
        FetchingNewsState(),
        const ErrorNewsState('custom error'),
      ]),
      initialState: FetchingNewsState(),
    );

    await tester.pumpWidget(
      MultiBlocProvider(
        providers: [
          BlocProvider<NewsBloc>(create: (_) => newsBloc),
          BlocProvider<SelectedNewsCubit>(create: (_) => selectedNewsCubit),
        ],
        child: const MaterialApp(
          home: HomePage(),
        ),
      ),
    );

    await tester.pumpAndSettle();
    expect(find.text('custom error'), findsOneWidget);
  });

  testWidgets('test home without news', (tester) async {
    final newsBloc = MockNewsBloc();
    final selectedNewsCubit = MockSelectedNewsCubit();

    whenListen(
      newsBloc,
      Stream.fromIterable([
        FetchingNewsState(),
        NoNewsState(),
      ]),
      initialState: FetchingNewsState(),
    );

    await tester.pumpWidget(
      MultiBlocProvider(
        providers: [
          BlocProvider<NewsBloc>(create: (_) => newsBloc),
          BlocProvider<SelectedNewsCubit>(create: (_) => selectedNewsCubit),
        ],
        child: const MaterialApp(
          home: HomePage(),
        ),
      ),
    );

    await tester.pumpAndSettle();
    expect(find.text('No news available'), findsOneWidget);
  });

  testWidgets('test home page with width < 600', (tester) async {
    tester.binding.window.physicalSizeTestValue = const Size(599, 400);
    tester.binding.window.devicePixelRatioTestValue = 1.0;

    final articles = [
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
    ];

    final newsBloc = MockNewsBloc();
    final selectedNewsCubit = MockSelectedNewsCubit();

    whenListen(
      newsBloc,
      Stream.fromIterable([
        FetchingNewsState(),
        FetchedNewsState(articles),
      ]),
      initialState: FetchingNewsState(),
    );

    await tester.pumpWidget(
      MultiBlocProvider(
        providers: [
          BlocProvider<NewsBloc>(create: (_) => newsBloc),
          BlocProvider<SelectedNewsCubit>(create: (_) => selectedNewsCubit),
        ],
        child: const MaterialApp(
          home: HomePage(),
        ),
      ),
    );

    await tester.pumpAndSettle();

    for (var article in articles) {
      expect(find.text(article.title), findsOneWidget);
      expect(find.text(article.description), findsOneWidget);
    }
  });

  testWidgets('test home page with width >= 600', (tester) async {
    tester.binding.window.physicalSizeTestValue = const Size(600, 400);
    tester.binding.window.devicePixelRatioTestValue = 1.0;

    final articles = [
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
    ];

    final newsBloc = MockNewsBloc();
    final selectedNewsCubit = MockSelectedNewsCubit();

    whenListen(
      newsBloc,
      Stream.fromIterable([
        FetchingNewsState(),
        FetchedNewsState(articles),
      ]),
      initialState: FetchingNewsState(),
    );

    await tester.pumpWidget(
      MultiBlocProvider(
        providers: [
          BlocProvider<NewsBloc>(create: (_) => newsBloc),
          BlocProvider<SelectedNewsCubit>(create: (_) => selectedNewsCubit),
        ],
        child: const MaterialApp(
          home: HomePage(),
        ),
      ),
    );

    await tester.pumpAndSettle();

    for (var article in articles) {
      expect(find.text(article.title), findsOneWidget);
      expect(find.text(article.description), findsNothing);
    }
  });
}
