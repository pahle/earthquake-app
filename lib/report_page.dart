import 'package:flutter/material.dart';
import 'package:tugas_akhir/report.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:tugas_akhir/add_report_page.dart';

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
          if (box.values.isEmpty) {
            return const Center(child: Text("No Report"));
          } else {
            return ListView.separated(
              itemCount: box.values.length,
              itemBuilder: (context, index) {
                var result = box.getAt(index);

                return Card(
                  child: ListTile(
                    title: Text(result!.kerusakan),
                    subtitle: Row(children: [
                      Text(result.wilayah),
                      const SizedBox(width: 10),
                      Text(result.tanggal),
                    ]),
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
                );
              },
              separatorBuilder: (context, i) {
                return const SizedBox(height: 12);
              },
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () => _navigateToAddReport(context),
      ),
    );
  }

  _navigateToAddReport(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => AddReportPage()),
    );
  }
}
