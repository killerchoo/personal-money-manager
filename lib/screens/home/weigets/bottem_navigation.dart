import 'package:flutter/material.dart';
import 'package:moneymanagment_app_1/screens/home/screen_home.dart';

class MoneyManagmentBottemNavigation extends StatelessWidget {
  const MoneyManagmentBottemNavigation({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: Screenhome.selectedindexnotifier,
        builder: (BuildContext ctx, int updatedindex, Widget? _) {
          return BottomNavigationBar(
            selectedItemColor: Colors.orange,
            unselectedItemColor: Colors.cyan,
            currentIndex: updatedindex,
              onTap: (newindex) {
                Screenhome.selectedindexnotifier.value = newindex;
              },
              items: const [
                BottomNavigationBarItem(
                    icon: Icon(Icons.home), label: 'Transation'),
                BottomNavigationBarItem(
                    icon: Icon(Icons.category), label: 'Category')
              ]);
        });
  }
}
