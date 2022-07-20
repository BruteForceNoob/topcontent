import 'dart:html';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:topcontent/core/Article.dart';
import 'package:topcontent/widgets/ArticlesCard.dart';

import '../util/Utilities.dart';

/*Future<List<Article>> fetchArticles( http.Client client) async {
  final response = await client.get(
      Uri.https("api-dot-topcontent-355516.nn.r.appspot.com", "/articles"));

  // Use the compute function to run parsePhotos in a separate isolate.
  return compute(parseArticles, Utf8Decoder().convert(response.bodyBytes));
}*/

class PaginatedArticleGrid extends StatefulWidget {
  String category;


   PaginatedArticleGrid( this.category, {Key? key}) : super(key: key);
  @override
 
  _PaginatedArticleGridState createState() => _PaginatedArticleGridState();
}

class _PaginatedArticleGridState extends State<PaginatedArticleGrid> with AutomaticKeepAliveClientMixin {
  static const _pageSize = 15;
  final PagingController<int, Article> _pagingController =
      PagingController(firstPageKey: 0);

  @override
  void initState() {
    _pagingController.addPageRequestListener((pageKey) {
      _fetchPage(pageKey);
    });
    super.initState();
  }

  Future<void> _fetchPage(int pageKey) async {
    try {
      final articles = await fetchArticles(http.Client(), pageKey, _pageSize, widget.category);
     
      final isLastPage = articles.length < _pageSize;
      if (isLastPage) {
        _pagingController.appendLastPage(articles);
      } else {
        final nextPageKey = pageKey + 1;
        _pagingController.appendPage(articles, nextPageKey);
      }
    } catch (error) {
      _pagingController.error = error;
    }
  }

  @override
  Widget build(BuildContext context) {
    return PagedGridView(
      scrollController: ScrollController(),
      pagingController: _pagingController,
      builderDelegate: PagedChildBuilderDelegate<Article>(
        itemBuilder: (context, item, index) => ArticleCard(item),
      ),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: MediaQuery.of(context).size.shortestSide > 600 ? 3 : 1,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
    );
  }
   @override
  void dispose() {
    _pagingController.dispose();
    super.dispose();
  }
  
  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
