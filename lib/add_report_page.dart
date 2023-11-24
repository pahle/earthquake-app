import 'package:flutter/material.dart';
import 'package:tugas_akhir/report.dart';
import 'package:hive_flutter/adapters.dart';

class AddReportPage extends StatelessWidget {
  final _kerusakan = TextEditingController();
  final _wilayah = TextEditingController();
  final _tanggal = TextEditingController();

  AddReportPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("New Report"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              controller: _kerusakan,
              decoration: const InputDecoration(hintText: 'Kerusakan'),
            ),
            const SizedBox(
              height: 15,
            ),
            TextFormField(
              controller: _wilayah,
              decoration: const InputDecoration(hintText: 'Wilayah'),
            ),
            const SizedBox(
              height: 15,
            ),
            TextFormField(
              controller: _tanggal,
              decoration: const InputDecoration(hintText: 'Tanggal'),
            ),
            const SizedBox(
              height: 15,
            ),
            ElevatedButton(
              onPressed: () => _addNewReport(context),
              child: const Text("Add"),
            ),
          ],
        ),
      ),
    );
  }

  _addNewReport(BuildContext context) async {
    await Hive.box<Report>('reportsBox').put(
      DateTime.now().toString(),
      Report(
        kerusakan: _kerusakan.text,
        wilayah: _wilayah.text,
        tanggal: _tanggal.text,
      ),
    );    
    Navigator.pop(context);
  }
}

