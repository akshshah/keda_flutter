import 'package:flutter/material.dart';

class PullToRefreshGridView extends StatelessWidget {
  final EdgeInsets padding;
  final SliverGridDelegate gridDelegate;
  final int itemCount;
  final IndexedWidgetBuilder builder;
  final RefreshCallback onRefresh;
  final ScrollPhysics? physics;
  final ScrollController? controller;
  final bool shrinkWrap;

  PullToRefreshGridView({
    this.padding = const EdgeInsets.only(bottom: 5.0),
    required this.gridDelegate,
    required this.itemCount,
    required this.builder,
    required this.onRefresh,
    this.physics,
    this.controller,
    this.shrinkWrap = false,
  });

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      child: GridView.builder(
        padding: padding,
        gridDelegate: gridDelegate,
        itemCount: itemCount,
        itemBuilder: builder,
        physics: physics,
        controller: controller,
        shrinkWrap: shrinkWrap,
        scrollDirection: Axis.vertical,
      ),
      onRefresh: onRefresh,
    );
  }
}
