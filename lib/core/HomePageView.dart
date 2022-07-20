import 'dart:developer';
import 'package:go_router/go_router.dart';

import 'package:flutter/material.dart';
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
import 'package:topcontent/widgets/PaginatedArticleGrid.dart';

class HomePageView extends StatefulWidget {
  const HomePageView({
    super.key,
    required this.title,
    required this.analytics,
    required this.observer,
  });

  final String title;
  final FirebaseAnalytics analytics;
  final FirebaseAnalyticsObserver observer;

  @override
  State<HomePageView> createState() => _HomePageViewState();
}

class _HomePageViewState extends State<HomePageView>
    with TickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 5, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const TextRenderer(
            style: TextRendererStyle.header1, child: Text("TopContent")),
        bottom: TabBar(
          isScrollable:
              MediaQuery.of(context).size.shortestSide > 600 ? false : true,
          controller: _tabController,
          tabs: const <Widget>[
            Tab(
                child: TextRenderer(
                    style: TextRendererStyle.header1, child: Text("News"))),
            Tab(
                child: TextRenderer(
                    style: TextRendererStyle.header1, child: Text("Tech"))),
            Tab(
                child: TextRenderer(
                    style: TextRendererStyle.header1, child: Text("Business"))),
            Tab(
                child: TextRenderer(
                    style: TextRendererStyle.header1, child: Text("Sports"))),
            Tab(
                child: TextRenderer(
                    style: TextRendererStyle.header1, child: Text("Gaming"))),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: <Widget>[
          Center(
            child: PaginatedArticleGrid("News")),
          Center(
            child: PaginatedArticleGrid("Tech"),
          ),
          Center(
            child: PaginatedArticleGrid("Business"),
          ),
          Center(
            child: PaginatedArticleGrid("Sports"),
          ),
          Center(
            child: PaginatedArticleGrid("Gaming"),
          )
        ],
      ),
    );
  }
}
