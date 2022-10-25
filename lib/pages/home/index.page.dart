import 'package:blurhash_dart/blurhash_dart.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:leekbox_sdk/log.dart';
import 'package:oktoast/oktoast.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:image/image.dart' as img;
import 'package:rotated_corner_decoration/rotated_corner_decoration.dart';

import '../miui10_anim.dart';

///
class IndexPage extends StatefulWidget {
  @override
  _IndexPageState createState() => _IndexPageState();
}

class _IndexPageState extends State<IndexPage> {
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
    Log.debug('IndexPage build');

    showToast(
      'IndexPage build',
      position: ToastPosition.bottom,
      backgroundColor: Colors.black.withOpacity(0.8),
      radius: 13.0,
      textStyle: const TextStyle(fontSize: 18.0),
      animationBuilder: const Miui10AnimBuilder(),
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text('LEEK BOX'),
      ),
      body: SmartRefresher(
        enablePullUp: true,
        controller: _refreshController,
        onRefresh: _onRefresh,
        onLoading: _onLoading,
        child: Padding(
          padding: const EdgeInsets.only(left: 8.0, right: 8.0),
          child: ListView.builder(
            physics: const ClampingScrollPhysics(),
            itemBuilder: (c, i) => Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: Container(
                padding: const EdgeInsets.all(12),
                foregroundDecoration: RotatedCornerDecoration(
                  color: Colors.blueGrey,
                  geometry: BadgeGeometry(
                    width: 48,
                    height: 48,
                    cornerRadius: 16,
                    alignment: (i ~/ 2) == 0
                        ? BadgeAlignment.bottomLeft
                        : BadgeAlignment.topRight,
                  ),
                  textSpan: const TextSpan(
                    text: 'OMG',
                    style: TextStyle(
                      fontSize: 10,
                      letterSpacing: 1,
                      fontWeight: FontWeight.bold,
                      shadows: [
                        BoxShadow(color: Colors.yellowAccent, blurRadius: 4)
                      ],
                    ),
                  ),
                ),
                child: Text('Apply badge colors and font styles ${items[i]}'),
              ),
            ),
            itemExtent: 100.0,
            itemCount: items.length,
          ),
        ),
      ),
    );
  }

  Widget buildBlurHashImg(int width, int height) {
    assert(width > 0);
    assert(height > 0);
    final image =
        BlurHash.decode('LEHV6nWB2yk8pyo0adR*.7kCMdnj').toImage(width, height);
    return Image.memory(Uint8List.fromList(img.encodeJpg(image)));
  }

// @override
// bool get wantKeepAlive => true;
}
