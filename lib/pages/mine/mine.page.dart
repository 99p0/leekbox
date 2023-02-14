import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:leekbox/common/widgets/gaps.dart';
import 'package:leekbox/common/widgets/my_set_cell.dart';
import 'package:leekbox/pages/setting/setting.page.dart';
import 'package:leekbox_infra/log/log.dart';

///
class MinePage extends StatefulWidget {
  const MinePage({super.key});

  @override
  _MinePageState createState() => _MinePageState();
}

class _MinePageState extends State<MinePage>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    Log.debug('MinePage build...');

    // precacheImage(
    //     const NetworkImage(
    //         'https://tse3-mm.cn.bing.net/th/id/OIP-C.i1PziVBVsRfRbqQyRhGAeQAAAA?pid=ImgDet&rs=1'),
    //     context);

    return Container(
      color: Theme.of(context).scaffoldBackgroundColor,
      child: SingleChildScrollView(
        child: getBody(context),
      ),
    );
  }

  Widget getBody(BuildContext context) {
    return Padding(
      padding: EdgeInsets.zero,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Gaps.vGap4,
          _buildCard(),
          Gaps.vGap4,
          MySetCell(
            title: '荷包',
            leftImgPath: 'assets/images/mine/ic_moneybags.png',
            clickCallBack: () => {},
          ),
          Gaps.vGap4,
          MySetCell(
            title: '会员',
            leftImgPath: 'assets/images/mine/ic_vip_gold.png',
            clickCallBack: () => {},
          ),
          MySetCell(
            title: '卡包',
            leftImgPath: 'assets/images/mine/ic_cards_wallet.png',
            clickCallBack: () => {},
          ),
          Gaps.vGap4,
          MySetCell(
            title: '设置',
            leftImgPath: 'assets/images/mine/ic_setting.png',
            clickCallBack: () => context.push(SettingPage.routeLocation),
          ),
        ],
      ),
    );
  }

  Widget _buildCard() {
    return Container(
      constraints: const BoxConstraints(
        minWidth: double.infinity,
        minHeight: 210,
      ),
      padding: const EdgeInsets.fromLTRB(20, 0, 10, 25),
      child: InkWell(
        onTap: () => {},
        child: SizedBox(
          width: double.infinity,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              Column(
                children: <Widget>[
                  GestureDetector(
                    onTap: _showAvatarView(context,
                        const AssetImage('assets/images/def_avatar.png')),
                    child: SizedBox(
                      width: 55.w,
                      height: 55.w,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.asset(
                          'assets/images/def_avatar.png',
                          gaplessPlayback: true,
                        ),
                      ),
                    ),
                  ),
                  Gaps.vGap10,
                ],
              ),
              Gaps.hGap16,
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: <Widget>[
                        Text(
                          '润歌',
                          style: TextStyle(
                            fontSize: 16.0.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Gaps.hGap16,
                        const Icon(
                          Icons.male,
                          size: 14,
                          color: Color(0xFF027AFF), //Color(0xFFFA8072),
                        ),
                      ],
                    ),
                    Gaps.vGap12,
                    Row(
                      children: <Widget>[
                        Text(
                          '账号：666666',
                          style: TextStyle(
                            color: const Color(0xFF828282),
                            fontSize: 11.0.sp,
                          ),
                        ),
                        Expanded(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: <Widget>[
                              InkWell(
                                onTap: () => {},
                                child: const Icon(
                                  Icons.qr_code,
                                  size: 14,
                                  color: Color(0xFF828282),
                                ),
                              ),
                              Gaps.hGap15,
                              InkWell(
                                onTap: () => {},
                                child: const Icon(
                                  Icons.arrow_forward_ios,
                                  size: 14,
                                  color: Color(0xFF828282),
                                ),
                              ),
                              Gaps.hGap15,
                            ],
                          ),
                        )
                      ],
                    ),
                    Gaps.vGap8,
                    Row(
                      children: <Widget>[
                        const Icon(
                          Icons.location_on_outlined,
                          size: 14,
                          color: Color(0xFF828282),
                        ),
                        Text(
                          '河北 沧州',
                          style: TextStyle(
                            color: const Color(0xFF828282),
                            fontSize: 10.0.sp,
                          ),
                        ),
                        Gaps.hGap15,
                        Text(
                          'IP属地:',
                          style: TextStyle(
                            color: const Color(0xFF828282),
                            fontSize: 10.0.sp,
                          ),
                        ),
                        Gaps.hGap5,
                        Text(
                          '中国 北京 北京市',
                          style: TextStyle(
                            color: const Color(0xFF828282),
                            fontSize: 10.0.sp,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _showAvatarView(context, ImageProvider image) {
    // showDialog(
    //     barrierColor: Colors.black,
    //     context: context,
    //     builder: (context) {
    //       return PhotoViewPage(imageProvider: image, heroTag: '');
    //     });
  }
}
