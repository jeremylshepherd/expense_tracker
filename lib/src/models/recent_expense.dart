class RecentExpense {
  final String day;
  final double amount;

  RecentExpense({required this.day, required this.amount});

  @override
  String toString() {
    return '''{
      'day: '$day,
      'amount: '$amount
    }''';
  }
}
