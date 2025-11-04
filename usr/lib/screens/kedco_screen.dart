import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/wallet_provider.dart';

class KedcoScreen extends StatefulWidget {
  const KedcoScreen({super.key});

  @override
  State<KedcoScreen> createState() => _KedcoScreenState();
}

class _KedcoScreenState extends State<KedcoScreen> {
  final TextEditingController meterNumberController = TextEditingController();
  final TextEditingController amountController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final walletProvider = Provider.of<WalletProvider>(context);

    return Scaffold(
      appBar: AppBar(title: const Text('KEDCO Payment')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Pay your KEDCO electricity bill', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 20),
            TextField(
              controller: meterNumberController,
              decoration: const InputDecoration(labelText: 'Meter Number'),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 20),
            TextField(
              controller: amountController,
              decoration: const InputDecoration(labelText: 'Amount (₦)'),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                final amount = int.tryParse(amountController.text) ?? 0;
                if (amount > 0 && walletProvider.balance >= amount) {
                  walletProvider.deductBalance(amount);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('KEDCO payment successful! Remaining balance: ₦${walletProvider.balance}')),
                  );
                } else if (amount <= 0) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Please enter a valid amount!')),
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Insufficient balance!')),
                  );
                }
              },
              child: const Text('Pay Bill'),
            ),
          ],
        ),
      ),
    );
  }
}