import 'package:flutter/material.dart';
import 'package:expense_app/widgets/new_tx.dart';
import 'package:expense_app/widgets/tx_list.dart';
import '../models/transaction.dart';

class UserTX extends StatefulWidget {
  @override
  _UserTXState createState() => _UserTXState();
}

class _UserTXState extends State<UserTX> {
  final List<Transaction> _userTransactions = [
    Transaction(
      id: "t1",
      title: "monthly Internet Contract",
      amount: 20.99,
      date: DateTime.now(),
    ),
    Transaction(
      id: "t2",
      title: "monthly 1ionos1",
      amount: 10.98,
      date: DateTime.now(),
    ),
  ];
  // private Transaction class
  void _addNewTX(String txTitle, double txAmount) {
    final newTx = Transaction(
      title: txTitle,
      amount: txAmount,
      date: DateTime.now(),
      id: DateTime.now().toString(),
    );

    setState(() {
      // interact with pointer in object of private _userTransactions
      _userTransactions.add(newTx);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      // Input Area for Chart
      NewTx(_addNewTX), // pointer to new_tx.dart
      TxList(_userTransactions),
    ]);
  }
}
