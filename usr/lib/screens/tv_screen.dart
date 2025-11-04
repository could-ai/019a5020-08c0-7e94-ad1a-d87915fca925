import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/wallet_provider.dart';

class TvScreen extends StatefulWidget {
  const TvScreen({super.key});

  @override
  State<TvScreen> createState() => _TvScreenState();
}

class _TvScreenState extends State<TvScreen> {
  String selectedProvider = 'DSTV';
  String selectedPlan = 'Compact - ₦9000';
  final TextEditingController smartCardController = TextEditingController();

  final List<String> providers = ['DSTV', 'GOTV', 'Startimes', 'Showmax'];
  final Map<String, List<String>> plans = {
    'DSTV': ['Compact - ₦9000', 'Compact Plus - ₦13000', 'Premium - ₦18500'],
    'GOTV': ['Jolli - ₦2900', 'Max - ₦3900', 'Supa - ₦5500'],
    'Startimes': ['Nova - ₦900', 'Basic - ₦1300', 'Classic - ₦1900'],
    'Showmax': ['Mobile - ₦1200', 'Pro - ₦2900'],
  };

  @override
  Widget build(BuildContext context) {
    final walletProvider = Provider.of<WalletProvider>(context);

    return Scaffold(
      appBar: AppBar(title: const Text('TV Subscription')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Select Provider', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            DropdownButton<String>(
              value: selectedProvider,
              items: providers.map((provider) => DropdownMenuItem(value: provider, child: Text(provider))).toList(),
              onChanged: (value) => setState(() => selectedProvider = value!),
            ),
            const SizedBox(height: 20),
            const Text('Select Plan', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            DropdownButton<String>(
              value: selectedPlan,
              items: plans[selectedProvider]!.map((plan) => DropdownMenuItem(value: plan, child: Text(plan))).toList(),
              onChanged: (value) => setState(() => selectedPlan = value!),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: smartCardController,
              decoration: const InputDecoration(labelText: 'Smart Card Number'),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                final price = int.parse(selectedPlan.split('₦')[1]);
                if (walletProvider.balance >= price) {
                  walletProvider.deductBalance(price);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('TV subscription purchased successfully! Remaining balance: ₦${walletProvider.balance}')),
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Insufficient balance!')),
                  );
                }
              },
              child: const Text('Subscribe'),
            ),
          ],
        ),
      ),
    );
  }
}