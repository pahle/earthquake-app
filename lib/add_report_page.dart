import 'package:flutter/material.dart';
import 'package:tugas_akhir/report.dart';
import 'package:hive_flutter/adapters.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

class AddReportPage extends StatefulWidget {
  AddReportPage({super.key});

  @override
  State<AddReportPage> createState() => _AddReportPageState();
}

class _AddReportPageState extends State<AddReportPage> {
  File? imageFile;

  final _kerusakan = TextEditingController();

  final _wilayah = TextEditingController();

  final _tanggal = TextEditingController();

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
              decoration: const InputDecoration(
                hintText: 'Kerusakan',
                border: OutlineInputBorder(),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black),
                ),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            TextFormField(
              controller: _wilayah,
              decoration: const InputDecoration(
                hintText: 'Wilayah',
                border: OutlineInputBorder(),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black),
                ),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            TextFormField(
              controller: _tanggal,
              decoration: const InputDecoration(
                hintText: 'Tanggal',
                border: OutlineInputBorder(),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black),
                ),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            _buildImage(),
            const SizedBox(
              height: 15,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(
                    onPressed: () async {
                      XFile? imagePicked = await ImagePicker()
                          .pickImage(source: ImageSource.gallery);

                      setState(() {
                        imageFile = File(imagePicked!.path);
                      });
                    },
                    icon: const Icon(Icons.photo_library)),
                IconButton(
                    onPressed: () async {
                      XFile? imagePicked = await ImagePicker()
                          .pickImage(source: ImageSource.camera);

                      setState(() {
                        imageFile = File(imagePicked!.path);
                      });
                    },
                    icon: const Icon(Icons.camera_alt)),
              ],
            ),
            const SizedBox(height: 15),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
              onPressed: () => _addNewReport(context),
              child: const Text("Add"),
            ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildImage() {
    return Container(
      width: double.infinity,
      height: 200,
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(10),
      ),
      child: imageFile == null
          ? const Center(child: Text('No image selected'))
          : Image.file(imageFile!, fit: BoxFit.cover),
    );
  }

  _addNewReport(BuildContext context) async {
    await Hive.box<Report>('reportsBox').put(
      DateTime.now().toString(),
      Report(
        kerusakan: _kerusakan.text,
        wilayah: _wilayah.text,
        tanggal: _tanggal.text,
        imagePath: imageFile?.path ??
            '', // Use the image path or an empty string if no image
      ),
    );
    Navigator.pop(context);
  }
}
