import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:moneymanagment_app_1/models/category/category_model.dart';

const CATEGORY_DB_NAME = 'category-database';

abstract class CategoryDbFunction {
  Future<List<Categorymodel>> getCategories();
  Future<void> insertcategory(Categorymodel value);
  Future<void> deleteCategory(String categoryID);
}

class CategoryDB implements CategoryDbFunction {
  CategoryDB._intarnal();
  static CategoryDB instance = CategoryDB._intarnal();

  factory CategoryDB() {
    return instance;
  }

  ValueNotifier<List<Categorymodel>> incomeCategorylistLisner =
      ValueNotifier([]);
  ValueNotifier<List<Categorymodel>> expanceCategorylistLisner =
      ValueNotifier([]);

  @override
  Future<void> insertcategory(Categorymodel value) async {
    final categoryDb = await Hive.openBox<Categorymodel>(CATEGORY_DB_NAME);
    await categoryDb.put(value.id, value);
    refreshUI();
  }

  @override
  Future<List<Categorymodel>> getCategories() async {
    final categoryDb = await Hive.openBox<Categorymodel>(CATEGORY_DB_NAME);
    return categoryDb.values.toList();
  }

  Future<void> refreshUI() async {
    final getallcategory = await getCategories();
    incomeCategorylistLisner.value.clear();
    expanceCategorylistLisner.value.clear();
    Future.forEach(getallcategory, (Categorymodel category) {
      if (category.type == Categorytype.income) {
        incomeCategorylistLisner.value.add(category);
      } else {
        expanceCategorylistLisner.value.add(category);
      }
    });

    incomeCategorylistLisner.notifyListeners();
    expanceCategorylistLisner.notifyListeners();
  }

  @override
  Future<void> deleteCategory(String categoryID) async {
    final _CategoryDB = await Hive.openBox<Categorymodel>(CATEGORY_DB_NAME);
    await _CategoryDB.delete(categoryID);
    refreshUI();
  }
}
