
import 'package:flutter/material.dart';
import 'package:moneymanagment_app_1/db/category/category_db.dart';
import 'package:moneymanagment_app_1/db/transation/transation_db.dart';
import 'package:moneymanagment_app_1/models/category/category_model.dart';
import 'package:moneymanagment_app_1/models/transations/transation_model.dart';

class ScreenaddTransation extends StatefulWidget {
  const ScreenaddTransation({super.key});
  static const routeName = 'add transation';

  @override
  State<ScreenaddTransation> createState() => _ScreenaddTransationState();
}

class _ScreenaddTransationState extends State<ScreenaddTransation> {
  String? _categoryID;

  final _purposetexteditingcontroller = TextEditingController();
  final _amoundtexteditingcontroller = TextEditingController();

  DateTime? _selectedDate;
  Categorytype? _selectedCategorytype;
  Categorymodel? _selectedCategorymodel;
  @override
  void initState() {
    _selectedCategorytype = Categorytype.income;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            TextFormField(
              controller: _purposetexteditingcontroller,
              decoration: InputDecoration(
                hintText: 'PURPUSE',
              ),
            ),
            SizedBox(
              height: 20,
            ),
            TextFormField(
              controller: _amoundtexteditingcontroller,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                hintText: 'AMOUND',
              ),
            ),
            SizedBox(
              height: 50,
            ),
            TextButton.icon(
                onPressed: () async {
                  final _selectdateTemp = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime.now().subtract(Duration(days: 365)),
                    lastDate: DateTime.now(),
                  );
                  if (_selectdateTemp == null) {
                    return;
                  } else {
                    print(_selectdateTemp.toString());
                    setState(() {
                      _selectedDate = _selectdateTemp;
                    });
                  }
                },
                icon: Icon(Icons.calendar_today),
                label: Text(_selectedDate == null
                    ? 'SELECTE DATE'
                    : _selectedDate!.toString())),
            SizedBox(
              height: 50,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Radio(
                      value: Categorytype.income,
                      groupValue: _selectedCategorytype,
                      onChanged: (newvalue) {
                        setState(() {
                          _selectedCategorytype = Categorytype.income;
                          _categoryID = null;
                        });
                      },
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Text('INCOME'),
                  ],
                ),
                Row(
                  children: [
                    Radio(
                      value: Categorytype.expanse,
                      groupValue: _selectedCategorytype,
                      onChanged: (newvalue) {
                        setState(() {
                          _selectedCategorytype = Categorytype.expanse;
                          _categoryID = null;
                        });
                      },
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Text('EXPANCE'),
                  ],
                ),
              ],
            ),
            DropdownButton(
              value: _categoryID,
              hint: Text('SELECTE ITEMS'),
              items: (_selectedCategorytype == Categorytype.income
                      ? CategoryDB().incomeCategorylistLisner
                      : CategoryDB().expanceCategorylistLisner)
                  .value
                  .map((e) {
                return DropdownMenuItem(
                  value: e.id,
                  child: Text(e.name),
                  onTap: () {
                    _selectedCategorymodel = e;
                  },
                );
              }).toList(),
              onChanged: (selectedvalue) {
                print(selectedvalue);
                setState(() {
                  _categoryID = selectedvalue;
                });
              },
            ),
            SizedBox(
              height: 30,
            ),
            ElevatedButton(
                onPressed: () {
                  addtransation();
                },
                child: Text('SUBMIT')),
          ],
        ),
      )),
    );
  }

  Future<void> addtransation() async {
    final _purposetext = _purposetexteditingcontroller.text;
    final _amoundtext = _amoundtexteditingcontroller.text;

    if (_purposetext.isEmpty) {
      return;
    }
    if (_amoundtext.isEmpty) {
      return;
    }

    if (_categoryID == null) {
      return;
    }
    if (_selectedDate == null) {
      return;
    }
    if (_selectedCategorymodel == null) {
      return;
    }

    final _parsedamound = double.tryParse(_amoundtext);
    if (_parsedamound == null) {
      return;
    }

    final _model = transationModel(
      purpose: _purposetext,
      amound: _parsedamound,
      date: _selectedDate!,
      type: _selectedCategorytype!,
      category: _selectedCategorymodel!,
    );

    await transationDB.instance.addtranstion(_model);
    Navigator.of(context).pop();
    transationDB.instance.refresh();
  }
}
