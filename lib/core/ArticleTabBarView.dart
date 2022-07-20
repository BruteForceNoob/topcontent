import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:topcontent/util/Utilities.dart';
import 'package:topcontent/widgets/PaginatedArticleGrid.dart';

class ArticleTabBarView extends StatefulWidget {
  final int index;
  final FirebaseAnalytics analytics;
  final FirebaseAnalyticsObserver observer;
  ArticleTabBarView({required ArticleCategory category, required this.analytics,
    required this.observer, Key? key})
      : index = ArticleCategory.values.indexOf(category),
        super(key: key) {
    assert(index != -1);
  }

  @override
  _ArticleTabBarViewState createState() => _ArticleTabBarViewState();
}

class _ArticleTabBarViewState extends State<ArticleTabBarView>
    with TickerProviderStateMixin {
  late final TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
        length: ArticleCategory.values.length,
        vsync: this,
        initialIndex: widget.index);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(ArticleTabBarView oldWidget) {
    super.didUpdateWidget(oldWidget);
    _tabController.index = widget.index;
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Text(_title(context)),
          bottom: TabBar(
            controller: _tabController,
            tabs: [for (final c in ArticleCategory.values) Tab(text: c.name)],
            onTap: (index) => _tap(context, index),
          ),
        ),
        body: TabBarView(
          controller: _tabController,
          children: [
            for (final c in ArticleCategory.values) PaginatedArticleGrid(c.name)
          ],
        ),
      );

  void _tap(BuildContext context, int index) =>
      context.go('/category/${ArticleCategory.values[index].name}');

  String _title(BuildContext context) =>
      (context as Element).findAncestorWidgetOfExactType<MaterialApp>()!.title;
}
