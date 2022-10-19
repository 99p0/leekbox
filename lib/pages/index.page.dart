import 'package:flutter/material.dart';
import 'package:logging/logging.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

///
class IndexPage extends StatefulWidget {
  @override
  _IndexPageState createState() => _IndexPageState();
}

class _IndexPageState extends State<IndexPage> {
  final log = Logger('IndexPage');

  List<String> items = ["1", "2", "3", "4", "5", "6", "7", "8"];
  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  void _onRefresh() async {
    // monitor network fetch
    await Future.delayed(const Duration(milliseconds: 1000));
    // if failed,use refreshFailed()
    items = ["1", "2", "3", "4", "5", "6", "7", "8"];
    _refreshController.refreshCompleted();
    if (mounted) {
      setState(() {});
    }
  }

  void _onLoading() async {
    // monitor network fetch
    await Future.delayed(const Duration(milliseconds: 1000));
    // if failed,use loadFailed(),if no data return,use LoadNodata()
    var len = items.length;
    items.addAll([
      (len + 1).toString(),
      (len + 2).toString(),
      (len + 3).toString(),
      (len + 4).toString(),
      (len + 5).toString(),
      (len + 6).toString(),
      (len + 7).toString(),
      (len + 8).toString(),
      (len + 9).toString(),
      (len + 10).toString(),
      (len + 11).toString(),
      (len + 12).toString(),
      (len + 13).toString(),
      (len + 14).toString(),
      (len + 15).toString(),
      (len + 16).toString(),
      (len + 17).toString(),
      (len + 18).toString(),
      (len + 19).toString(),
      (len + 20).toString(),
    ]);
    if (mounted) {
      setState(() {});
    }
    _refreshController.loadComplete();
  }

  @override
  Widget build(BuildContext context) {
    // super.build(context);

    log.info('IndexPage build');
    return Scaffold(
      appBar: AppBar(
        title: const Text('LEEK BOX'),
      ),
      body: SmartRefresher(
        enablePullUp: true,
        controller: _refreshController,
        onRefresh: _onRefresh,
        onLoading: _onLoading,
        child: ListView.builder(
          physics: const ClampingScrollPhysics(),
          itemBuilder: (c, i) => Card(
              child: Center(
                  child: Text(
            items[i],
            style: const TextStyle(color: Colors.black),
          ))),
          itemExtent: 100.0,
          itemCount: items.length,
        ),
      ),
    );
  }

// @override
// bool get wantKeepAlive => true;
}
