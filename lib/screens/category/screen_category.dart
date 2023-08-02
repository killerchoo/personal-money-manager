import 'package:flutter/material.dart';
import 'package:moneymanagment_app_1/db/category/category_db.dart';
import 'package:moneymanagment_app_1/screens/category/expance_category_list.dart';
import 'package:moneymanagment_app_1/screens/category/income_category_list.dart';

class Screencategory extends StatefulWidget {
  const Screencategory({super.key});

  @override
  State<Screencategory> createState() => _ScreencategoryState();
}

class _ScreencategoryState extends State<Screencategory>
    with SingleTickerProviderStateMixin {
  late TabController _tabcontroller;
  @override
  void initState() {
    _tabcontroller = TabController(length: 2, vsync: this);
    CategoryDB().refreshUI();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TabBar(controller: _tabcontroller, tabs: const [
          Tab(text: 'INCOME'),
          Tab(
            text: 'EXPANCE',
          )
        ]),
        Expanded(
          child: TabBarView(
              controller: _tabcontroller,
              children: const [IncomeCategoryList(), ExpanceCategoryList()]),
        )
      ],
    );
  }
}
