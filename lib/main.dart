import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:moneymanagment_app_1/models/category/category_model.dart';
import 'package:moneymanagment_app_1/models/transations/transation_model.dart';
import 'package:moneymanagment_app_1/screens/add_transation/screen_add_transation.dart';
import 'package:moneymanagment_app_1/screens/home/screen_home.dart';

import 'db/category/category_db.dart';

Future<void> main() async {
  final odj1 = CategoryDB();
  final odj2 = CategoryDB();
  print('objects ');
  print(odj1 == odj2);

  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();
  if (!Hive.isAdapterRegistered(CategorytypeAdapter().typeId)) {
    Hive.registerAdapter(CategorytypeAdapter());
  }

  if (!Hive.isAdapterRegistered(CategorymodelAdapter().typeId)) {
    Hive.registerAdapter(CategorymodelAdapter());
  }

  if (!Hive.isAdapterRegistered(transationModelAdapter().typeId)) {
    Hive.registerAdapter(transationModelAdapter());
  }


  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
            seedColor: const Color.fromARGB(255, 68, 58, 183)),
        useMaterial3: true,
      ),
      home: const Screenhome(),
      routes: {
        ScreenaddTransation.routeName:(context) => ScreenaddTransation(),
      },
    );
  }
}
