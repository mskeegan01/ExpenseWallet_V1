import 'package:expense_app/widgets/user_tx.dart';
import 'package:flutter/material.dart';
import './styles.dart';
// import './widgets/tx_list.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: ('ExpenseWallet V1'),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Expense Wallet V1'),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Container(
              height: 150,
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
            UserTX(),
          ],
        ),
      ),
    );
  }
}
