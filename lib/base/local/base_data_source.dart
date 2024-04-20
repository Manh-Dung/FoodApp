import 'dart:async';

import 'package:ints/x_utils/file_utils.dart';
import 'package:path/path.dart';
import 'package:sembast/sembast.dart';
import 'package:sembast/sembast_io.dart';

abstract class BaseDataSource<T> {
  late Future<Database> db;
  abstract String storeName;
  String dbName = "local.db";
  late StoreRef<int, Map<String, dynamic>> store;

  BaseDataSource() {
    db = _init();
  }

  // database instance
  Future<Database> _init() async {
    // A Store with int keys and Map<String, dynamic> values.
    // This Store acts like a persistent map, values of which are Flogs objects converted to Map
    store = intMapStoreFactory.store(storeName);

    String localPath = await FileUtils.localPath;

    // Path with the form: /platform-specific-directory/demo.db
    final dbPath = join(localPath, dbName);

    // Check to see if encryption is set, then provide codec
    // else init normal db with path
    var database = await databaseFactoryIo.openDatabase(dbPath);

    // 空のレコードを削除する
    // await clearEmptyRecord(database);

    // Return database instance
    return database;
  }

  // DB functions:--------------------------------------------------------------
  Future<int> insert(T recordModel);
  Future<int> update(T recordModel);
  Future<int> delete(T recordModel);
  Future<List<T>> getAll();

  Future<int> insertRecord(Map<String, dynamic> recordModel) async {
    return await store.add(await db, recordModel);
  }

  Future<int> count() async {
    return await store.count(await db);
  }

  FutureOr<List<RecordSnapshot<int, Map<String, dynamic>>>>
      getAllFromDb() async {
    print('Loading from database');

    // class list
    var recordList;

    // fetching data
    final recordSnapshots = await store.find(
      await db,
    );

    // Making a List<Post> out of List<RecordSnapshot>
    if (recordSnapshots.length > 0) {
      recordList = recordSnapshots;
    }

    return recordList;
  }

  FutureOr<List<RecordSnapshot<int, Map<String, dynamic>>>> search(
      Finder finder) async {
    print('Search from database');

    var records = (await (store.find(await db, finder: finder)
        as FutureOr<List<RecordSnapshot<int, Map<String, Object>>>>));

    return records;
  }

  Future<int> updateRecord(
      Map<String, dynamic> recordModel, Finder finder) async {
    return await store.update(
      await db,
      recordModel,
      finder: finder,
    );
  }

  Future<int> deleteRecord(Finder finder) async {
    return await store.delete(
      await db,
      finder: finder,
    );
  }

  Future deleteAll() async {
    await store.drop(
      await db,
    );
  }
}
