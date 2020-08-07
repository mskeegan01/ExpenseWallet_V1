import 'package:expense_app/styles.dart';
import 'package:flutter/material.dart';
// import '../styles.dart';
import '../models/transaction.dart';

// Packages
import 'package:intl/intl.dart';

class TxList extends StatelessWidget {
  final List<Transaction> transactions;
  //  get deleteTx
  final Function deleteTx;

  TxList(this.transactions, this.deleteTx);

  @override
  Widget build(BuildContext context) {
    return transactions.isEmpty
        ? LayoutBuilder(builder: (ctx, constraints) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  "No transactions have been added.",
                  style: Theme.of(context).textTheme.headline6,
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  height: constraints.maxHeight * 0.6,
                  child: Image.asset(
                    "images/waiting.png",
                    fit: BoxFit.cover,
                  ),
                ),
              ],
            );
          })
        : ListView.builder(
            itemBuilder: (txContext, index) {
              return Card(
                elevation: 5,
                margin: EdgeInsets.symmetric(vertical: 8, horizontal: 5),
                child: ListTile(
                  leading: CircleAvatar(
                    radius: 30,
                    child: Padding(
                      padding: EdgeInsets.all(6),
                      child: FittedBox(
                        child: Text(
                          "${transactions[index].amount}€",
                        ),
                      ),
                    ),
                  ),
                  title: Text(transactions[index].title,
                      style: Theme.of(context).textTheme.headline6),
                  subtitle: Text(
                    DateFormat.yMMMd().format(
                      (transactions[index].date),
                    ),
                  ),
                  trailing: MediaQuery.of(context).size.width > 460
                      ? FlatButton.icon(
                          icon: Icon(Icons.delete),
                          textColor: alertColor,
                          label: Text("Delete"),
                          onPressed: () => deleteTx(transactions[index].id),
                        )
                      : IconButton(
                          icon: Icon(Icons.delete),
                          color: alertColor,
                          onPressed: () => deleteTx(transactions[index].id),
                        ),
                ),
              );
            },
            itemCount: transactions.length,
            // tx -> transactions for map function
            // children: transactions.map((transactions) {}).toList(),
          );
  }
}
