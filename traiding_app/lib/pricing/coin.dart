import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';
import 'dart:convert';


class Coin extends StatefulWidget {
  const Coin({super.key});

  @override
  State<Coin> createState() => _CoinState();
}

class _CoinState extends State<Coin> {
  List<String> coins = [];
  bool isLoading = false;
  String errorMessage = '';

  @override
  void initState() {
    super.initState();
    fetchCoinNames();
  }

  Future<void> fetchCoinNames() async {
    setState(() {
      isLoading = true;
      errorMessage = '';
    });

    try {
      final response = await http.get(
        Uri.parse('https://pro-api.coinmarketcap.com/v1/cryptocurrency/listings/latest'),
        headers: {
          'X-CMC_PRO_API_KEY': '50e10960-2a2f-49f0-8f2d-a3c81e8f5d2c', // Replace with your actual API key
        },
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final coinsData = data['data'] as List;
        coins = coinsData.map((coin) => coin['name'] as String).toList();
      } else {
        throw Exception('Failed to fetch coin names');
      }
    } catch (error) {
      setState(() {
        errorMessage = 'Error fetching data: $error';
      });
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (errorMessage.isNotEmpty) {
      return Center(child: Text(errorMessage));
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Crypto Coins'),
      ),
      body: ListView.builder(
        itemCount: coins.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(coins[index]),
            onTap: () {
              launchUrl(Uri.parse('https://coinmarketcap.com/currencies/${coins[index]}/'));
            },
          );
        },
      ),
    );
  }
}
