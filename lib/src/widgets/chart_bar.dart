import 'package:flutter/material.dart';
import '../models/recent_expense.dart';

class ChartBar extends StatelessWidget {
  final RecentExpense recentExpense;
  final double weeklySpending;

  const ChartBar(
      {Key? key, required this.recentExpense, required this.weeklySpending})
      : super(key: key);
  double get expenseBarAmount {
    return weeklySpending > 0 ? recentExpense.amount / weeklySpending : 0.0;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          height: 20,
          child: FittedBox(
            child: Text('\$${recentExpense.amount.toStringAsFixed(0)}'),
          ),
        ),
        const SizedBox(
          height: 4,
        ),
        Container(
          height: 80,
          width: 20,
          child: Stack(
            alignment: AlignmentDirectional.bottomStart,
            children: [
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey, width: 1.0),
                  color: Theme.of(context).colorScheme.primary,
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
              Container(
                alignment: AlignmentDirectional.center,
                width: 10,
                height: 70,
                margin: const EdgeInsets.only(left: 5, bottom: 5),
                decoration: BoxDecoration(
                    color:
                        Theme.of(context).colorScheme.primary.withOpacity(0.5),
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: [
                      BoxShadow(
                          blurStyle: BlurStyle.inner,
                          blurRadius: 15,
                          color: Colors.purple.shade700,
                          spreadRadius: 5),
                    ]),
              ),
              FractionallySizedBox(
                heightFactor: expenseBarAmount,
                widthFactor: .95,
                child: Container(
                  margin: const EdgeInsets.only(
                    left: (30 * .05 / 2),
                    bottom: 1,
                    top: 1,
                  ),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.secondary,
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 4,
        ),
        Text(recentExpense.day.substring(0, 1).toUpperCase()),
      ],
    );
  }
}
