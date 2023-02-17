import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

///
class UserProfilePage extends StatefulWidget {
  const UserProfilePage({Key? key}) : super(key: key);

  static String get routeName => 'mine/user_profile';

  static String get routeLocation => '/$routeName';

  @override
  State<UserProfilePage> createState() => _UserProfilePageState();
}

class _UserProfilePageState extends State<UserProfilePage> {
  static const _expandedHeight = 40.0;

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            backgroundColor: themeData.colorScheme.primary,
            foregroundColor: themeData.colorScheme.onPrimary,
            expandedHeight: _expandedHeight,
            pinned: true,
            leading: BackButton(
              color: themeData.colorScheme.onPrimary,
            ),
            title: Text(
              '个人信息',
              style: TextStyle(color: themeData.colorScheme.onPrimary),
            ),
          ),
          SliverToBoxAdapter(
            child: Card(
              elevation: 0,
              margin: const EdgeInsets.only(top: 16, left: 16, right: 16),
              color: themeData.colorScheme.primaryContainer,
              clipBehavior: Clip.antiAlias,
              child: Column(
                children: [
                  ListTile(
                    leading: const Icon(Icons.supervised_user_circle),
                    title: Text('QQ group'),
                    subtitle: const Text('554981921'),
                    onTap: () {
                      launchUrl(
                        Uri.parse(
                            'mqqopensdkapi://bizAgent/qm/qr?url=http%3A%2F%2Fqm.qq.com%2Fcgi-bin%2Fqm%2Fqr%3Ffrom%3Dapp%26p%3Dandroid%26k%3DMNLtkvnn4n28UIB0gEgm2-WBmqmGWk0Q'),
                      );
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.language),
                    title: const Text('Github'),
                    subtitle: const Text('https://github.com/xuelongqy'),
                    onTap: () {
                      launchUrl(Uri.parse('https://github.com/xuelongqy'));
                    },
                  ),
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Card(
              elevation: 0,
              margin: const EdgeInsets.only(top: 16, left: 16, right: 16),
              color: themeData.colorScheme.secondaryContainer,
              clipBehavior: Clip.antiAlias,
              child: Column(
                children: [
                  ListTile(
                    leading: const Icon(Icons.person),
                    title: Text('Name'),
                    subtitle: const Text('Codiss'),
                  ),
                  ListTile(
                    leading: const Icon(Icons.face),
                    title: Text('Age'),
                    subtitle: Text('Not yet bald'),
                  ),
                  ListTile(
                    leading: const Icon(Icons.location_city),
                    title: Text('City'),
                    subtitle: Text('China - ChengDu'),
                  ),
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Card(
              elevation: 0,
              margin: const EdgeInsets.only(top: 16, left: 16, right: 16),
              color: themeData.colorScheme.tertiaryContainer,
              clipBehavior: Clip.antiAlias,
              child: Column(
                children: [
                  ListTile(
                    leading: const Icon(Icons.phone),
                    title: Text('Phone'),
                    subtitle: const Text('188888888888'),
                  ),
                  ListTile(
                    leading: const Icon(Icons.mail),
                    title: Text('Mail'),
                    subtitle: const Text('xuelongqy@qq.com'),
                    onTap: () {
                      launchUrl(Uri.parse(
                          'mailto:xuelongqy@foxmail.com?subject=EasyRefresh&body=I found a bug'));
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _TrapezoidClipper extends CustomClipper<Path> {
  final double height;
  final double clipStartHeight;
  final double clipEndHeight;

  _TrapezoidClipper({
    required this.height,
    required this.clipStartHeight,
    required this.clipEndHeight,
  });

  @override
  Path getClip(Size size) {
    final width = size.width;
    final height = size.height;
    Path path = Path();
    path.moveTo(0, 0);
    path.lineTo(width, 0);
    path.lineTo(width, height - clipEndHeight);
    path.lineTo(0, height - clipStartHeight);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(_TrapezoidClipper oldClipper) {
    return oldClipper.height != height ||
        oldClipper.clipStartHeight != clipStartHeight ||
        oldClipper.clipEndHeight != clipEndHeight;
  }
}

class _FillLineClipper extends CustomClipper<Path> {
  final double imgHeight;

  _FillLineClipper(this.imgHeight);

  @override
  Path getClip(Size size) {
    final width = size.width;
    final height = size.height;
    Path path = Path();
    path.moveTo(0, 0);
    path.lineTo(width, 0);
    path.lineTo(width, height / 2);
    path.lineTo(0, height / 2 + imgHeight / 2);
    path.lineTo(0, height);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant _FillLineClipper oldClipper) {
    return oldClipper.imgHeight != imgHeight;
  }
}
