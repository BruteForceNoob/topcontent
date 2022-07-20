import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:seo_renderer/helpers/renderer_state.dart';
import 'package:seo_renderer/helpers/robot_detector_vm.dart';
import 'package:seo_renderer/renderers/text_renderer/text_renderer_style.dart';
import 'package:seo_renderer/renderers/text_renderer/text_renderer_vm.dart';
import 'package:topcontent/config/DefaultFirebaseConfig.dart';
import 'package:topcontent/core/Article.dart';
import 'dart:convert';
import 'package:flutter/foundation.dart';

import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:topcontent/core/ArticleTabBarView.dart';
import 'package:topcontent/widgets/PaginatedArticleGrid.dart';

import 'core/ErrorScreen.dart';
import 'core/HomePageView.dart';
import 'package:topcontent/util/Utilities.dart';



Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseConfig.platformOptions);
  GoRouter.setUrlPathStrategy(UrlPathStrategy.path);
  runApp( TopContent());
}

class TopContent extends StatelessWidget {
   TopContent({super.key});

  static FirebaseAnalytics analytics = FirebaseAnalytics.instance;
  static FirebaseAnalyticsObserver observer =
      FirebaseAnalyticsObserver(analytics: analytics);

  static const appTitle = 'TopContent';
  @override
  Widget build(BuildContext context) => MaterialApp.router(routeInformationParser: _router.routeInformationParser, routerDelegate: _router.routerDelegate, title: appTitle, routeInformationProvider: _router.routeInformationProvider,);

  final _router = GoRouter(
    initialLocation: '/',
    routes: [
      
      GoRoute(
        name:"home",
        path: '/',
        redirect: (_)=>'/category/${ArticleCategory.values[0].name}',
        //builder: (context, state) =>  HomePageView(title: appTitle, analytics: analytics, observer: observer),
      ),
      GoRoute(
      name:"category",
      path: "/category/:categoryId",
      builder: (context, state) {
        final categoryId = state.params['categoryId']!;
        return ArticleTabBarView(key: state.pageKey, category: ArticleCategory.values.firstWhere((element) => categoryId==element.name), analytics: analytics, observer: observer,);
      },
       )
     
    ],
    errorBuilder: (context, state) => ErrorScreen(state.error!),
  );
    


    /*return MaterialApp(
      theme: ThemeData(fontFamily: "Tahoma"),
      title: appTitle,
      navigatorObservers: <NavigatorObserver>[observer, seoRouteObserver],
      home: HomePageView(
          title: appTitle,
          analytics: analytics,
          observer: observer,
          seoRouteObserver: seoRouteObserver),
    );*/
  
}

