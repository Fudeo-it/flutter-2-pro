import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/blocs/news/news_bloc.dart';
import 'package:news_app/cubits/selected_news_cubit.dart';
import 'package:news_app/models/article.dart';
import 'package:news_app/pages/webview_page.dart';
import 'package:news_app/widgets/article_widget.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => LayoutBuilder(
        builder: (context, constraints) {
          final masterDetail = constraints.maxWidth >= 600;

          return Row(
            children: [
              Expanded(
                flex: 1,
                child: Scaffold(
                  appBar: AppBar(
                    title: const Text('News App'),
                  ),
                  body: _body(
                    context,
                    masterDetail: masterDetail,
                  ),
                ),
              ),
              if (masterDetail)
                Expanded(
                  flex: 2,
                  child: BlocBuilder<SelectedNewsCubit, Article?>(
                    builder: (context, article) => WebViewPage(article),
                  ),
                ),
            ],
          );
        },
      );

  Widget _body(
    BuildContext context, {
    bool masterDetail = false,
  }) =>
      BlocBuilder<NewsBloc, NewsState>(
        builder: (context, state) {
          if (state is ErrorNewsState) {
            return _errorNewsState(state.error);
          } else if (state is FetchingNewsState) {
            return _loadingNewsState();
          } else if (state is NoNewsState) {
            return _noNewsState();
          } else if (state is FetchedNewsState) {
            return _articles(
              state.articles,
              masterDetail: masterDetail,
            );
          }

          return Container();
        },
      );

  Widget _articles(
    List<Article> articles, {
    bool masterDetail = false,
  }) =>
      ListView.builder(
        itemCount: articles.length,
        itemBuilder: (context, index) => ArticleWidget(
          articles[index],
          masterDetail: masterDetail,
          onTap: () => !masterDetail
              ? Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => WebViewPage(articles[index]),
                  ),
                )
              : context.read<SelectedNewsCubit>().select(articles[index]),
        ),
      );

  Widget _errorNewsState(String error) => Center(
        child: Text(error),
      );

  Widget _noNewsState() => const Center(
        child: Text('No news available'),
      );

  Widget _loadingNewsState() => const Center(
        child: CircularProgressIndicator(),
      );
}
