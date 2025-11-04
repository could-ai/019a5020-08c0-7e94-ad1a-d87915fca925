import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/wallet_provider.dart';

class DataScreen extends StatefulWidget {
  const DataScreen({super.key});

  @override
  State<DataScreen> createState() => _DataScreenState();
}

class _DataScreenState extends State<DataScreen> {
  String selectedNetwork = 'MTN';
  String selectedPlan = '1GB - ₦500';

  final List<String> networks = ['MTN', 'Airtel', 'Glo', '9mobile'];
  final Map<String, List<String>> plans = {
    'MTN': ['500MB - ₦200', '1GB - ₦500', '2GB - ₦1000', '5GB - ₦2000'],
    'Airtel': ['750MB - ₦300', '1.5GB - ₦700', '3GB - ₦1500', '10GB - ₦3000'],
    'Glo': ['1GB - ₦400', '2.5GB - ₦900', '5.5GB - ₦1800', '12GB - ₦3500'],
    '9mobile': ['1GB - ₦450', '2GB - ₦800', '4.5GB - ₦1600', '11GB - ₦3200'],
  };

  @override
  Widget build(BuildContext context) {
    final walletProvider = Provider.of<WalletProvider>(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Buy Data')),
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
            const Text('Select Data Plan', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            DropdownButton<String>(
              value: selectedPlan,
              items: plans[selectedNetwork]!.map((plan) => DropdownMenuItem(value: plan, child: Text(plan))).toList(),
              onChanged: (value) => setState(() => selectedPlan = value!),
            ),
            const SizedBox(height: 20),
            TextField(
              decoration: const InputDecoration(labelText: 'Phone Number'),
              keyboardType: TextInputType.phone,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Mock purchase
                final price = int.parse(selectedPlan.split('₦')[1]);
                if (walletProvider.balance >= price) {
                  walletProvider.deductBalance(price);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Data purchased successfully! Remaining balance: ₦${walletProvider.balance}')),
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Insufficient balance!')),
                  );
                }
              },
              child: const Text('Purchase Data'),
            ),
          ],
        ),
      ),
    );
  }
}