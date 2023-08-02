import 'package:flutter/material.dart';
import 'package:moneymanagment_app_1/db/category/category_db.dart';
import 'package:moneymanagment_app_1/models/category/category_model.dart';

class ExpanceCategoryList extends StatelessWidget {
  const ExpanceCategoryList({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: CategoryDB().expanceCategorylistLisner,
        builder: (BuildContext ctx, List<Categorymodel> newlist, Widget? _) {
          return ListView.separated(
              itemBuilder: (ctx, index) {
                final category = newlist[index];
                return Card(
                  child: ListTile(
                    title: Text(category.name),
                    trailing: IconButton(
                        onPressed: () {
                          CategoryDB.instance.deleteCategory(category.id);
                        },
                        icon: const Icon(Icons.delete)),
                  ),
                );
              },
              separatorBuilder: (ctx, index) {
                return const Divider();
              },
              itemCount: newlist.length);
        });
  }
}
