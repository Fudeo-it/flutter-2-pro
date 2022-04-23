import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/services/pigeon.g.dart';

class SelectedNewsCubit extends Cubit<Article?> {
  SelectedNewsCubit() : super(null);

  void select(Article article) => emit(article);
}
