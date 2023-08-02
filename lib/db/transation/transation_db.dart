
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'package:moneymanagment_app_1/models/transations/transation_model.dart';

const TRANSATION_DB_NAME = 'tansaction-db';

abstract class TransationDbFunction {
  Future<void> addtranstion(transationModel obj);
  Future<List<transationModel>> getalltransation();
  Future<void> deleteTransation(String id);
}

class transationDB implements TransationDbFunction {
  transationDB._internal();

  static transationDB instance = transationDB._internal();

  factory transationDB() {
    return instance;
  }

  ValueNotifier<List<transationModel>> transationlistnotifier =
      ValueNotifier([]);

  @override
  Future<void> addtranstion(transationModel obj) async {
    final _db = await Hive.openBox<transationModel>(TRANSATION_DB_NAME);
    await _db.put(obj.id, obj);
  }

  Future<void> refresh() async {
    final _list = await getalltransation();
    transationlistnotifier.value.clear();
    _list.sort((first, secont) => secont.date.compareTo(first.date));
    transationlistnotifier.value.addAll(_list);
    transationlistnotifier.notifyListeners();
  }

  @override
  Future<List<transationModel>> getalltransation() async {
    final _db = await Hive.openBox<transationModel>(TRANSATION_DB_NAME);
    return _db.values.toList();
  }

  @override
  Future<void> deleteTransation(String id) async {
    final _db = await Hive.openBox<transationModel>(TRANSATION_DB_NAME);
    _db.delete(id);
    refresh();
  }
}
