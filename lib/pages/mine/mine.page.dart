import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:leekbox/common/utils/image_utils.dart';
import 'package:leekbox/common/widgets/gaps.dart';
import 'package:leekbox/common/widgets/my_set_cell.dart';
import 'package:leekbox/common/widgets/photoview.dart';
import 'package:leekbox/pages/setting/setting.page.dart';
import 'package:leekbox_infra/log/log.dart';

import 'card_package.page.dart';
import 'moneybags.page.dart';
import 'user_profile.page.dart';
import 'vip_intro.page.dart';

///
class MinePage extends ConsumerStatefulWidget {
  const MinePage({super.key});

  @override
  _MinePageState createState() => _MinePageState();
}

class _MinePageState extends ConsumerState<MinePage>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    Log.debug('MinePage initState...');
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    Log.debug('MinePage build...');

    final themeData = Theme.of(context);
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          const SliverAppBar(
            automaticallyImplyLeading: false,
            centerTitle: false,
          ),
          SliverToBoxAdapter(
            child: _buildCard(),
          ),
          SliverToBoxAdapter(
            child: getBody(context),
          ),
        ],
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
          MySetCell(
            title: '荷包',
            leftImgPath: 'assets/images/mine/ic_moneybags.png',
            clickCallBack: () => context.push(MoneybagsPage.routeLocation),
          ),
          Gaps.vGap4,
          MySetCell(
            title: '会员',
            leftImgPath: 'assets/images/mine/ic_vip_gold.png',
            clickCallBack: () => context.push(VipIntroPage.routeLocation),
          ),
          MySetCell(
            title: '卡包',
            leftImgPath: 'assets/images/mine/ic_cards_wallet.png',
            clickCallBack: () => context.push(CardPackagePage.routeLocation),
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
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(20, 0, 10, 25),
      child: GestureDetector(
        onTap: () => {context.push(UserProfilePage.routeLocation)},
        child: SizedBox(
          width: double.infinity,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              Column(
                children: <Widget>[
                  GestureDetector(
                    onTap: () => {
                      _showAvatarView(
                          context, ImageUtils.getAssetImage('common/def_avatar'))
                    },
                    child: SizedBox(
                      width: 55.w,
                      height: 55.w,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.asset(
                          ImageUtils.getImgPath('common/def_avatar'),
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
                            fontSize: 16.0,
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
                            fontSize: 11.0,
                          ),
                        ),
                        Expanded(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: <Widget>[
                              InkWell(
                                onTap: () => {
                                  context.push(UserProfilePage.routeLocation)
                                },
                                child: const Icon(
                                  Icons.qr_code,
                                  size: 14,
                                  color: Color(0xFF828282),
                                ),
                              ),
                              Gaps.hGap15,
                              InkWell(
                                onTap: () => {
                                  context.push(UserProfilePage.routeLocation)
                                },
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
                            fontSize: 10.0,
                          ),
                        ),
                        Gaps.hGap15,
                        Text(
                          'IP属地:',
                          style: TextStyle(
                            color: const Color(0xFF828282),
                            fontSize: 10.0,
                          ),
                        ),
                        Gaps.hGap5,
                        Text(
                          '中国 北京 北京市',
                          style: TextStyle(
                            color: const Color(0xFF828282),
                            fontSize: 10.0,
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
    showDialog(
      barrierColor: Colors.black,
      context: context,
      builder: (context) {
        return PhotoViewPage(imageProvider: image, heroTag: '');
      },
    );
  }
}
