import 'package:flutter/material.dart';
import 'package:moneymanagment_app_1/screens/add_transation/screen_add_transation.dart';
import 'package:moneymanagment_app_1/screens/category/category_add_popup.dart';
import 'package:moneymanagment_app_1/screens/category/screen_category.dart';
import 'package:moneymanagment_app_1/screens/home/weigets/bottem_navigation.dart';
import 'package:moneymanagment_app_1/screens/transations/screen_transation.dart';

class Screenhome extends StatelessWidget {
  const Screenhome({super.key});
  static ValueNotifier<int> selectedindexnotifier = ValueNotifier(0);

  final _pages = const [Screentransation(), Screencategory()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      appBar: AppBar(
        title: const Center(child: Text('MONEY MANAGMENT')),
        backgroundColor: const Color.fromARGB(255, 33, 170, 243),
      ),
      bottomNavigationBar: const MoneyManagmentBottemNavigation(),
      body: SafeArea(
        child: ValueListenableBuilder(
          valueListenable: selectedindexnotifier,
          builder: (BuildContext context, int updatedindex, _) {
            return _pages[updatedindex];
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (selectedindexnotifier.value == 0) {
            print('add transation');
            Navigator.of(context).pushNamed(ScreenaddTransation.routeName);
          } else {
            print('add category');
            showcategoryaddpopup(context);
          }
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
