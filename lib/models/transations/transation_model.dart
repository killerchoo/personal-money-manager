import 'package:hive_flutter/hive_flutter.dart';
import 'package:moneymanagment_app_1/models/category/category_model.dart';
part 'transation_model.g.dart';

@HiveType(typeId: 3)
class transationModel {
  @HiveField(0)
  final String purpose;

  @HiveField(1)
  final double amound;

  @HiveField(2)
  final DateTime date;

  @HiveField(3)
  final Categorytype type;

  @HiveField(4)
  final Categorymodel category;
  @HiveField(5)
  String? id;

  transationModel({
    required this.purpose,
    required this.amound,
    required this.date,
    required this.type,
    required this.category,
  }) {
    id = DateTime.now().millisecondsSinceEpoch.toString();
  }
}
