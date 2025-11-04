import 'package:flutter/foundation.dart';

class Transaction {
  final String description;
  final int amount;
  final String type; // 'debit' or 'credit'
  final DateTime date;

  Transaction({
    required this.description,
    required this.amount,
    required this.type,
    required this.date,
  });
}

class WalletProvider with ChangeNotifier {
  int _balance = 10000; // Starting balance for demo
  final List<Transaction> _transactions = [];

  int get balance => _balance;
  List<Transaction> get transactions => _transactions;

  void addBalance(int amount) {
    _balance += amount;
    _transactions.insert(0, Transaction(
      description: 'Wallet funded',
      amount: amount,
      type: 'credit',
      date: DateTime.now(),
    ));
    notifyListeners();
  }

  void deductBalance(int amount) {
    if (_balance >= amount) {
      _balance -= amount;
      _transactions.insert(0, Transaction(
        description: 'Purchase',
        amount: amount,
        type: 'debit',
        date: DateTime.now(),
      ));
      notifyListeners();
    }
  }
}