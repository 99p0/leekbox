import 'package:blurhash_dart/blurhash_dart.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image/image.dart' as img;
import 'package:leekbox/pages/home/widgets/one_day_normal_view.dart';
import 'package:leekbox_infra/log/log.dart';
import 'package:oktoast/oktoast.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

///
class IndexPage extends StatefulWidget {
  @override
  _IndexPageState createState() => _IndexPageState();
}

class _IndexPageState extends State<IndexPage>
    with AutomaticKeepAliveClientMixin, TickerProviderStateMixin {
  @override
  bool get wantKeepAlive => true;

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

  List<HomeList> homeList = HomeList.homeList;
  late AnimationController animationController;
  bool multiple = true;

  @override
  void initState() {
    animationController = AnimationController(
        duration: const Duration(milliseconds: 800), vsync: this);
    animationController?.forward(); //
    super.initState();
  }

  Future<bool> getData() async {
    await Future<dynamic>.delayed(const Duration(milliseconds: 0));
    return true;
  }

  List<Employee> employees = <Employee>[];
  late EmployeeDataSource employeeDataSource;

  Future<bool> getEmployeesData() async {
    await Future<dynamic>.delayed(const Duration(milliseconds: 0));
    employees = getEmployeeData();
    employeeDataSource = EmployeeDataSource(employeeData: employees);
    return true;
  }

  @override
  void dispose() {
    animationController?.dispose();
    super.dispose();
  }

  final columnWidth = {
    'nation': double.nan,
    'population': double.nan,
    'continent': double.nan,
    'desc': double.nan
  };

  @override
  Widget build(BuildContext context) {
    super.build(context);
    Log.debug('IndexPage build');

    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          // appBar(),

          /// 问候语
          FutureBuilder<bool>(
              future: getData(),
              builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
                if (!snapshot.hasData) {
                  return const SizedBox();
                } else {
                  animationController?.forward();
                  return TimeAndWordView(
                    animation:
                        Tween<Offset>(begin: Offset(0, 1), end: Offset.zero)
                            .animate(
                      CurvedAnimation(
                        parent: animationController,
                        curve: Interval(0.1, 1, curve: Curves.fastOutSlowIn),
                      ),
                    ),
                    animationController: animationController,
                  );
                }
              }),

          /// 表格
          // Expanded(
          //   flex: 6,
          //   child: FutureBuilder<bool>(
          //     future: getEmployeesData(),
          //     builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
          //       if (!snapshot.hasData) {
          //         return const SizedBox();
          //       } else {
          //         return SfDataGrid(
          //           columnWidthMode: ColumnWidthMode.fill,
          //           headerRowHeight: 50.0,
          //           frozenColumnsCount: 1,
          //           gridLinesVisibility: GridLinesVisibility.both,
          //           headerGridLinesVisibility: GridLinesVisibility.both,
          //           selectionMode: SelectionMode.multiple,
          //           columnResizeMode: ColumnResizeMode.onResize,
          //           allowColumnsResizing: true,
          //           onColumnResizeUpdate: (detail) {
          //             setState(() {
          //               columnWidth[detail.column.columnName] = detail.width;
          //             });
          //             return true;
          //           },
          //           source: employeeDataSource,
          //           columns: <GridColumn>[
          //             GridColumn(
          //                 columnName: 'id',
          //                 label: Container(
          //                     color: Colors.blue[200],
          //                     padding: EdgeInsets.all(16.0),
          //                     alignment: Alignment.center,
          //                     child: Text('ID'))),
          //             GridColumn(
          //                 columnName: 'name',
          //                 label: Container(
          //                     color: Colors.blue[300],
          //                     padding: EdgeInsets.all(8.0),
          //                     alignment: Alignment.center,
          //                     child: Text('Name'))),
          //             GridColumn(
          //                 columnName: 'designation',
          //                 label: Container(
          //                     color: Colors.blue[400],
          //                     padding: EdgeInsets.all(8.0),
          //                     alignment: Alignment.center,
          //                     child: Text(
          //                       'Designation',
          //                       overflow: TextOverflow.ellipsis,
          //                     ))),
          //             GridColumn(
          //                 columnName: 'salary',
          //                 label: Container(
          //                     color: Colors.blue[500],
          //                     padding: EdgeInsets.all(8.0),
          //                     alignment: Alignment.center,
          //                     child: Text('Salary'))),
          //           ],
          //         );
          //       }
          //     },
          //   ),
          // ),

          /// 推荐
          Expanded(
            child: FutureBuilder<bool>(
              future: getData(),
              builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
                if (!snapshot.hasData) {
                  return const SizedBox();
                } else {
                  return GridView(
                    padding: const EdgeInsets.only(top: 0, left: 12, right: 12),
                    physics: const BouncingScrollPhysics(),
                    scrollDirection: Axis.vertical,
                    children: List<Widget>.generate(
                      homeList.length,
                      (int index) {
                        final int count = homeList.length;
                        final Animation<double> animation =
                            Tween<double>(begin: 0.0, end: 1.0).animate(
                          CurvedAnimation(
                            parent: animationController!,
                            curve: Interval((1 / count) * index, 1.0,
                                curve: Curves.fastOutSlowIn),
                          ),
                        );
                        animationController?.forward();
                        return HomeListView(
                          animation: animation,
                          animationController: animationController,
                          listData: homeList[index],
                          callBack: () {
                            showToast('${homeList[index].imagePath}');
                          },
                        );
                      },
                    ),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: multiple ? 4 : 1,
                      mainAxisSpacing: 12.0,
                      crossAxisSpacing: 12.0,
                      childAspectRatio: 1.5,
                    ),
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget appBar() {
    return Container(
      height: AppBar().preferredSize.height,
      //边框设置
      decoration: BoxDecoration(
        color: Colors.redAccent,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(25.0),
          bottomRight: Radius.circular(25.0),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top: 8, left: 8),
            child: Container(
              width: AppBar().preferredSize.height - 8,
              height: AppBar().preferredSize.height - 8,
            ),
          ),
          Expanded(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.only(top: 4),
                child: Text(
                  'LEEKBOX',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 8, right: 8),
            child: Container(
              width: AppBar().preferredSize.height - 38,
              height: AppBar().preferredSize.height - 38,
              color: Colors.white,
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  borderRadius:
                      BorderRadius.circular(AppBar().preferredSize.height),
                  child: Icon(
                    multiple ? Icons.dashboard : Icons.view_agenda,
                    color: Colors.grey,
                  ),
                  onTap: () {
                    setState(() {
                      multiple = !multiple;
                    });
                  },
                ),
              ),
            ),
          ),
        ],
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

  List<Employee> getEmployeeData() {
    return [
      Employee(10001, 'James', 'Project Lead', 20000),
      Employee(10002, 'Kathryn', 'Manager', 30000),
      Employee(10003, 'Lara', 'Developer', 15000),
      Employee(10004, 'Michael', 'Designer', 15000),
      Employee(10005, 'Martin', 'Developer', 15000),
      Employee(10006, 'Newberry', 'Developer', 15000),
      Employee(10007, 'Balnc', 'Developer', 15000),
      Employee(10008, 'Perry', 'Developer', 15000),
      Employee(10009, 'Gable', 'Developer', 15000),
      Employee(10001, 'James', 'Project Lead', 20000),
      Employee(10002, 'Kathryn', 'Manager', 30000),
      Employee(10003, 'Lara', 'Developer', 15000),
      Employee(10004, 'Michael', 'Designer', 15000),
      Employee(10005, 'Martin', 'Developer', 15000),
      Employee(10006, 'Newberry', 'Developer', 15000),
      Employee(10007, 'Balnc', 'Developer', 15000),
      Employee(10008, 'Perry', 'Developer', 15000),
      Employee(10009, 'Gable', 'Developer', 15000),
      Employee(10001, 'James', 'Project Lead', 20000),
      Employee(10002, 'Kathryn', 'Manager', 30000),
      Employee(10003, 'Lara', 'Developer', 15000),
      Employee(10004, 'Michael', 'Designer', 15000),
      Employee(10005, 'Martin', 'Developer', 15000),
      Employee(10006, 'Newberry', 'Developer', 15000),
      Employee(10007, 'Balnc', 'Developer', 15000),
      Employee(10008, 'Perry', 'Developer', 15000),
      Employee(10009, 'Gable', 'Developer', 15000),
      Employee(10010, 'Grimes', 'Developer', 15000)
    ];
  }
}

class HomeListView extends StatelessWidget {
  const HomeListView(
      {Key? key,
      this.listData,
      this.callBack,
      this.animationController,
      this.animation})
      : super(key: key);

  final HomeList? listData;
  final VoidCallback? callBack;
  final AnimationController? animationController;
  final Animation<double>? animation;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animationController!,
      builder: (BuildContext context, Widget? child) {
        return FadeTransition(
          opacity: animation!,
          child: Transform(
            transform: Matrix4.translationValues(
                0.0, 50 * (1.0 - animation!.value), 0.0),
            child: AspectRatio(
              aspectRatio: 1.5,
              child: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(4.0)),
                child: Stack(
                  alignment: AlignmentDirectional.center,
                  children: <Widget>[
                    Positioned.fill(
                      child: SvgPicture.asset(
                        listData!.imagePath,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Material(
                      color: Colors.transparent,
                      child: InkWell(
                        splashColor: Colors.grey.withOpacity(0.2),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(4.0)),
                        onTap: callBack,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class HomeList {
  HomeList({
    this.navigateScreen = '',
    this.imagePath = '',
  });

  String navigateScreen;
  String imagePath;

  static List<HomeList> homeList = [
    HomeList(
      imagePath: 'assets/images/fitness-svgrepo-com.svg',
      navigateScreen: "1",
    ),
    HomeList(
      imagePath: 'assets/images/fitness-svgrepo-com.svg',
      navigateScreen: "2",
    ),
    HomeList(
      imagePath: 'assets/images/fitness-svgrepo-com.svg',
      navigateScreen: "3",
    ),
    HomeList(
      imagePath: 'assets/images/fitness-svgrepo-com.svg',
      navigateScreen: "4",
    ),
  ];
}

/// Custom business object class which contains properties to hold the detailed
/// information about the employee which will be rendered in datagrid.
class Employee {
  /// Creates the employee class with required details.
  Employee(this.id, this.name, this.designation, this.salary);

  /// Id of an employee.
  final int id;

  /// Name of an employee.
  final String name;

  /// Designation of an employee.
  final String designation;

  /// Salary of an employee.
  final int salary;
}

/// An object to set the employee collection data source to the datagrid. This
/// is used to map the employee data to the datagrid widget.
class EmployeeDataSource extends DataGridSource {
  /// Creates the employee data source class with required details.
  EmployeeDataSource({required List<Employee> employeeData}) {
    _employeeData = employeeData
        .map<DataGridRow>((e) => DataGridRow(cells: [
              DataGridCell<int>(columnName: 'id', value: e.id),
              DataGridCell<String>(columnName: 'name', value: e.name),
              DataGridCell<String>(
                  columnName: 'designation', value: e.designation),
              DataGridCell<int>(columnName: 'salary', value: e.salary),
            ]))
        .toList();
  }

  List<DataGridRow> _employeeData = [];

  @override
  List<DataGridRow> get rows => _employeeData;

  @override
  DataGridRowAdapter buildRow(DataGridRow row) {
    return DataGridRowAdapter(
        cells: row.getCells().map<Widget>((e) {
      return Container(
        alignment: Alignment.center,
        padding: EdgeInsets.all(8.0),
        child: Text(e.value.toString()),
      );
    }).toList());
  }
}
