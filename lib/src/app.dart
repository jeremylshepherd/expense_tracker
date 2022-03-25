import 'package:flutter/material.dart';

import 'widgets/new_transaction.dart';
import 'models/transaction.dart';
import 'widgets/transaction_list.dart';
import 'widgets/chart.dart';

class App extends StatefulWidget {
  const App({Key? key}) : super(key: key);

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  final List<Transaction> _transactions = [
    Transaction(
      id: 't2',
      title: 'New Shorts',
      amount: 54.99,
      date: DateTime.now().subtract(
        const Duration(days: 2),
      ),
    ),
    Transaction(
      id: 't1',
      title: 'New Shoes',
      amount: 69.99,
      date: DateTime.now().subtract(
        const Duration(days: 1),
      ),
    ),
  ];

  List<Transaction> get _recentTransactions {
    return _transactions
        .where(
          (tx) => tx.date.isAfter(
            DateTime.now().subtract(const Duration(days: 7)),
          ),
        )
        .toList();
  }

  void _addNewTransaction(
      {required String title, required double amount, DateTime? date}) {
    final newTransaction = Transaction(
      id: 't${DateTime.now().toString()}',
      title: title,
      amount: amount,
      date: date ?? DateTime.now(),
    );
    setState(() {
      _transactions.add(newTransaction);
    });
  }

  void _removeTransaction(String id) {
    setState(() {
      _transactions.removeWhere((element) => element.id == id);
    });
  }

  void _showNewTransactionForm(BuildContext ctx) {
    showModalBottomSheet(
        context: ctx,
        builder: (_) {
          return GestureDetector(
            onTap: () {},
            child: NewTransaction(addTransaction: _addNewTransaction),
            behavior: HitTestBehavior.opaque,
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: _appTheme(),
      home: Builder(builder: (context) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Expense Tracker'),
            actions: [
              IconButton(
                icon: const Icon(Icons.add),
                onPressed: () => _showNewTransactionForm(context),
              ),
            ],
          ),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Chart(recentTransactions: _recentTransactions),
              TransactionList(
                transactions: _transactions,
                removeTransaction: _removeTransaction,
              ),
            ],
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () => _showNewTransactionForm(context),
            child: const Icon(Icons.add),
          ),
        );
      }),
    );
  }

  ThemeData _appTheme() {
    return ThemeData(
      colorScheme: ColorScheme.fromSwatch(
        primarySwatch: Colors.purple,
      ).copyWith(
        secondary: Colors.greenAccent,
      ),
      errorColor: Colors.red.shade300,
      fontFamily: 'Quicksand',
      textTheme: ThemeData.light().textTheme.copyWith(
            headline6: const TextStyle(
              fontFamily: 'OpenSans',
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
      appBarTheme: AppBarTheme(
        toolbarTextStyle: ThemeData.light()
            .textTheme
            .copyWith(
              headline6: const TextStyle(
                fontFamily: 'OpenSans',
                fontSize: 20,
              ),
            )
            .bodyText2,
        titleTextStyle: ThemeData.light()
            .textTheme
            .copyWith(
              headline6: const TextStyle(
                fontFamily: 'OpenSans',
                fontSize: 24,
              ),
            )
            .headline6,
      ),
    );
  }
}
