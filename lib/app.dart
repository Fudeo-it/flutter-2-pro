import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/blocs/news/news_bloc.dart';
import 'package:news_app/cubits/selected_news_cubit.dart';
import 'package:news_app/pages/home_page.dart';
import 'package:news_app/repositories/news_repository.dart';
import 'package:news_app/services/pigeon.g.dart';
import 'package:provider/provider.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) => MultiProvider(
        providers: [
          Provider(create: (_) => ArticleApi()),
        ],
        child: MultiRepositoryProvider(
          child: MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (context) => NewsBloc(
                  newsRepository: context.read(),
                )..fetchNews(),
              ),
              BlocProvider(
                create: (_) => SelectedNewsCubit(),
              ),
            ],
            child: MaterialApp(
              debugShowCheckedModeBanner: false,
              title: 'News App',
              theme: ThemeData(
                primarySwatch: Colors.blue,
                visualDensity: VisualDensity.adaptivePlatformDensity,
              ),
              home: const HomePage(),
            ),
          ),
          providers: [
            RepositoryProvider<NewsRepository>(
              create: (context) => NewsRepository(
                newsService: context.read(),
              ),
            ),
          ],
        ),
      );
}
