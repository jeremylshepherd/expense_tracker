class Transaction {
  final String id;
  final String title;
  final double amount;
  final DateTime date;

  Transaction({
    required this.id,
    required this.title,
    required this.amount,
    required this.date,
  });

  @override
  String toString() {
    return '''{
      'id: '$id,
      'title: '$title,
      'amount: '$amount,
      'date: '$date
    }''';
  }
}
