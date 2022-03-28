import 'package:flutter/material.dart';
import '../models/transaction.dart';
import 'transaction_tile.dart';

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
    final media = MediaQuery.of(context);
    final bool isPortrait = media.orientation == Orientation.portrait;
    const double totalSpacers = 40;
    return transactions.isEmpty
        ? LayoutBuilder(builder: (context, constraints) {
            return Column(
              children: [
                Text(
                  'No transactions yet',
                  style: Theme.of(context).textTheme.headline6,
                ),
                const SizedBox(
                  height: 20,
                ),
                SizedBox(
                  height: (isPortrait
                          ? constraints.maxHeight * 0.75
                          : constraints.maxHeight * 0.95) -
                      totalSpacers,
                  child: Image.asset(
                    'assets/images/waiting.png',
                    fit: BoxFit.cover,
                  ),
                ),
              ],
            );
          })
        : ListView.builder(
            itemBuilder: (context, index) => TransactionTile(
                transactions: transactions,
                removeTransaction: removeTransaction,
                context: context,
                index: index),
            itemCount: transactions.length,
          );
  }
}
