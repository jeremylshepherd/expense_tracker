import 'package:expense_tracker/src/models/transaction.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final Function removeTransaction;
  const TransactionList({
    Key? key,
    required this.transactions,
    required this.removeTransaction,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 350,
      child: transactions.isEmpty
          ? Column(
              children: [
                Text(
                  'No transactions yet',
                  style: Theme.of(context).textTheme.headline6,
                ),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  height: 200,
                  child: Image.asset(
                    'assets/images/waiting.png',
                    fit: BoxFit.cover,
                  ),
                ),
              ],
            )
          : ListView.builder(
              itemBuilder: (context, index) => _buildListTile(context, index),
              itemCount: transactions.length,
            ),
    );
  }

  Widget _buildListTile(context, index) {
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
        trailing: IconButton(
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
