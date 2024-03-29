import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

/// 示例如下：
// showDialog(
//     barrierColor: Colors.black,
//     context: context,
//     builder: (context) {
//       return const PhotoViewSimpleScreen(
//           imageProvider: NetworkImage(
//             'https://p9-juejin.byteimg.com/tos-cn-i-k3u1fbpfcp/e5677df5f1fe4df2b266273c3188ea37~tplv-k3u1fbpfcp-watermark.image?',
//           ),
//           heroTag: 'simple');
//     }
// )
// ...
// 单图片预览
class PhotoViewPage extends StatelessWidget {
  const PhotoViewPage({
    Key? key,
    required this.imageProvider, //图片
    required this.heroTag, //hero动画tagid , 不设置或null为不启用hero动画
    this.loadingChild, //加载时的widget
    this.backgroundDecoration = const BoxDecoration(color: Colors.black), //背景修饰
    this.minScale, //最大缩放倍数
    this.maxScale, //最小缩放倍数
  }) : super(key: key);
  final ImageProvider imageProvider;
  final LoadingBuilder? loadingChild;
  final BoxDecoration backgroundDecoration;
  final dynamic minScale;
  final dynamic maxScale;
  final String heroTag;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        constraints: BoxConstraints.expand(
          height: MediaQuery.of(context).size.height,
        ),
        child: GestureDetector(
          onTapDown: (_) {
            Navigator.pop(context);
          },
          child: PhotoView(
            imageProvider: imageProvider,
            loadingBuilder: loadingChild,
            backgroundDecoration: backgroundDecoration,
            minScale: minScale,
            maxScale: maxScale,
            heroAttributes: PhotoViewHeroAttributes(tag: heroTag),
            enableRotation: false, //是否允许旋转
          ),
        ),
      ),
    );
  }
}
