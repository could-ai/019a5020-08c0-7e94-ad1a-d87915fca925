import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'screens/home_screen.dart';
import 'screens/data_screen.dart';
import 'screens/airtime_screen.dart';
import 'screens/tv_screen.dart';
import 'screens/kedco_screen.dart';
import 'screens/wallet_screen.dart';
import 'providers/wallet_provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => WalletProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Service Seller App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const HomeScreen(),
        '/data': (context) => const DataScreen(),
        '/airtime': (context) => const AirtimeScreen(),
        '/tv': (context) => const TvScreen(),
        '/kedco': (context) => const KedcoScreen(),
        '/wallet': (context) => const WalletScreen(),
      },
    );
  }
}