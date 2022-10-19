import 'package:pull_to_refresh/pull_to_refresh.dart';

enum RefreshType { refresh, loadMore }

class PagingData<T> {
  int count;
  List<T> items;
  int current = 1;

  PagingData(this.count, this.items);

  factory PagingData.fromJson(
      Map<String, dynamic> json, T Function(Map<String, dynamic>) decoder) {
    final count = json['count'];
    final items =
        (json['results'] as List<dynamic>).map((e) => decoder(e)).toList();
    return PagingData(count, items);
  }

  @override
  String toString() => '分页: $count';

  bool get isEnd => items.length >= count;

  void merge(PagingData<T> other, RefreshType refreshType) {
    if (refreshType == RefreshType.refresh) items.clear();
    count = other.count;
    items.addAll(other.items);
  }

  void prepare(RefreshType refreshType) =>
      current = refreshType == RefreshType.refresh ? 1 : (current + 1);
}

mixin RefreshMixin<T> {
  final refreshController = RefreshController(initialRefresh: true);

  List<T> get items => paging.items;
  final PagingData<T> paging = PagingData(0, []);

  Future<PagingData> startRefresh(RefreshType refreshType) {
    paging.prepare(refreshType);
    return refreshRequest.then((value) {
      paging.merge(value, refreshType);
      if (refreshType == RefreshType.refresh) {
        refreshController.refreshCompleted(resetFooterState: true);
        if (paging.isEnd) refreshController.loadNoData();
      } else {
        paging.isEnd
            ? refreshController.loadNoData()
            : refreshController.loadComplete();
      }
      return paging;
    });
  }

  Future<PagingData<T>> get refreshRequest =>
      throw UnimplementedError('子类必须重写');
}
