import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:expense_app/widgets/new_tx.dart';
// import 'package:flutter/services.dart';

// Dependencies local
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

void main() {
  // -------------------------------------------------
  // initialized device before setting device orientation
  // WidgetsFlutterBinding.ensureInitialized();
  // SystemChrome.setPreferredOrientations(
  //     [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  //  ------------------------------------------------
  runApp(MyApp());
}

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
    // return Platform.isIOS to make sure routing looks the same for iOS
    return Platform.isIOS ? CupertinoApp() : materialApp;
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

  bool _showChart = false;

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
    final mediaQuery = MediaQuery.of(context);
    final inLandscape = mediaQuery.orientation == Orientation.landscape;

    final bool showFActionButton = mediaQuery.viewInsets.bottom == 0.0;
    // adding type of PreferredSizeWidget for Cupertion AppBar
    final PreferredSizeWidget appBar = Platform.isIOS
        ? CupertinoNavigationBar(
            middle: Text("Your Expense Wallet V1"),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                IconButton(
                  icon: Icon(CupertinoIcons.add),
                  onPressed: () => _startAddNewTx(context),
                ),
              ],
            ),
          )
        : AppBar(
            centerTitle: true,
            title: Text('Your Expense Wallet V1'),
            actions: <Widget>[
              IconButton(
                icon: Icon(Icons.add),
                onPressed: () => _startAddNewTx(context),
              ),
            ],
          );

    final txListWidget = Container(
      height: (mediaQuery.size.height -
              appBar.preferredSize.height -
              mediaQuery.padding.top) *
          0.7,
      child: TxList(_userTransactions, _deleteTransaction),
    );

    final pageBody = SafeArea(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            if (inLandscape)
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text("Show chart",
                      style: Theme.of(context).textTheme.headline6),
                  // adaptive for iOS Design Widgets
                  Switch.adaptive(
                      activeColor: oceanBlue,
                      value: _showChart,
                      onChanged: (val) {
                        setState(() {
                          _showChart = val;
                        });
                      }),
                ],
              ),
            if (!inLandscape)
              Container(
                // add MediaQuery to consider AppBar size --> make screen not scrollable
                height: (mediaQuery.size.height -
                        appBar.preferredSize.height -
                        mediaQuery.padding.top) *
                    0.3,
                child: Chart(_recentTx),
              ),
            if (!inLandscape) txListWidget,
            if (inLandscape)
              _showChart
                  ? Container(
                      // add MediaQuery to consider AppBar size --> make screen not scrollable
                      height: (mediaQuery.size.height -
                              appBar.preferredSize.height -
                              mediaQuery.padding.top) *
                          0.7,
                      child: Chart(_recentTx),
                    )
                  : txListWidget,
          ],
        ),
      ),
    );
    return Platform.isIOS
        ? CupertinoPageScaffold(
            child: pageBody,
          )
        : Scaffold(
            appBar: appBar,
            body: pageBody,
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerFloat,
            // only render ActionButton on Android check for isIOS and render empty Container
            floatingActionButton: Platform.isIOS
                ? Container()
                : FloatingActionButton(
                    backgroundColor: txGreen,
                    child: showFActionButton ? Icon(Icons.add) : null,
                    onPressed: () => _startAddNewTx(context),
                  ),
          );
  }
}
