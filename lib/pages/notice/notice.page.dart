import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:leekbox_infra/log/log.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../demo/all_icons.dart';

/// 页面
class NoticePage extends ConsumerStatefulWidget {
  const NoticePage({super.key});

  static String get routeName => 'notice';

  static String get routeLocation => '/$routeName';

  @override
  _NoticePageState createState() => _NoticePageState();
}

class _NoticePageState extends ConsumerState<NoticePage>
    with AutomaticKeepAliveClientMixin {
  dynamic _icons;
  late List<String> _iconsNames;
  String _title = 'Icons Catalog - Regular';

  @override
  void initState() {
    _icons = AllIcons.regularIcons.values.toList();
    _iconsNames = AllIcons.regularIcons.keys.toList();
    super.initState();
    Log.debug('NoticePage initState...');
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    super.dispose();
  }

  _mySliverChildBuilderDelegate() {
    return SliverChildBuilderDelegate(
      (BuildContext context, int index) {
        return Padding(
          padding: const EdgeInsets.all(0.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (_icons is List<PhosphorIconData>)
                Icon(
                  _icons[index],
                  size: 26,
                )
              else
                _icons[index],
              Text(
                _iconsNames[index],
                textAlign: TextAlign.center,
                textScaleFactor: 0.8,
                style: Theme.of(context).textTheme.labelSmall,
              ),
            ],
          ),
        );
      },
      childCount: _icons.length,
    );
  }

  _mySliverGridDelegateWithFixedCrossAxisCount() {
    return SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisCount: 5,
      mainAxisSpacing: 20,
      crossAxisSpacing: 0,
      childAspectRatio: 1.5,
    );
  }

  _mySliverGridDelegateWithMaxCrossAxisExtent() {
    return SliverGridDelegateWithMaxCrossAxisExtent(
      maxCrossAxisExtent: 200,
      mainAxisSpacing: 10,
      crossAxisSpacing: 5,
      childAspectRatio: 1,
    );
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    Log.debug('NoticePage build');
    final themeData = Theme.of(context);
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: false,
            floating: true,
            snap: true,
            title: Text('$_title'),
            automaticallyImplyLeading: false,
            centerTitle: false,
            actions: [
              PopupMenuButton<String>(
                tooltip: 'Style',
                icon: Icon(PhosphorIcons.pencilLine),
                itemBuilder: (context) {
                  return {
                    'Thin',
                    'Light',
                    'Regular',
                    'Bold',
                    'Fill',
                  }.map((style) {
                    var icon;

                    switch (style) {
                      case 'Regular':
                        icon = PhosphorIcons.pencilLine;
                        break;
                      case 'Bold':
                        icon = PhosphorIcons.pencilLineBold;
                        break;
                      case 'Fill':
                        icon = PhosphorIcons.pencilLineFill;
                        break;
                      case 'Light':
                        icon = PhosphorIcons.pencilLineLight;
                        break;
                      case 'Thin':
                        icon = PhosphorIcons.pencilLineThin;
                        break;
                      default:
                        break;
                    }

                    return PopupMenuItem<String>(
                      child: Row(
                        children: [
                          Icon(
                            icon,
                            color: Colors.black,
                          ),
                          SizedBox(
                            width: 8,
                          ),
                          Text(style),
                        ],
                      ),
                      value: style,
                    );
                  }).toList();
                },
                onSelected: (value) {
                  var icons;
                  var iconsNames;

                  switch (value) {
                    case 'Bold':
                      icons = AllIcons.boldIcons.values.toList();
                      iconsNames = AllIcons.boldIcons.keys.toList();
                      break;
                    case 'Fill':
                      icons = AllIcons.fillIcons.values.toList();
                      iconsNames = AllIcons.fillIcons.keys.toList();
                      break;
                    case 'Light':
                      icons = AllIcons.lightIcons.values.toList();
                      iconsNames = AllIcons.lightIcons.keys.toList();
                      break;
                    case 'Thin':
                      icons = AllIcons.thinIcons.values.toList();
                      iconsNames = AllIcons.thinIcons.keys.toList();
                      break;
                    case 'Regular':
                    default:
                      icons = AllIcons.regularIcons.values.toList();
                      iconsNames = AllIcons.regularIcons.keys.toList();
                      break;
                  }

                  setState(() {
                    _icons = icons;
                    _iconsNames = iconsNames;
                    _title = 'Icons Catalog - $value';
                  });
                },
              ),
            ],
          ),
          SliverGrid(
            delegate: _mySliverChildBuilderDelegate(),
            gridDelegate: _mySliverGridDelegateWithFixedCrossAxisCount(),
            // gridDelegate: _mySliverGridDelegateWithMaxCrossAxisExtent(),
          ),
        ],
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
