//{
//   "data": [T],
//   "total": 10,
//   "currentPage": 1,
//   "itemsPerPage": 10
// }

class APIResponsePaging<T> {
  APIResponsePaging({
    T? data,
    num? total,
    num? itemsPerPage,
    num? currentPage,
  }) {
    _data = data;
    _total = total;
    _itemsPerPage = itemsPerPage;
    _currentPage = currentPage;
  }

  APIResponsePaging.fromJson(dynamic json, T Function(dynamic json) fromJsonT) {
    if (json['data'] != null) {
      _data = fromJsonT(json['data']);
    }
    _total = json['total'];
    _itemsPerPage = json['itemsPerPage'];
    _currentPage = json['currentPage'];
  }

  APIResponsePaging.fromList(dynamic json, T Function(List<dynamic>? json) fromJsonT) {
    if (json['data'] != null) {
      _data = fromJsonT(json['data']);
    }
    _total = json['total'];
    _itemsPerPage = json['itemsPerPage'];
    _currentPage = json['currentPage'];
  }

  T? _data;
  num? _total;
  num? _itemsPerPage;
  num? _currentPage;

  T? get data => _data;

  num? get total => _total;

  num? get itemsPerPage => _itemsPerPage;

  num? get currentPage => _currentPage;

  Map<String, dynamic> toJson(Object? Function(T value) toJsonT) {
    final map = <String, dynamic>{};
    if (_data != null) {
      map['data'] = toJsonT(_data!);
    }
    map['total'] = _total;
    map['itemsPerPage'] = _itemsPerPage;
    map['currentPage'] = _currentPage;
    return map;
  }

  static List<T> fromLJsonListT<T>(json, T Function(Object? json) fromJsonT) {
    return (json as List<dynamic>).map<T>((i) => fromJsonT(i)).toList();
  }
}
