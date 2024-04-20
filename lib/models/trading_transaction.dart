/// id : 66324
/// portfolioID : 2695
/// symbol : "DRC"
/// tradingDate : "2021-07-20T00:00:00"
/// canDelete : true
/// actionType : "Bán"
/// volume : 1000
/// price : 28.5
/// transactionFeeRate : 0.13
/// incomeTaxRate : 0.001
/// dividendTaxRate : 0
/// sellValue : 28500
/// avgBuyPrice : 31.691145
/// avgTodayBuyPrice : 0
/// adjRatio : 0
/// stockDividend : 0
/// cashDividend : 0
/// transactionFee : 37.05
/// incomeTax : 28.5
/// dividendTax : 0
/// cashDividendAfterTax : 0
/// tradingValue : 28500
/// charge : 65.55
/// tradingValueAfterCharge : 28434.45
/// originalValue : 31691.145
/// pl : -3256.695

class TradingTransaction {
  int? _id;
  int? _portfolioID;
  String? _symbol;
  String? _tradingDate;
  bool? _canDelete;
  String? _actionType;
  int? _volume;
  double? _price;
  double? _transactionFeeRate;
  double? _incomeTaxRate;
  int? _dividendTaxRate;
  int? _sellValue;
  double? _avgBuyPrice;
  int? _avgTodayBuyPrice;
  int? _adjRatio;
  int? _stockDividend;
  int? _cashDividend;
  double? _transactionFee;
  double? _incomeTax;
  int? _dividendTax;
  int? _cashDividendAfterTax;
  int? _tradingValue;
  double? _charge;
  double? _tradingValueAfterCharge;
  double? _originalValue;
  double? _pl;

  int? get id => _id;
  int? get portfolioID => _portfolioID;
  String? get symbol => _symbol;
  String? get tradingDate => _tradingDate;
  bool? get canDelete => _canDelete;
  String? get actionType => _actionType;
  int? get volume => _volume;
  double? get price => _price;
  double? get transactionFeeRate => _transactionFeeRate;
  double? get incomeTaxRate => _incomeTaxRate;
  int? get dividendTaxRate => _dividendTaxRate;
  int? get sellValue => _sellValue;
  double? get avgBuyPrice => _avgBuyPrice;
  int? get avgTodayBuyPrice => _avgTodayBuyPrice;
  int? get adjRatio => _adjRatio;
  int? get stockDividend => _stockDividend;
  int? get cashDividend => _cashDividend;
  double? get transactionFee => _transactionFee;
  double? get incomeTax => _incomeTax;
  int? get dividendTax => _dividendTax;
  int? get cashDividendAfterTax => _cashDividendAfterTax;
  int? get tradingValue => _tradingValue;
  double? get charge => _charge;
  double? get tradingValueAfterCharge => _tradingValueAfterCharge;
  double? get originalValue => _originalValue;
  double? get pl => _pl;

  TradingTransaction(
      {int? id,
      int? portfolioID,
      String? symbol,
      String? tradingDate,
      bool? canDelete,
      String? actionType,
      int? volume,
      double? price,
      double? transactionFeeRate,
      double? incomeTaxRate,
      int? dividendTaxRate,
      int? sellValue,
      double? avgBuyPrice,
      int? avgTodayBuyPrice,
      int? adjRatio,
      int? stockDividend,
      int? cashDividend,
      double? transactionFee,
      double? incomeTax,
      int? dividendTax,
      int? cashDividendAfterTax,
      int? tradingValue,
      double? charge,
      double? tradingValueAfterCharge,
      double? originalValue,
      double? pl}) {
    _id = id;
    _portfolioID = portfolioID;
    _symbol = symbol;
    _tradingDate = tradingDate;
    _canDelete = canDelete;
    _actionType = actionType;
    _volume = volume;
    _price = price;
    _transactionFeeRate = transactionFeeRate;
    _incomeTaxRate = incomeTaxRate;
    _dividendTaxRate = dividendTaxRate;
    _sellValue = sellValue;
    _avgBuyPrice = avgBuyPrice;
    _avgTodayBuyPrice = avgTodayBuyPrice;
    _adjRatio = adjRatio;
    _stockDividend = stockDividend;
    _cashDividend = cashDividend;
    _transactionFee = transactionFee;
    _incomeTax = incomeTax;
    _dividendTax = dividendTax;
    _cashDividendAfterTax = cashDividendAfterTax;
    _tradingValue = tradingValue;
    _charge = charge;
    _tradingValueAfterCharge = tradingValueAfterCharge;
    _originalValue = originalValue;
    _pl = pl;
  }

  TradingTransaction.fromJson(dynamic json) {
    _id = json["id"];
    _portfolioID = json["portfolioID"];
    _symbol = json["symbol"];
    _tradingDate = json["tradingDate"];
    _canDelete = json["canDelete"];
    _actionType = json["actionType"];
    _volume = json["volume"];
    _price = json["price"];
    _transactionFeeRate = json["transactionFeeRate"];
    _incomeTaxRate = json["incomeTaxRate"];
    _dividendTaxRate = json["dividendTaxRate"];
    _sellValue = json["sellValue"];
    _avgBuyPrice = json["avgBuyPrice"];
    _avgTodayBuyPrice = json["avgTodayBuyPrice"];
    _adjRatio = json["adjRatio"];
    _stockDividend = json["stockDividend"];
    _cashDividend = json["cashDividend"];
    _transactionFee = json["transactionFee"];
    _incomeTax = json["incomeTax"];
    _dividendTax = json["dividendTax"];
    _cashDividendAfterTax = json["cashDividendAfterTax"];
    _tradingValue = json["tradingValue"];
    _charge = json["charge"];
    _tradingValueAfterCharge = json["tradingValueAfterCharge"];
    _originalValue = json["originalValue"];
    _pl = json["pl"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["id"] = _id;
    map["portfolioID"] = _portfolioID;
    map["symbol"] = _symbol;
    map["tradingDate"] = _tradingDate;
    map["canDelete"] = _canDelete;
    map["actionType"] = _actionType;
    map["volume"] = _volume;
    map["price"] = _price;
    map["transactionFeeRate"] = _transactionFeeRate;
    map["incomeTaxRate"] = _incomeTaxRate;
    map["dividendTaxRate"] = _dividendTaxRate;
    map["sellValue"] = _sellValue;
    map["avgBuyPrice"] = _avgBuyPrice;
    map["avgTodayBuyPrice"] = _avgTodayBuyPrice;
    map["adjRatio"] = _adjRatio;
    map["stockDividend"] = _stockDividend;
    map["cashDividend"] = _cashDividend;
    map["transactionFee"] = _transactionFee;
    map["incomeTax"] = _incomeTax;
    map["dividendTax"] = _dividendTax;
    map["cashDividendAfterTax"] = _cashDividendAfterTax;
    map["tradingValue"] = _tradingValue;
    map["charge"] = _charge;
    map["tradingValueAfterCharge"] = _tradingValueAfterCharge;
    map["originalValue"] = _originalValue;
    map["pl"] = _pl;
    return map;
  }
}
