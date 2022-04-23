import 'package:bloc_test/bloc_test.dart';
import 'package:news_app/cubits/selected_news_cubit.dart';
import 'package:news_app/models/article.dart';

void main() {
  blocTest<SelectedNewsCubit, Article?>('test selecting a news',
      build: () => SelectedNewsCubit(),
      act: (cubit) => cubit.select(
            const Article(
                title: 'title', description: 'description', url: 'url'),
          ),
      expect: () => [
            const Article(
                title: 'title', description: 'description', url: 'url'),
          ]);
}
