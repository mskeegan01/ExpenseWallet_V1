import 'package:flutter/material.dart';
import '../styles.dart';

class NewTx extends StatelessWidget {
  final Function addTx;
  final titleController = TextEditingController();
  final amountController = TextEditingController();

  NewTx(this.addTx);

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
              // onChanged: (userValue) {
              //   titleInput = userValue;
              // },
            ),
            TextField(
              decoration: InputDecoration(labelText: "Amount"),
              cursorColor: txGreen,
              style: TextStyle(color: txGreen),
              controller: amountController,
              // Cupertino Iphone: TextInputType.numberWithOptions(decimal: true),              
              keyboardType: TextInputType.number,
              // onChanged: (userValue) {
              //   amountInput = userValue;
              // },
            ),
            FlatButton(
              child: Text('Add Transaction'),
              textColor: txGreen,
              onPressed: () {
                addTx(
                    titleController.text, double.parse(amountController.text));
                // Test User Input
                // print(titleController);
                // print(amountController);
              },
            )
          ],
        ),
      ),
    );
  }
}
