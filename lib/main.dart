import 'package:flutter/material.dart';

import 'package:expense_app/widgets/new_tx.dart';
import './styles.dart';
import './widgets/tx_list.dart';
import './widgets/new_tx.dart';
import './models/transaction.dart';
import './widgets/chart.dart';

// import 'dart:io';
// import 'package:flutter/foundation.dart';

// void main() {
//   FlutterError.onError = (FlutterErrorDetails details) {
//     FlutterError.dumpErrorToConsole(details);
//     if (kReleaseMode) exit(1);
//   };
//   runApp(MyApp());
// }

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var materialApp = MaterialApp(
      theme: ThemeData(
        primaryColor: oceanBlue,
        fontFamily: "Quicksand",
        textTheme: ThemeData.light().textTheme.copyWith(
              headline6: TextStyle(
                  fontFamily: "OpenSans",
                  fontWeight: FontWeight.bold,
                  fontSize: 18),
            ),
        appBarTheme: AppBarTheme(
          textTheme: ThemeData.light().textTheme.copyWith(
                headline6: TextStyle(
                    fontFamily: "OpenSans",
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
        ),
      ),
      debugShowCheckedModeBanner: false,
      title: 'ExpenseWallet V1',
      home: MyHomePage(),
    );
    return materialApp;
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // get txContext => null;

  final List<Transaction> _userTransactions = [
    // default transactions
    // Transaction(
    //   id: "t1",
    //   title: "monthly Internet Contract",
    //   amount: 20.99,
    //   date: DateTime.now(),
    // ),
    // Transaction(
    //   id: "t2",
    //   title: "monthly 1ionos1",
    //   amount: 10.98,
    //   date: DateTime.now(),
    // ),
  ];

// dynamcially calculated property --> getter
  List<Transaction> get _recentTx {
    // where method
    return _userTransactions.where((txList) {
      return txList.date.isAfter(
        DateTime.now().subtract(
          Duration(days: 7),
        ),
      );
      // where requires iterable -> toList
    }).toList();
  }

  // private Transaction class
  void _addNewTx(String txTitle, double txAmount, DateTime chosenDate) {
    final newTx = Transaction(
      title: txTitle,
      amount: txAmount,
      date: chosenDate,
      id: DateTime.now().toString(),
    );

    setState(() {
      // interact with pointer in object of private _userTransactions
      _userTransactions.add(newTx);
    });
  }

// part private state class _
  void _startAddNewTx(BuildContext txContext) {
    showModalBottomSheet(
      context: txContext,
      builder: (_) {
        return NewTx(_addNewTx);
      },
    );
  }

// from models String ID
  void _deleteTransaction(String id) {
    setState(() {
      _userTransactions.removeWhere((tx) => tx.id == id);
    });
  }

  @override
  Widget build(BuildContext context) {
    final bool showFActionButton =
        MediaQuery.of(context).viewInsets.bottom == 0.0;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Your Expense Wallet V1'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () => _startAddNewTx(context),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Chart(_recentTx),
            TxList(_userTransactions, _deleteTransaction),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        backgroundColor: txGreen,
        child: showFActionButton ? Icon(Icons.add) : null,
        onPressed: () => _startAddNewTx(context),
      ),
    );
  }
}
