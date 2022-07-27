import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:topcontent/util/Utilities.dart';
import 'package:http/http.dart' as http;
import 'package:topcontent/widgets/ErrorScreen.dart';
import 'dart:html' as html;
import '../core/Article.dart';

class ArticleDetail extends StatefulWidget {
  const ArticleDetail({required this.articleId, Key? key}) : super(key: key);
  final String articleId;

  @override
  State<ArticleDetail> createState() => _ArticleDetail();
}

class _ArticleDetail extends State<ArticleDetail> {
  Future<Article>? _article;

  @override
  void initState() {
    super.initState();
    _fetch();
  }

  @override
  void didUpdateWidget(covariant ArticleDetail oldWidget) {
    super.didUpdateWidget(oldWidget);

    // refresh cached data
    if (oldWidget.articleId != widget.articleId) _fetch();
  }

  Future<void> _fetch() =>
      _article = fetchArticle(http.Client(), widget.articleId);

  @override
  Widget build(BuildContext context) => FutureBuilder<Article>(
        future: _article,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Scaffold(
              appBar: AppBar(title: const Text('Loading...')),
              body: const Center(child: CircularProgressIndicator()),
            );
          }
          if (snapshot.hasError) {
            return ErrorScreen(new Exception("Something went wrong!"));
          }

          final article = snapshot.data!;
          return Scaffold(
              appBar: AppBar(
                title: Text(_title(context)),
              ),
              body: Column(
                children: [
                  ListTile(
                    title: Text(
                      article.title,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text("Source: ${article.source}, ${article.author}"),
                    minVerticalPadding: 20,
                  ),
                  ListTile(
                      title: Text(article.description,
                          style:
                              TextStyle(color: Colors.black.withOpacity(0.8))),
                      minVerticalPadding: 20),
                  InkWell(
                      child: Text(
                        "Read More",
                        style: TextStyle(color: Colors.blue),
                      ),
                      onTap: () => html.window.open(article.link, "_blank")),
                  Expanded(
                      child: Ink.image(
                    image: CachedNetworkImageProvider(
                        article.imageURL.isNotEmpty
                            ? article.imageURL
                            : article.feedSourceImgLink,
                        maxHeight: 300,
                        maxWidth: 300),
                  )),
                ],
              ));
        },
      );
  String _title(BuildContext context) =>
      (context as Element).findAncestorWidgetOfExactType<MaterialApp>()!.title;
}



    
    /*return Scaffold(
      appBar: AppBar(title: Text(_title(context)),),
      body: Stack(
       children: [
       
         ListTile(title: Text(article!.title, style: const TextStyle(fontWeight: FontWeight.bold),),
        minVerticalPadding: 20,),
        Row(
          children: [
             Expanded(child: Ink.image(image: CachedNetworkImageProvider(article!.imageURL.isNotEmpty
                  ? article!.imageURL
                  : article!.feedSourceImgLink,
              
                 ),
                   alignment: Alignment.center,
                   
                   fit: BoxFit.fill,
                  )),
             Text(article!.description), 
            
          ],
        )
       ],));
    }
    
  }*/
 
