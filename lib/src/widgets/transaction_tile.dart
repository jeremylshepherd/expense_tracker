import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/transaction.dart';

class TransactionTile extends StatelessWidget {
  const TransactionTile({
    Key? key,
    required this.transactions,
    required this.removeTransaction,
    required this.context,
    required this.index,
  }) : super(key: key);

  final List<Transaction> transactions;
  final Function removeTransaction;
  final BuildContext context;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Theme.of(context).colorScheme.secondary,
          radius: 30,
          child: Padding(
            padding: const EdgeInsets.all(6),
            child: FittedBox(
              child: Text(
                '\$${transactions[index].amount.toStringAsFixed(2)}',
                style: Theme.of(context).textTheme.headline6,
              ),
            ),
          ),
        ),
        title: Text(
          transactions[index].title,
          style: Theme.of(context).textTheme.headline6,
        ),
        subtitle:
            Text(DateFormat.yMMMMd('en-us').format(transactions[index].date)),
        trailing: MediaQuery.of(context).size.width > 360
            ? TextButton.icon(
                onPressed: () => removeTransaction(transactions[index].id),
                icon: Icon(
                  Icons.delete,
                  color: Theme.of(context).errorColor,
                ),
                label: const Text("Delete"),
              )
            : IconButton(
                icon: Icon(
                  Icons.delete,
                  color: Theme.of(context).errorColor,
                ),
                onPressed: () => removeTransaction(transactions[index].id),
              ),
      ),
    );
  }
}
