import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  const NewTransaction({
    Key? key,
    required this.addTransaction,
  }) : super(key: key);

  final Function addTransaction;

  @override
  State<NewTransaction> createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime? _dateSelected;

  void submitData() {
    final enteredTitle = _titleController.text;
    final enteredAmount = double.parse(_amountController.text);

    if (enteredTitle.isEmpty || enteredAmount <= 0) {
      return;
    }

    widget.addTransaction(
      title: enteredTitle,
      amount: enteredAmount,
      date: _dateSelected,
    );
    _titleController.clear();
    _amountController.clear();
    Navigator.of(context).pop();
  }

  void _showDatePicker(BuildContext context) {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2017),
      lastDate: DateTime.now(),
    ).then(
      (value) {
        if (value == null) {
          return;
        }
        setState(() {
          _dateSelected = value;
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          _buildTitleInput(),
          _buildAmountInput(),
          _buildDatePicker(context),
          _buildSubmitButton(context),
        ],
      ),
    );
  }

  TextField _buildTitleInput() {
    return TextField(
      decoration: const InputDecoration(
        labelText: 'Title',
      ),
      controller: _titleController,
    );
  }

  TextField _buildAmountInput() {
    return TextField(
      decoration: const InputDecoration(
        labelText: 'Amount',
      ),
      controller: _amountController,
      keyboardType: const TextInputType.numberWithOptions(
        decimal: true,
      ),
    );
  }

  Container _buildDatePicker(BuildContext context) {
    return Container(
      height: 70,
      child: Row(
        children: [
          Expanded(
            child: Text(_dateSelected != null
                ? 'Selected date: ${DateFormat.yMd().format(_dateSelected!)}'
                : 'Defaults to current date'),
          ),
          TextButton(
            onPressed: () => _showDatePicker(context),
            child: Text(
              'Choose date',
              style: TextStyle(
                color: Theme.of(context).colorScheme.primary,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  ElevatedButton _buildSubmitButton(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
        backgroundColor:
            MaterialStateProperty.all(Theme.of(context).colorScheme.primary),
      ),
      onPressed: submitData,
      child: const Text(
        'Add Transaction',
        style: TextStyle(color: Colors.white),
      ),
    );
  }
}
