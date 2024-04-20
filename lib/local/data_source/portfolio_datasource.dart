import 'package:ints/base/local/base_data_source.dart';
import 'package:ints/models/portfolio.dart';
import 'package:ints/x_utils/utilities.dart';
import 'package:sembast/sembast.dart';

class PortfolioDataSource extends BaseDataSource<Portfolio> with Utilities {
  @override
  String storeName = "portfolioStore";

  @override
  Future<List<Portfolio>> getAll() async {
    List<Portfolio> list = [];
    try {
      var snapshots = await this.getAllFromDb();
      if (snapshots.length > 0) {
        list = snapshots.map((snapshot) {
          final model = Portfolio.fromJson(snapshot.value);
          return model;
        }).toList();
      }
    } catch (e) {
      logWhenDebug("getAll", e.toString());
    }

    return list;
  }

  Future<List<Portfolio>> searchById(String id) async {
    final finder = Finder(filter: Filter.equals("id", id));
    var snapshots = await this.search(finder);
    var list;
    if (snapshots.length > 0) {
      list = snapshots.map((snapshot) {
        final model = Portfolio.fromJson(snapshot.value);
        return model;
      }).toList();
    }
    return list;
  }

  @override
  Future<int> insert(Portfolio recordModel) async {
    return await this.insertRecord(recordModel.toJson());
  }

  @override
  Future<int> update(Portfolio model) {
    final finder = Finder(filter: Filter.equals("id", model.id));
    return this.updateRecord(model.toJson(), finder);
  }

  @override
  Future<int> delete(Portfolio model) {
    final finder = Finder(filter: Filter.equals("id", model.id));
    return this.deleteRecord(finder);
  }
}
