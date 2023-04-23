import 'package:bottom_blur_bar/bottom_blur_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:leekbox/common/widgets/my_app_bar.dart';

///
class ActivityDetailPage extends ConsumerStatefulWidget {
  const ActivityDetailPage({super.key});

  static String get routeName => 'activity/detail';

  static String get routeLocation => '/$routeName';

  @override
  _ActivityDetailPageState createState() => _ActivityDetailPageState();
}

class _ActivityDetailPageState extends ConsumerState<ActivityDetailPage> {
  int _idx = 0;

  @override
  Widget build(BuildContext context) {
    final color = MediaQuery.of(context).platformBrightness == Brightness.dark
        ? Colors.white
        : Colors.white;

    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      backgroundColor: Colors.white,
      extendBody: true,
      appBar: const MyAppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: 'bottom_blur_bar',
      ),
      body: ListView.builder(
          itemCount: 200,
          itemBuilder: (ctx, idx) {
            return Padding(
              padding: const EdgeInsets.all(10.0),
              child: Container(
                height: 200,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [Colors.deepPurple, Colors.pink.shade300])),
                child: Center(
                  // Center is a layout widget. It takes a single child and positions it
                  // in the middle of the parent.
                  child: Column(
                    // Column is also a layout widget. It takes a list of children and
                    // arranges them vertically. By default, it sizes itself to fit its
                    // children horizontally, and tries to be as tall as its parent.
                    //
                    // Invoke "debug painting" (press "p" in the console, choose the
                    // "Toggle Debug Paint" action from the Flutter Inspector in Android
                    // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
                    // to see the wireframe for each widget.
                    //
                    // Column has various properties to control how it sizes itself and
                    // how it positions its children. Here we use mainAxisAlignment to
                    // center the children vertically; the main axis here is the vertical
                    // axis because Columns are vertical (the cross axis would be
                    // horizontal).
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      const Text(
                        'Current Index:',
                      ),
                      Text(
                        '$_idx',
                        style: Theme.of(context).textTheme.headlineLarge,
                      ),
                    ],
                  ),
                ),
              ),
            );
          }),
      bottomNavigationBar: BlurNavbar(
        onTap: (idx) => setState(() {
          _idx = idx;
          debugPrint('$idx');
        }),
        items: [
          BlurNavbarItem(
            icon: Icon(Icons.home, color: color, size: 24),
            title: "HOME",
          ),
          BlurNavbarItem(
            icon: Icon(Icons.search, color: color, size: 24),
            title: "SEARCH",
          ),
          BlurNavbarItem(
            icon: Icon(Icons.notifications, color: color, size: 24),
            title: "NOTIFICATIONS",
          ),
          BlurNavbarItem(
            icon: Icon(Icons.local_library_rounded, color: color, size: 24),
            title: "LIBRARY",
          )
        ],
        currentIndex: _idx,
        selectedColor: Colors.cyanAccent,
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
