import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

enum RefreshState {
  idle,
  refreshing,
  loading,
  failure,
  noMoreData,
}

class RefreshControl extends StatefulWidget {
  final Widget? child;
  final Future<RefreshState> Function()? onRefresh;
  final Future<RefreshState> Function()? onLoading;
  final bool enablePullUp;

  const RefreshControl({
    Key? key,
    this.child,
    this.onRefresh,
    this.onLoading,
    this.enablePullUp = false,
  }) : super(key: key);

  @override
  RefreshControlState createState() => RefreshControlState();
}

class RefreshControlState extends State<RefreshControl> {
  final RefreshController _refreshController = RefreshController();

  toggleRefreshState(RefreshState refreshState) {
    _refreshController.refreshCompleted();
    if (refreshState == RefreshState.idle) {
      _refreshController.loadComplete();
    } else if (refreshState == RefreshState.failure) {
      _refreshController.loadFailed();
    } else if (refreshState == RefreshState.noMoreData) {
      _refreshController.loadNoData();
    }
  }

  @override
  Widget build(BuildContext context) {
    return SmartRefresher(
      onRefresh: widget.onRefresh != null
          ? () async {
              RefreshState refreshState = await widget.onRefresh!();
              toggleRefreshState(refreshState);
            }
          : null,
      onLoading: widget.onLoading != null
          ? () async {
              RefreshState refreshState = await widget.onLoading!();
              toggleRefreshState(refreshState);
            }
          : null,
      controller: _refreshController,
      enablePullUp: widget.enablePullUp,
      child: widget.child,
    );
  }
}
