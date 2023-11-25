import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TimeConvertPage extends StatefulWidget {
  const TimeConvertPage({super.key});

  @override
  TimeConvertPageState createState() => TimeConvertPageState();
}

class TimeConvertPageState extends State<TimeConvertPage> {
  final TextEditingController _inputController = TextEditingController();
  String _fromTimeZone = 'WIB';
  String _toTimeZone = 'WIT';
  String _convertedTime = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Time Converter'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _inputController,
              keyboardType: TextInputType.text,
              decoration: const InputDecoration(labelText: 'Enter Time (HH:mm:ss)', border: OutlineInputBorder()),
              onChanged: (value) => _convertTime(),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                DropdownButton<String>(
                  value: _fromTimeZone,
                  onChanged: (newValue) {
                    setState(() {
                      _fromTimeZone = newValue!;
                    });
                    _convertTime();
                  },
                  items: ['WIB', 'WIT', 'WITA'].map((timeZone) {
                    return DropdownMenuItem<String>(
                      value: timeZone,
                      child: Text(timeZone),
                    );
                  }).toList(),
                ),
                const Text('to'),
                DropdownButton<String>(
                  value: _toTimeZone,
                  onChanged: (newValue) {
                    setState(() {
                      _toTimeZone = newValue!;
                    });
                    _convertTime();
                  },
                  items: ['WIB', 'WIT', 'WITA', 'London'].map((timeZone) {
                    return DropdownMenuItem<String>(
                      value: timeZone,
                      child: Text(timeZone),
                    );
                  }).toList(),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Text(
              'Converted Time: $_convertedTime',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }

  void _convertTime() {
    String inputTime = _inputController.text;

    try {
      DateTime parsedTime = DateFormat('HH:mm:ss').parse(inputTime);

      // Convert time zones
      DateTime convertedTime;
      switch (_fromTimeZone) {
        case 'WIB':
          convertedTime = parsedTime.add(const Duration(hours: 7));
          break;
        case 'WIT':
          convertedTime = parsedTime.add(const Duration(hours: 9));
          break;
        case 'WITA':
          convertedTime = parsedTime.add(const Duration(hours: 8));
          break;
        default:
          // London time
          convertedTime = parsedTime.toUtc();
          break;
      }

      switch (_toTimeZone) {
        case 'WIB':
          convertedTime = convertedTime.subtract(const Duration(hours: 7));
          break;
        case 'WIT':
          convertedTime = convertedTime.subtract(const Duration(hours: 9));
          break;
        case 'WITA':
          convertedTime = convertedTime.subtract(const Duration(hours: 8));
          break;
        default:
          // London time
          convertedTime = convertedTime.toLocal();
          break;
      }

      // Format the result time
      _convertedTime = DateFormat('HH:mm:ss').format(convertedTime);
    } catch (e) {
      // Handle invalid time input
      _convertedTime = 'Invalid time format';
    }

    setState(() {});
  }
}
