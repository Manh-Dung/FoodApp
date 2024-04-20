/// id : 2695
/// name : "228043"
/// creatorUserName : "Nguyen Hung"
/// description : ""
/// totalCount : 2
/// investmentValue : 5043.024797913
/// currentValue : 5647
/// plToday : -62
/// accumulatedPLToday_Percent : -0.012294208829918506
/// accumulatedPL : 603.975202087
/// accumulatedPL_Percent : 0.11976447197660985
/// isOwner : true
/// lastModificationTime : "2021-06-09T10:52:28.2810584"

class Portfolio {
  int? _id;
  String? _name;
  String? _creatorUserName;
  String? _description;
  int? _totalCount;
  double? _investmentValue;
  int? _currentValue;
  int? _plToday;
  double? _accumulatedPLTodayPercent;
  double? _accumulatedPL;
  double? _accumulatedPLPercent;
  bool? _isOwner;
  String? _lastModificationTime;

  int? get id => _id;
  String? get name => _name;
  String? get creatorUserName => _creatorUserName;
  String? get description => _description;
  int? get totalCount => _totalCount;
  double? get investmentValue => _investmentValue;
  int? get currentValue => _currentValue;
  int? get plToday => _plToday;
  double? get accumulatedPLTodayPercent => _accumulatedPLTodayPercent;
  double? get accumulatedPL => _accumulatedPL;
  double? get accumulatedPLPercent => _accumulatedPLPercent;
  bool? get isOwner => _isOwner;
  String? get lastModificationTime => _lastModificationTime;

  Portfolio(
      {int? id,
      String? name,
      String? creatorUserName,
      String? description,
      int? totalCount,
      double? investmentValue,
      int? currentValue,
      int? plToday,
      double? accumulatedPLTodayPercent,
      double? accumulatedPL,
      double? accumulatedPLPercent,
      bool? isOwner,
      String? lastModificationTime}) {
    _id = id;
    _name = name;
    _creatorUserName = creatorUserName;
    _description = description;
    _totalCount = totalCount;
    _investmentValue = investmentValue;
    _currentValue = currentValue;
    _plToday = plToday;
    _accumulatedPLTodayPercent = accumulatedPLTodayPercent;
    _accumulatedPL = accumulatedPL;
    _accumulatedPLPercent = accumulatedPLPercent;
    _isOwner = isOwner;
    _lastModificationTime = lastModificationTime;
  }

  Portfolio.fromJson(dynamic json) {
    _id = json["id"];
    _name = json["name"];
    _creatorUserName = json["creatorUserName"];
    _description = json["description"];
    _totalCount = json["totalCount"];
    _investmentValue = json["investmentValue"];
    _currentValue = json["currentValue"];
    _plToday = json["plToday"];
    _accumulatedPLTodayPercent = json["accumulatedPLToday_Percent"];
    _accumulatedPL = json["accumulatedPL"];
    _accumulatedPLPercent = json["accumulatedPL_Percent"];
    _isOwner = json["isOwner"];
    _lastModificationTime = json["lastModificationTime"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["id"] = _id;
    map["name"] = _name;
    map["creatorUserName"] = _creatorUserName;
    map["description"] = _description;
    map["totalCount"] = _totalCount;
    map["investmentValue"] = _investmentValue;
    map["currentValue"] = _currentValue;
    map["plToday"] = _plToday;
    map["accumulatedPLToday_Percent"] = _accumulatedPLTodayPercent;
    map["accumulatedPL"] = _accumulatedPL;
    map["accumulatedPL_Percent"] = _accumulatedPLPercent;
    map["isOwner"] = _isOwner;
    map["lastModificationTime"] = _lastModificationTime;
    return map;
  }
}
