import 'package:ints/base/local/base_data_source.dart';
import 'package:ints/models/trading_transaction.dart';
import 'package:sembast/sembast.dart';

class DriveFileDataSource extends BaseDataSource<TradingTransaction> {
  @override
  String storeName = "transactionStore";

  @override
  Future<List<TradingTransaction>> getAll() async {
    List<TradingTransaction> list = [];
    var snapshots = await this.getAllFromDb();
    if (snapshots.length > 0) {
      list = snapshots.map((snapshot) {
        final model = TradingTransaction.fromJson(snapshot.value);
        return model;
      }).toList();
    }
    return list;
  }

  Future<List<TradingTransaction>> getAllByPortfolio(String id) async {
    final finder = Finder(filter: Filter.equals("portfolioID", id));
    var snapshots = await this.search(finder);
    var list;
    if (snapshots.length > 0) {
      list = snapshots.map((snapshot) {
        final model = TradingTransaction.fromJson(snapshot.value);
        return model;
      }).toList();
    }
    return list;
  }

  Future<List<TradingTransaction>> searchById(String id) async {
    final finder = Finder(filter: Filter.equals("id", id));
    var snapshots = await this.search(finder);
    var list;
    if (snapshots.length > 0) {
      list = snapshots.map((snapshot) {
        final model = TradingTransaction.fromJson(snapshot.value);
        return model;
      }).toList();
    }
    return list;
  }

  @override
  Future<int> insert(TradingTransaction recordModel) async {
    return await this.insertRecord(recordModel.toJson());
  }

  @override
  Future<int> update(TradingTransaction model) {
    final finder = Finder(filter: Filter.equals("id", model.id));
    return this.updateRecord(model.toJson(), finder);
  }

  @override
  Future<int> delete(TradingTransaction model) {
    final finder = Finder(filter: Filter.equals("id", model.id));
    return this.deleteRecord(finder);
  }
}
