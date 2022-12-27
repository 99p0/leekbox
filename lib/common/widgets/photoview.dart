// import 'package:flutter/material.dart';
// import 'package:photo_view/photo_view.dart';
//
// // 单图片预览
// class PhotoViewPage extends StatelessWidget {
//   const PhotoViewPage({
//     Key? key,
//     required this.imageProvider, //图片
//     required this.heroTag, //hero动画tagid , 不设置或null为不启用hero动画
//     this.loadingChild, //加载时的widget
//     this.backgroundDecoration = const BoxDecoration(color: Colors.black), //背景修饰
//     this.minScale, //最大缩放倍数
//     this.maxScale, //最小缩放倍数
//   }) : super(key: key);
//   final ImageProvider imageProvider;
//   final LoadingBuilder? loadingChild;
//   final BoxDecoration backgroundDecoration;
//   final dynamic minScale;
//   final dynamic maxScale;
//   final String heroTag;
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Container(
//         constraints: BoxConstraints.expand(
//           height: MediaQuery.of(context).size.height,
//         ),
//         child: Stack(
//           children: <Widget>[
//             Positioned(
//               top: 0,
//               left: 0,
//               bottom: 0,
//               right: 0,
//               child: PhotoView(
//                 imageProvider: imageProvider,
//                 loadingBuilder: loadingChild,
//                 backgroundDecoration: backgroundDecoration,
//                 minScale: minScale,
//                 maxScale: maxScale,
//                 heroAttributes: PhotoViewHeroAttributes(tag: heroTag),
//                 enableRotation: true, //是否允许旋转
//               ),
//             ),
//             GestureDetector(
//               onTap: () {
//                 // print('context:$context');
//               },
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }
