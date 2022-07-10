import 'package:flutter/material.dart';
import 'package:topcontent/core/Article.dart';
import 'package:topcontent/widgets/ArticlesCard.dart';

class ArticlesList extends StatelessWidget {
  const ArticlesList({super.key, required this.articles});

  final List<Article> articles;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate:  SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: MediaQuery.of(context).size.shortestSide>600?3:1,
         crossAxisSpacing: 10,
          mainAxisSpacing: 10,
      ),
      itemCount: articles.length,
      itemBuilder: (context, index) {
        return ArticleCard(articles[index]);
      },
    );
  }
}