// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:leekbox_infra/log/log.dart';
// import 'package:pull_to_refresh/pull_to_refresh.dart';
//
// ///
// class IndexSquarePage extends ConsumerStatefulWidget {
//   @override
//   _IndexSquarePageState createState() => _IndexSquarePageState();
// }
//
// class _IndexSquarePageState extends ConsumerState<IndexSquarePage>
//     with AutomaticKeepAliveClientMixin, TickerProviderStateMixin {
//   @override
//   bool get wantKeepAlive => true;
//
//   @override
//   void initState() {
//     super.initState();
//   }
//
//   @override
//   void dispose() {
//     super.dispose();
//   }
//
//   final RefreshController _refreshController =
//       RefreshController(initialRefresh: false);
//
//   void _onRefresh() async {
//     // monitor network fetch
//     await Future.delayed(const Duration(milliseconds: 1000));
//     // if failed,use refreshFailed()
//     _refreshController.refreshCompleted();
//   }
//
//   List<String> items = ["1", "2", "3", "4", "5", "6", "7", "8"];
//
//   void _onLoading() async {
//     // monitor network fetch
//     await Future.delayed(const Duration(milliseconds: 1000));
//     // if failed,use loadFailed(),if no data return,use LoadNodata()
//     items.add((items.length + 1).toString());
//     if (mounted) setState(() {});
//     _refreshController.loadComplete();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     super.build(context);
//     Log.debug('IndexSquarePage build');
//
//     return Scaffold(
//       body: SmartRefresher(
//         enablePullDown: true,
//         enablePullUp: true,
//         header: const WaterDropHeader(),
//         footer: CustomFooter(
//           builder: (BuildContext context, LoadStatus? mode) {
//             Widget body;
//             if (mode == LoadStatus.idle) {
//               body = Text("pull up load");
//             } else if (mode == LoadStatus.loading) {
//               body = CupertinoActivityIndicator();
//             } else if (mode == LoadStatus.failed) {
//               body = Text("Load Failed!Click retry!");
//             } else if (mode == LoadStatus.canLoading) {
//               body = Text("release to load more");
//             } else {
//               body = Text("No more Data");
//             }
//             return Container(
//               height: 55.0,
//               child: Center(child: body),
//             );
//           },
//         ),
//         controller: _refreshController,
//         onRefresh: _onRefresh,
//         onLoading: _onLoading,
//         child: ListView.builder(
//           itemBuilder: (c, i) => Card(child: Center(child: Text(items[i]))),
//           itemExtent: 100.0,
//           itemCount: items.length,
//         ),
//       ),
//     );
//   }
// }
