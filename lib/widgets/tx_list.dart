import 'package:flutter/material.dart';
import '../styles.dart';
import '../models/transaction.dart';

// Packages
import 'package:intl/intl.dart';

class TxList extends StatelessWidget {
  final List<Transaction> transactions;

  TxList(this.transactions);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300, // height wrapper for ListView - prevent infinite height
      child: ListView(
        // tx -> transactions for map function
        children: transactions.map((tx) {
          return Card(
            child: Row(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.symmetric(
                    vertical: 10,
                    horizontal: 15,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: txGreen,
                      width: 2,
                    ),
                  ),
                  padding: EdgeInsets.all(10),
                  // call double toString
                  child: Text(
                    "${tx.amount} €", //+ tx.amount.toString(), Dollar = \$
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w800,
                      color: oceanBlue,
                    ),
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      tx.title,
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
                    ),
                    Text(
                      DateFormat().format(tx.date),
                      style: TextStyle(
                        color: Colors.grey,
                      ),
                    ),
                  ],
                )
              ],
            ),
          );
        }).toList(),
      ),
    );
  }
}
