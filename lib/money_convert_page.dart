import 'package:flutter/material.dart';

class MoneyConvertPage extends StatefulWidget {
  const MoneyConvertPage({super.key});

  @override
  MoneyConvertPageState createState() => MoneyConvertPageState();
}

class MoneyConvertPageState extends State<MoneyConvertPage> {
  final TextEditingController _inputController = TextEditingController();
  String _fromCurrency = 'IDR';
  String _toCurrency = 'USD';
  double _convertedValue = 0.0;

  // Conversion rates (for demonstration purposes)
  final Map<String, double> conversionRates = {
    'IDR': 1.0,
    'USD': 0.000070, // Example: 1 IDR = 0.000070 USD
    'EUR': 0.000059, // Example: 1 USD = 0.000059 EUR
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Currency Converter'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _inputController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: 'Enter Amount', border: OutlineInputBorder()),
              onChanged: (value) => _convertCurrency(),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                DropdownButton<String>(
                  value: _fromCurrency,
                  onChanged: (newValue) {
                    setState(() {
                      _fromCurrency = newValue!;
                    });
                    _convertCurrency();
                  },
                  items: conversionRates.keys.map((currency) {
                    return DropdownMenuItem<String>(
                      value: currency,
                      child: Text(currency),
                    );
                  }).toList(),
                ),
                const Text('to'),
                DropdownButton<String>(
                  value: _toCurrency,
                  onChanged: (newValue) {
                    setState(() {
                      _toCurrency = newValue!;
                    });
                    _convertCurrency();
                  },
                  items: conversionRates.keys.map((currency) {
                    return DropdownMenuItem<String>(
                      value: currency,
                      child: Text(currency),
                    );
                  }).toList(),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Text(
              'Converted Value: $_convertedValue $_toCurrency',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }

  void _convertCurrency() {
    double inputValue = double.tryParse(_inputController.text) ?? 0.0;
    double conversionRate =
        conversionRates[_toCurrency]! / conversionRates[_fromCurrency]!;
    double convertedValue = inputValue * conversionRate;

    convertedValue = double.parse(convertedValue.toStringAsFixed(4));

    setState(() {
      _convertedValue = convertedValue;
    });
  }
}
