import 'package:flutter/material.dart';
import 'package:tugas_akhir/report.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:tugas_akhir/add_report_page.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

class ReportPage extends StatefulWidget {
  const ReportPage({Key? key}) : super(key: key);

  @override
  State<ReportPage> createState() => _ReportPageState();
}

class _ReportPageState extends State<ReportPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Report Page"),
      ),
      body: ValueListenableBuilder(
        valueListenable: Hive.box<Report>('reportsBox').listenable(),
        builder: (context, Box<Report> box, _) {
          print(box.values.first.imagePath);
          if (box.values.isEmpty) {
            return const Center(child: Text("No Report"));
          } else {
            return ListView.separated(
              itemCount: box.values.length,
              itemBuilder: (context, index) {
                var result = box.getAt(index);

                return Container(
                  margin: EdgeInsets.only(left: 20, right: 20,),
                  child: Card(
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    child: Column(
                      children: [
                        Container(
                          width: double.infinity,
                          height: 200,
                          decoration: BoxDecoration(
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(15),
                              topRight: Radius.circular(15),
                            ),
                            image: DecorationImage(
                              fit: BoxFit.cover,
                              image: result!.imagePath.isNotEmpty
                                  ? FileImage(File(result.imagePath))
                                      as ImageProvider<Object>
                                  : const AssetImage('assets/images/profile.jpeg'),
                            ),
                          ),
                        ),
                        ListTile(
                          contentPadding: const EdgeInsets.all(20),
                          title: Text(result!.kerusakan, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                          subtitle: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(result.wilayah, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
                              const SizedBox(width: 10),
                              const Text("-"),
                              const SizedBox(width: 10),
                              Text(result.tanggal, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
                            ],
                          ),
                          trailing: InkWell(
                            child: const Icon(
                              Icons.remove_circle,
                              color: Colors.red,
                            ),
                            onTap: () {
                              box.deleteAt(index);
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
              separatorBuilder: (context, i) {
                return const SizedBox(height: 12);
              },
            );
          }
        },
      ),
    );
  }
}
