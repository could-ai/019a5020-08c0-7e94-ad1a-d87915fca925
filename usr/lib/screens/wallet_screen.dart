import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/wallet_provider.dart';

class WalletScreen extends StatelessWidget {
  const WalletScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final walletProvider = Provider.of<WalletProvider>(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Wallet')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Card(
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    const Text('Current Balance', style: TextStyle(fontSize: 18)),
                    Text(
                      '₦${walletProvider.balance}',
                      style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Colors.green),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            const Text('Recent Transactions', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            Expanded(
              child: ListView.builder(
                itemCount: walletProvider.transactions.length,
                itemBuilder: (context, index) {
                  final transaction = walletProvider.transactions[index];
                  return ListTile(
                    leading: Icon(
                      transaction.type == 'debit' ? Icons.arrow_downward : Icons.arrow_upward,
                      color: transaction.type == 'debit' ? Colors.red : Colors.green,
                    ),
                    title: Text(transaction.description),
                    subtitle: Text(transaction.date.toString().split(' ')[0]),
                    trailing: Text(
                      '${transaction.type == 'debit' ? '-' : '+'}₦${transaction.amount}',
                      style: TextStyle(
                        color: transaction.type == 'debit' ? Colors.red : Colors.green,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Mock fund wallet
                walletProvider.addBalance(5000);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('₦5000 added to wallet!')),
                );
              },
              child: const Text('Add ₦5000 (Mock)'),
            ),
          ],
        ),
      ),
    );
  }
}