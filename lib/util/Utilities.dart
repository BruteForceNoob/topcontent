import 'dart:async';
import 'dart:convert';
import 'dart:core';
import 'dart:developer';
import 'package:go_router/go_router.dart';
import 'package:topcontent/main.dart';
import 'package:flutter/foundation.dart';
import '../core/Article.dart';
import 'package:http/http.dart' as http;




enum ArticleCategory{
News, 
Tech,
Business, 
Sports, 
Gaming
}

Future<List<Article>> fetchArticles(
    http.Client client, int pageKey, int pageSize, String category) async {
  final queryParams = {
    'page': pageKey.toString(),
    'size': pageSize.toString(),
    'category': category
  };

  final response =
      await client.get(Uri.https("api-dot-topcontent-355516.nn.r.appspot.com", "/articles", queryParams));

  // Use the compute function to run parsePhotos in a separate isolate.
  return compute(
      parseArticles, const Utf8Decoder().convert(response.bodyBytes));
}

Future<Article> fetchArticle(http.Client client, String articleId) async{
 

  final response =
      await client.get(Uri.https("api-dot-topcontent-355516.nn.r.appspot.com", "/articles/$articleId"));
  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    return Article.fromJson(jsonDecode(const Utf8Decoder().convert(response.bodyBytes)));
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load album');
  }
  
}

List<Article> parseArticles(String responseBody) {
  final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();

  return parsed.map<Article>((json) => Article.fromJson(json)).toList();
}

String makeTitleUrlFriendly(String title){
  try{
  String friendlyTitle=title.toLowerCase().trim();
  friendlyTitle=friendlyTitle.replaceAll(RegExp(r'[^\w\s]+'), '');
  friendlyTitle=friendlyTitle.replaceAll(" ", "-");
  return friendlyTitle;
  }
  catch( error){
    return title;
  }
  
}

