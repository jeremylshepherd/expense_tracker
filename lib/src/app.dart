import 'dart:io';

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
  bool _showChart = true;

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
    NewTransaction newTx = NewTransaction(addTransaction: _addNewTransaction);
    var media = MediaQuery.of(ctx);
    showModalBottomSheet(
        isScrollControlled: true,
        context: ctx,
        builder: (_) {
          return GestureDetector(
            onTap: () {},
            child: Padding(
              padding: EdgeInsets.only(
                // top: media.size.height * 0.25,
                bottom: media.viewInsets.bottom + (media.size.height * 0.40),
              ),
              child: newTx,
            ),
            behavior: HitTestBehavior.opaque,
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: _appTheme(),
      home: Builder(builder: (context) {
        final myAppBar = AppBar(
          title: const Text('Expense Tracker'),
          actions: [
            IconButton(
              icon: const Icon(Icons.add),
              onPressed: () => _showNewTransactionForm(context),
            ),
          ],
        );
        final mediaQuery = MediaQuery.of(context);
        final remainingHeight = mediaQuery.size.height -
            myAppBar.preferredSize.height -
            mediaQuery.padding.top -
            40;
        final orientantion = mediaQuery.orientation;
        return Scaffold(
          appBar: myAppBar,
          body: orientantion == Orientation.portrait
              ? _buildPortraitLayout(remainingHeight)
              : _buildLandscapeLayout(remainingHeight),
          floatingActionButton: Platform.isIOS
              ? null
              : FloatingActionButton(
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
            labelMedium: const TextStyle(
              fontFamily: 'OpenSans',
              fontSize: 14,
            ),
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

  Widget _buildPortraitLayout(double remainingHeight) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        SizedBox(
          height: remainingHeight * .32,
          child: Chart(recentTransactions: _recentTransactions),
        ),
        Expanded(
          child: SizedBox(
            height: remainingHeight * .68,
            child: TransactionList(
              transactions: _transactions,
              removeTransaction: _removeTransaction,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildLandscapeLayout(double remainingHeight) {
    const double switchHeight = 40;
    final Widget chartSwitch = SizedBox(
      height: switchHeight,
      width: double.infinity,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Show ${_showChart ? 'List' : 'Chart'}',
              style: Theme.of(context).textTheme.labelMedium),
          Switch.adaptive(
            value: _showChart,
            activeColor: Theme.of(context).colorScheme.primary,
            activeTrackColor: Theme.of(context).colorScheme.secondary,
            onChanged: (val) => setState(() => _showChart = val),
          ),
        ],
      ),
    );
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        chartSwitch,
        _showChart
            ? SizedBox(
                height: (remainingHeight - switchHeight) * 0.9,
                child: Chart(recentTransactions: _recentTransactions),
              )
            : SizedBox(
                height: remainingHeight - switchHeight,
                child: TransactionList(
                  transactions: _transactions,
                  removeTransaction: _removeTransaction,
                ),
              ),
      ],
    );
  }
}
