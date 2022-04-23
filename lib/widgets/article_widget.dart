import 'package:flutter/material.dart';
import 'package:news_app/services/pigeon.g.dart';

class ArticleWidget extends StatelessWidget {
  final Article article;
  final VoidCallback? onTap;
  final bool masterDetail;

  const ArticleWidget(
    this.article, {
    Key? key,
    this.onTap,
    this.masterDetail = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => ListTile(
        title: Text(article.title),
        subtitle: !masterDetail
            ? Text(
                article.descr,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              )
            : null,
        leading: article.urlToImage != null
            ? AspectRatio(
                child:
                    Image.network(article.urlToImage!, key: const Key('image')),
                aspectRatio: masterDetail ? 1 : 16 / 9,
              )
            : null,
        onTap: onTap,
      );
}
