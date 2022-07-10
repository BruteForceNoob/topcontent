import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:topcontent/config/DefaultFirebaseConfig.dart';
import 'package:topcontent/core/Article.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:topcontent/widgets/ArticlesList.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_core/firebase_core.dart';

Future<List<Article>> fetchArticles(http.Client client) async {
  final response = await client.get(
      Uri.https("api-dot-topcontent-355516.nn.r.appspot.com", "/articles"));

  // Use the compute function to run parsePhotos in a separate isolate.
  return compute(parseArticles, Utf8Decoder().convert(response.bodyBytes));
}

List<Article> parseArticles(String responseBody) {
  final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();

  return parsed.map<Article>((json) => Article.fromJson(json)).toList();
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseConfig.platformOptions);
  runApp(const TopContent());
}

class TopContent extends StatelessWidget {
  const TopContent({super.key});

  static FirebaseAnalytics analytics = FirebaseAnalytics.instance;
  static FirebaseAnalyticsObserver observer =
      FirebaseAnalyticsObserver(analytics: analytics);

  @override
  Widget build(BuildContext context) {
    const appTitle = 'TopContent';

    return MaterialApp(
      title: appTitle,
      navigatorObservers: <NavigatorObserver>[observer],
      home: HomePage(title: appTitle, analytics: analytics, observer: observer),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage(
      {super.key,
      required this.title,
      required this.analytics,
      required this.observer});

  final String title;
  final FirebaseAnalytics analytics;
  final FirebaseAnalyticsObserver observer;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: FutureBuilder<List<Article>>(
        future: fetchArticles(http.Client()),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            log(snapshot.error.toString());
            return const Center(
              child: Text('An error has occurred!'),
            );
          } else if (snapshot.hasData) {
            return ArticlesList(articles: snapshot.data!);
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
