import 'package:expense_tracker/src/models/recent_expense.dart';
import 'package:intl/intl.dart';

import '../models/transaction.dart';
import 'package:flutter/material.dart';

import 'chart_bar.dart';

class Chart extends StatelessWidget {
  final List<Transaction> recentTransactions;

  const Chart({Key? key, required this.recentTransactions}) : super(key: key);

  List<RecentExpense> get groupedTransactionValues {
    return List.generate(
      7,
      (index) {
        final weekDay = DateTime.now().subtract(
          Duration(days: index),
        );
        double totalSum = 0.0;
        for (var i = 0; i < recentTransactions.length; i++) {
          if (recentTransactions[i].date.day == weekDay.day &&
              recentTransactions[i].date.month == weekDay.month &&
              recentTransactions[i].date.year == weekDay.year) {
            totalSum += recentTransactions[i].amount;
          }
        }
        return RecentExpense(
            day: DateFormat.E().format(weekDay), amount: totalSum);
      },
    ).reversed.toList();
  }

  double get totalSpending {
    return groupedTransactionValues.fold(
        0.0, (previousValue, element) => previousValue + element.amount);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            SizedBox(
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 10,
                  horizontal: 5,
                ),
                child: Text(
                  'Spending past 7 days',
                  style: Theme.of(context).textTheme.headline6,
                  textAlign: TextAlign.left,
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: groupedTransactionValues
                  .map((e) => Flexible(
                        fit: FlexFit.tight,
                        child: ChartBar(
                          recentExpense: e,
                          weeklySpending: totalSpending,
                        ),
                      ))
                  .toList(),
            ),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.only(top: 15),
              child: Text(
                'Week\'s Total Spending: \$${totalSpending.toStringAsFixed(2)}',
                textAlign: TextAlign.right,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
