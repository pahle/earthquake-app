import 'package:flutter/material.dart';
import 'API/gempa.dart';

class DetailPage extends StatefulWidget {
  final Gempa? gempa;

  const DetailPage({Key? key, required this.gempa}) : super(key: key);

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Earthquake Detail',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.w700),
        ),
        backgroundColor: Colors.transparent,
      ),
      body: Container(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Magnitude: ${widget.gempa?.magnitude ?? 'N/A'}',
                style: const TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
              ),
              Text(
                'Location: ${widget.gempa?.wilayah ?? 'N/A'}',
                style: const TextStyle(fontSize: 18.0),
              ),
              Text(
                'Date: ${widget.gempa?.tanggal ?? 'N/A'}',
                style: const TextStyle(fontSize: 18.0),
              ),
              Text(
                'Time: ${widget.gempa?.jam ?? 'N/A'}',
                style: const TextStyle(fontSize: 18.0),
              ),
              Text(
                'Coordinates: ${widget.gempa?.coordinates ?? 'N/A'}',
                style: const TextStyle(fontSize: 18.0),
              ),
              Text(
                'Depth: ${widget.gempa?.kedalaman ?? 'N/A'}',
                style: const TextStyle(fontSize: 18.0),
              ),
              Text(
                'Potential: ${widget.gempa?.potensi ?? 'N/A'}',
                style: const TextStyle(fontSize: 18.0),
              ),
              Text(
                'Latitude: ${widget.gempa?.lintang ?? 'N/A'}',
                style: const TextStyle(fontSize: 18.0),
              ),
              Text(
                'Longitude: ${widget.gempa?.bujur ?? 'N/A'}',
                style: const TextStyle(fontSize: 18.0),
              ),
              // Add more information as needed
            ],
          ),
        ),
      ),
    );
  }
}
