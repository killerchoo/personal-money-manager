import 'package:flutter/material.dart';
import 'package:moneymanagment_app_1/db/category/category_db.dart';
import 'package:moneymanagment_app_1/models/category/category_model.dart';

ValueNotifier<Categorytype> selectedcaetgorynotifier =
    ValueNotifier(Categorytype.income);

Future<void> showcategoryaddpopup(BuildContext context) async {
  final _nameEditingController = TextEditingController();
  showDialog(
      context: context,
      builder: (ctx) {
        return SimpleDialog(
          children: [
            Center(
                child: Title(
                    color: Colors.black, child: const Text('ADD CATEGORY'))),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                controller: _nameEditingController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'add category',
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Radiobuttom(title: 'INCOME', type: Categorytype.income),
                  Radiobuttom(title: 'EXPANCE', type: Categorytype.expanse)
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                  onPressed: () {
                    final _name = _nameEditingController.text;
                    if (_name.isEmpty) {
                      return;
                    }
                    final _type = selectedcaetgorynotifier.value;
                    final _category = Categorymodel(
                      id: DateTime.now().millisecondsSinceEpoch.toString(),
                      name: _name,
                      type: _type,
                    );
                    CategoryDB.instance.insertcategory(_category);
                    Navigator.of(ctx).pop;
                  },
                  child: const Text('ADD CATEGORY')),
            ),
          ],
        );
      });
}

class Radiobuttom extends StatelessWidget {
  final String title;
  final Categorytype type;

  const Radiobuttom({
    super.key,
    required this.title,
    required this.type,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ValueListenableBuilder(
            valueListenable: selectedcaetgorynotifier,
            builder: (
              BuildContext ctx,
              Categorytype newcategory,
              Widget? _,
            ) {
              return Radio<Categorytype>(
                value: type,
                groupValue: selectedcaetgorynotifier.value,
                onChanged: (value) {
                  if (value == null) {
                    return;
                  }
                  selectedcaetgorynotifier.value = value;
                  selectedcaetgorynotifier.notifyListeners();
                },
              );
            }),
        Text(title)
      ],
    );
  }
}
