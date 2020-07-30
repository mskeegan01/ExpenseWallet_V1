import 'package:expense_app/widgets/new_tx.dart';
import 'package:flutter/material.dart';
import './styles.dart';
import './widgets/tx_list.dart';
import './widgets/new_tx.dart';
import './models/transaction.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var materialApp = MaterialApp(
      theme: ThemeData(primaryColor: txGreen),
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
  void _addNewTx(String txTitle, double txAmount) {
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

// part private state class _
  void _startAddNewTx(BuildContext txContext) {
    showModalBottomSheet(
      context: txContext,
      builder: (_) {
        return NewTx(_addNewTx);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final bool showFActionButton =
        MediaQuery.of(context).viewInsets.bottom == 0.0;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Your Expense Wallet V1',
          // style: TextStyle(fontFamily: "Raleway"),
        ),
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
            Container(
              height: 100,
              width: 150,
              child: Card(
                color: themeColor,
                child: Text(
                  "FUTURE CHART HOLDER",
                  style: TextStyle(color: greyWhite),
                  textAlign: TextAlign.center,
                ),
                elevation: 5, // drop shadow
              ),
            ),
            TxList(_userTransactions),
          ],
        ),
      ),
      // floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        backgroundColor: txGreen,
        child: showFActionButton ? Icon(Icons.add) : null,
        onPressed: () => _startAddNewTx(context),
      ),
    );
  }
}
