import 'package:expenses/widgets/adptive_flat_button.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'dart:io';
import 'package:flutter/cupertino.dart';

class NewTransaction extends StatefulWidget {
  final Function addtx;
  NewTransaction(this.addtx);

  @override
  _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  TextEditingController titleControler = TextEditingController();

  TextEditingController amountController = TextEditingController();
  DateTime dateTime;
  void submitdata() {
    if (amountController.text.isEmpty) {
      return;
    }
    final title = titleControler.text;
    final price = double.parse(amountController.text);

    if (title.isEmpty || price <= 0 || dateTime == null) {
      return;
    }
    widget.addtx(title, price, dateTime);
    Navigator.of(context).pop();
  }

  void _presentDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime.now(),
    ).then((pickedDate) {
      setState(() {
        dateTime = pickedDate;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            TextField(
              controller: titleControler,
              decoration: InputDecoration(labelText: 'Title'),
            ),
            TextField(
              controller: amountController,
              decoration: InputDecoration(labelText: 'Price'),
              keyboardType: TextInputType.number,
              onSubmitted: (_) => submitdata(),
            ),
            Container(
              height: 70,
              child: Row(
                children: [
                  Expanded(
                    child: Text(dateTime == null
                        ? 'No Date Chosen'
                        : 'Chosen Date   ${DateFormat.yMd().format(dateTime)}'),
                  ),
                  AdaptiveFlatButton('Choose Date', _presentDatePicker)
                ],
              ),
            ),
            ElevatedButton(
              onPressed: () {
                submitdata();
              },
              child: Text('add transaction'),
            ),
          ],
        ),
      ),
    );
  }
}
