import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:news_app/models/article.dart';
import 'package:news_app/widgets/article_widget.dart';

void main() {
  setUpAll(() {
    HttpOverrides.global = null;
  });

  testWidgets('test article widget', (tester) async {
    const article = Article(
      title: 'title',
      description: 'description',
      url: 'url',
    );

    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: ArticleWidget(article),
        ),
      ),
    );

    expect(find.text('title'), findsOneWidget);
    expect(find.text('description'), findsOneWidget);
    expect(find.byKey(const Key('image')), findsNothing);
  });

  testWidgets('test article widget with image', (tester) async {
    const article = Article(
      title: 'title',
      description: 'description',
      url: 'url',
      urlToImage:
          'https://upload.wikimedia.org/wikipedia/commons/thumb/b/b6/Image_created_with_a_mobile_phone.png/1200px-Image_created_with_a_mobile_phone.png',
    );

    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: ArticleWidget(article),
        ),
      ),
    );

    expect(find.text('title'), findsOneWidget);
    expect(find.text('description'), findsOneWidget);
    expect(find.byKey(const Key('image')), findsOneWidget);
  });

  testWidgets('test article widget in master/detail', (tester) async {
    const article = Article(
      title: 'title',
      description: 'description',
      url: 'url',
    );

    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: ArticleWidget(article, masterDetail: true),
        ),
      ),
    );

    expect(find.text('title'), findsOneWidget);
    expect(find.text('description'), findsNothing);
    expect(find.byKey(const Key('image')), findsNothing);
  });
}
