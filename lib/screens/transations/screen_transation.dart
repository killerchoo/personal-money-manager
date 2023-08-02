import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';
import 'package:moneymanagment_app_1/db/category/category_db.dart';
import 'package:moneymanagment_app_1/db/transation/transation_db.dart';
import 'package:moneymanagment_app_1/models/category/category_model.dart';
import 'package:moneymanagment_app_1/models/transations/transation_model.dart';

class Screentransation extends StatelessWidget {
  const Screentransation({super.key});

  @override
  Widget build(BuildContext context) {
    transationDB.instance.refresh();
    CategoryDB.instance.refreshUI();
    return ValueListenableBuilder(
      valueListenable: transationDB.instance.transationlistnotifier,
      builder: (BuildContext ctx, List<transationModel> newlist, Widget? _) {
        return ListView.separated(
            itemBuilder: (ctx, index) {
              final _value = newlist[index];

              return Slidable(
                key: Key(_value.id!),
                startActionPane: ActionPane(
                  motion: ScrollMotion(),
                  children: [
                    SlidableAction(
                      onPressed: (ctx) {
                        transationDB.instance.deleteTransation(_value.id!);
                      },
                      icon: Icons.delete,
                      label: 'delete',
                    )
                  ],
                ),
                child: Card(
                  child: ListTile(
                      leading: CircleAvatar(
                        backgroundColor: _value.type == Categorytype.income
                            ? Colors.green
                            : Colors.red,
                        radius: 60,
                        child: Text(
                          parsedate(_value.date),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      title: Text('Rs ${_value.amound}'),
                      subtitle: Text(_value.category.name),
                      ),
                ),
              );
            },
            separatorBuilder: (ctx, index) {
              return const SizedBox(
                height: 5,
              );
            },
            itemCount: newlist.length);
      },
    );
  }

  String parsedate(DateTime date) {
    final _date = DateFormat.MMMd().format(date);
    final _splitedDate = _date.split(' ');
    return '${_splitedDate.last}\n${_splitedDate.first}';

    
  }
}
