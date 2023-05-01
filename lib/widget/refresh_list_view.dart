import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'refresh_control.dart';

typedef ScrollHandler = void Function(ScrollController controller);

class RefreshListView extends StatefulWidget {
  final EdgeInsetsGeometry? padding;
  final IndexedWidgetBuilder itemBuilder;
  final IndexedWidgetBuilder? separatorBuilder;
  final int itemCount;
  final ScrollController? scrollController;
  final Future<RefreshState> Function()? onHeaderRefresh;
  final Future<RefreshState> Function()? onFooterRefresh;
  final Widget? listHeader;
  final ScrollPhysics physics;

  const RefreshListView({
    Key? key,
    required this.itemBuilder,
    required this.itemCount,
    this.padding,
    this.scrollController,
    this.onHeaderRefresh,
    this.onFooterRefresh,
    this.listHeader,
    this.separatorBuilder,
    this.physics = const AlwaysScrollableScrollPhysics(),
  }) : super(key: key);

  @override
  RefreshListViewState createState() {
    return RefreshListViewState();
  }
}

class RefreshListViewState extends State<RefreshListView> {
  final _refreshControlKey = GlobalKey<RefreshControlState>();

  toggleRefreshState(RefreshState refreshState) {
    _refreshControlKey.currentState!.toggleRefreshState(refreshState);
  }

  List<Widget> _buildSlivers() {
    List<Widget> slivers = <Widget>[];
    if (widget.listHeader != null) {
      if (widget.listHeader is SliverAppBar || widget.listHeader is SliverPersistentHeader) {
        slivers.add(widget.listHeader!);
      } else {
        slivers.add(SliverToBoxAdapter(
          child: widget.listHeader,
        ));
      }
    }
    if (widget.itemCount > 0) {
      int computeSemanticChildCount(int itemCount) {
        return math.max(0, itemCount * 2 - 1);
      }

      if (widget.separatorBuilder != null) {
        slivers.add(SliverList(
          delegate: SliverChildBuilderDelegate(
            (BuildContext context, int index) {
              final int itemIndex = index ~/ 2;
              Widget widget;
              if (index.isEven) {
                widget = this.widget.itemBuilder(context, itemIndex);
              } else {
                widget = this.widget.separatorBuilder!(context, itemIndex);
                assert(() {
                  return true;
                }());
              }
              return widget;
            },
            childCount: computeSemanticChildCount(widget.itemCount),
            addAutomaticKeepAlives: true,
            addRepaintBoundaries: true,
            addSemanticIndexes: true,
            semanticIndexCallback: (Widget _, int index) {
              return index.isEven ? index ~/ 2 : null;
            },
          ),
        ));
      } else {
        slivers.add(SliverList(
          delegate: SliverChildBuilderDelegate(
            widget.itemBuilder,
            childCount: widget.itemCount,
            addAutomaticKeepAlives: true,
            addRepaintBoundaries: true,
            addSemanticIndexes: true,
          ),
        ));
      }
    }
    return slivers;
  }

  @override
  Widget build(BuildContext context) {
    return RefreshControl(
      key: _refreshControlKey,
      onRefresh: widget.onHeaderRefresh,
      onLoading: widget.onFooterRefresh,
      enablePullUp: widget.onFooterRefresh != null,
      child: CustomScrollView(
        physics: widget.physics,
        controller: widget.scrollController,
        slivers: _buildSlivers(),
      ),
    );
  }
}
