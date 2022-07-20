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
      await client.get(Uri.https("topcontent.ca", "/articles", queryParams));

  // Use the compute function to run parsePhotos in a separate isolate.
  return compute(
      parseArticles, const Utf8Decoder().convert(response.bodyBytes));
}

List<Article> parseArticles(String responseBody) {
  final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();

  return parsed.map<Article>((json) => Article.fromJson(json)).toList();
}