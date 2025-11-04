import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/wallet_provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Service Seller'),
        actions: [
          IconButton(
            icon: const Icon(Icons.account_balance_wallet),
            onPressed: () => Navigator.pushNamed(context, '/wallet'),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.count(
          crossAxisCount: 2,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          children: [
            _ServiceCard(
              title: 'Buy Data',
              icon: Icons.data_usage,
              color: Colors.blue,
              onTap: () => Navigator.pushNamed(context, '/data'),
            ),
            _ServiceCard(
              title: 'Buy Airtime',
              icon: Icons.phone_android,
              color: Colors.green,
              onTap: () => Navigator.pushNamed(context, '/airtime'),
            ),
            _ServiceCard(
              title: 'TV Subscription',
              icon: Icons.tv,
              color: Colors.orange,
              onTap: () => Navigator.pushNamed(context, '/tv'),
            ),
            _ServiceCard(
              title: 'KEDCO Payment',
              icon: Icons.electric_bolt,
              color: Colors.yellow,
              onTap: () => Navigator.pushNamed(context, '/kedco'),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.history), label: 'History'),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Settings'),
        ],
        currentIndex: 0,
        onTap: (index) {
          // TODO: Implement navigation
        },
      ),
    );
  }
}

class _ServiceCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final Color color;
  final VoidCallback onTap;

  const _ServiceCard({
    required this.title,
    required this.icon,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 48, color: color),
              const SizedBox(height: 8),
              Text(
                title,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ],
          ),
        ),
      ),
    );
  }
}