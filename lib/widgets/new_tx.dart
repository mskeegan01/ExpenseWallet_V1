import 'package:intl/intl.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../widgets/adaptive_flat_button.dart';

// Dependencies
import '../styles.dart';

class NewTx extends StatefulWidget {
  final Function addTx;

  // receive pointer from main _addNewTx and accept it to this.addTx
  NewTx(this.addTx);

  @override
  _NewTxState createState() => _NewTxState();
}

class _NewTxState extends State<NewTx> {
  //properties of class _ private
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime _selectedDate;

  void _confirmData() {
    if (_amountController.text.isEmpty) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            elevation: 5,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5),
            ),
            title: new Text(
              "Missing valid data",
              style: TextStyle(
                color: alertColor,
              ),
            ),
            actions: <Widget>[
              FlatButton(
                child: Text("Close"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              )
            ],
          );
        },
      );
    }
    final submittedTitle = _titleController.text;
    // double conversion for submitted amount
    final submittedAmount = double.parse(_amountController.text);
    // validate input
    if (submittedTitle.isEmpty ||
        submittedAmount <= 0 ||
        _selectedDate == null) {
      return;
    }
    // widget. access properties and methods of widget class inside state class (flutter feature)
    widget.addTx(submittedTitle, submittedAmount, _selectedDate);
    Navigator.of(context).pop();
  }

// handler
  void _presentDatePicker() {
    // context right refers to class property context, left to the agruement
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      // 2100 --> to select upcoming expanse events
      lastDate: DateTime(2100),
      // then method as anyonymus
    ).then((pickedDate) {
      if (pickedDate == null) {
        return;
      }
      setState(() {
        _selectedDate = pickedDate;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Card(
        child: Container(
          padding: EdgeInsets.only(
              top: 12,
              left: 12,
              right: 12,
              bottom: MediaQuery.of(context).viewInsets.bottom + 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              // user Input
              // CupertinoTextField(),
              TextField(
                decoration: InputDecoration(labelText: "Title"),
                cursorColor: txGreen,
                style: TextStyle(color: txGreen),
                controller: _titleController,
                onSubmitted: (_) => _confirmData(),
                // onChanged: (userValue) {
                //   titleInput = userValue;
                // },
              ),
              TextField(
                decoration: InputDecoration(labelText: "Amount"),
                cursorColor: txGreen,
                style: TextStyle(color: txGreen),
                controller: _amountController,
                // Iphone: TextInputType.numberWithOptions(decimal: true)
                keyboardType: TextInputType.number,
                // _ don't use the arguement but need to take it
                onSubmitted: (_) => _confirmData(),
                // onChanged: (userValue) {
                //   amountInput = userValue;
                // },
              ),
              // date Picker
              Container(
                height: 70,
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: Text(
                        _selectedDate == null
                            ? "No Date chosen"
                            : "Picked Date: ${DateFormat.yMd().format(_selectedDate)}",
                      ),
                    ),
                    AdaptiveFlatButton("Choose Date", _presentDatePicker),
                  ],
                ),
              ),
              RaisedButton(
                child: Text('Add Transaction'),
                color: txGreen,
                onPressed: _confirmData,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
