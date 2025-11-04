import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/wallet_provider.dart';

class AirtimeScreen extends StatefulWidget {
  const AirtimeScreen({super.key});

  @override
  State<AirtimeScreen> createState() => _AirtimeScreenState();
}

class _AirtimeScreenState extends State<AirtimeScreen> {
  String selectedNetwork = 'MTN';
  final TextEditingController amountController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();

  final List<String> networks = ['MTN', 'Airtel', 'Glo', '9mobile'];

  @override
  Widget build(BuildContext context) {
    final walletProvider = Provider.of<WalletProvider>(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Buy Airtime')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Select Network', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            DropdownButton<String>(
              value: selectedNetwork,
              items: networks.map((network) => DropdownMenuItem(value: network, child: Text(network))).toList(),
              onChanged: (value) => setState(() => selectedNetwork = value!),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: phoneController,
              decoration: const InputDecoration(labelText: 'Phone Number'),
              keyboardType: TextInputType.phone,
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
                    SnackBar(content: Text('Airtime purchased successfully! Remaining balance: ₦${walletProvider.balance}')),
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
              child: const Text('Purchase Airtime'),
            ),
          ],
        ),
      ),
    );
  }
}