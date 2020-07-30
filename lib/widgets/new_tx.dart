import 'package:flutter/material.dart';
import '../styles.dart';

class NewTx extends StatefulWidget {
  final Function addTx;

  // receive pointer from main _addNewTx and accept it to this.addTx
  NewTx(this.addTx);

  @override
  _NewTxState createState() => _NewTxState();
}

class _NewTxState extends State<NewTx> {
  final titleController = TextEditingController();

  final amountController = TextEditingController();

  void confirmData() {
    final submittedTitle = titleController.text;
    // double conversion for submitted amount
    final submittedAmount = double.parse(amountController.text);
    // validate input
    if (submittedTitle.isEmpty || submittedAmount <= 0) {
      return;
    }
    // widget. access properties and methods of widget class inside state class (flutter feature)
    widget.addTx(
      submittedTitle,
      submittedAmount,
    );
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        padding: EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            // user Input
            TextField(
              decoration: InputDecoration(labelText: "Title"),
              cursorColor: txGreen,
              style: TextStyle(color: txGreen),
              controller: titleController,
              onSubmitted: (_) => confirmData(),
              // onChanged: (userValue) {
              //   titleInput = userValue;
              // },
            ),
            TextField(
              decoration: InputDecoration(labelText: "Amount"),
              cursorColor: txGreen,
              style: TextStyle(color: txGreen),
              controller: amountController,
              // Iphone: TextInputType.numberWithOptions(decimal: true)
              keyboardType: TextInputType.number,
              // _ don't use the arguement but need to take it
              onSubmitted: (_) => confirmData(),
              // onChanged: (userValue) {
              //   amountInput = userValue;
              // },
            ),
            FlatButton(
              child: Text('Add Transaction'),
              textColor: txGreen,
              onPressed: confirmData,
            ),
          ],
        ),
      ),
    );
  }
}
