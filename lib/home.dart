import 'package:flutter/material.dart';
import 'package:tugas_akhir/add_report_page.dart';
import 'package:tugas_akhir/kesan_page.dart';
import 'package:tugas_akhir/login_page.dart';
import 'package:tugas_akhir/money_convert_page.dart';
import 'package:tugas_akhir/profile_page.dart';
import 'package:tugas_akhir/report_page.dart';
import 'package:tugas_akhir/time_convert_page.dart';
import 'API/gempa_service.dart';
import 'API/gempa.dart';
import 'ruler_view.dart';
import 'map_page.dart';
import 'detail_page.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class Home extends StatefulWidget {
  const Home({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  HomeState createState() => HomeState();
}

class HomeState extends State<Home> {
  Future<Map<String, dynamic>>? gempaData;

  @override
  void initState() {
    super.initState();
    // Load gempa data when the screen initializes
    gempaData = GempaService.instance.loadDaftarGempa();
  }

  String? extractEarthquakeLocation(String? fullLocation) {
    if (fullLocation == null) return null;

    RegExp regex = RegExp(r'(\d+\s*[^\d]+)');
    Match? match = regex.firstMatch(fullLocation);
    return match?.group(0);
  }

  // Convert Coordinates String to Double
  double coordinatesToFloat(String? coordinates) {
    if (coordinates == null) return 0.0;

    return double.parse(coordinates);
  }

  // Earthquakes Card using builder to map through the array of gempa
  Widget buildEarthquakeCard(Gempa? gempa) {
    return InkWell(
      onTap: () {
        // Navigate to the detail page with the gempa data
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DetailPage(gempa: gempa),
          ),
        );
      },
      child: Container(
        width: 300,
        height: 200,
        margin: const EdgeInsets.only(right: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              gempa?.wilayah ?? '0.0',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
            ),
            Text(
              gempa?.magnitude ?? '0.0',
              style: TextStyle(fontSize: 50, fontWeight: FontWeight.w700),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '${gempa?.kedalaman ?? '0.0'} depth',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                ),
                SizedBox(width: 10),
                Text(
                  gempa?.tanggal ?? '0.0',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text(
          widget.title,
          style:
              const TextStyle(color: Colors.white, fontWeight: FontWeight.w700),
        ),
        backgroundColor: Colors.transparent,
        leading: Builder(
          builder: (context) => IconButton(
            icon: const Icon(Icons.menu),
            color: Colors.white,
            tooltip: 'Menu',
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.map),
            color: Colors.white,
            tooltip: 'Map',
            onPressed: () {
              // Navigate to the map page with coordinates
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const MapPage(),
                ),
              );
            },
          ),
        ],
      ),
      body: FutureBuilder<Map<String, dynamic>>(
        future: gempaData,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            // Display a loading indicator while waiting for data
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            // Display an error message if there's an error
            return const Center(
              child: Text('Error loading data'),
            );
          } else {
            // Display the gempa data
            final gempaModel = GempaModel.fromJson(snapshot.data!);
            final gempa = gempaModel.infogempa?.gempa;

            return Center(
              child: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.black54,
                      Colors.black26,
                    ],
                  ),
                ),
                child: Center(
                  child: Container(
                    margin: const EdgeInsets.only(top: 100),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          gempa?[0].magnitude != null
                              ? double.parse(gempa?[0].magnitude ?? '0.0') > 7.0
                                  ? 'Very Strong'
                                  : double.parse(gempa?[0].magnitude ?? '0.0') >
                                          5.0
                                      ? 'Strong'
                                      : double.parse(gempa?[0].magnitude ??
                                                  '0.0') >
                                              3.0
                                          ? 'Moderate'
                                          : 'Light'
                              : 'Not Available',
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 50,
                              fontWeight: FontWeight.w700),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          extractEarthquakeLocation(gempa?[0].wilayah) ??
                              'Not Available',
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.w500),
                          textAlign: TextAlign.center,
                        ),
                        Text(
                          gempa?[0].magnitude ?? '0.0',
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 100,
                              fontWeight: FontWeight.w700),
                        ),
                        Text(
                          '${gempa?[0].kedalaman ?? '0.0'} depth',
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.w500),
                        ),
                        SizedBox(
                          width: 400,
                          height: 500,
                          child: Stack(
                            children: [
                              RulerView(
                                  size: 400, magnitude: gempa?[0].magnitude),
                              const Positioned(
                                top: 50.0,
                                left: 0,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      '1.0 - 2.0',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    SizedBox(width: 237),
                                    Text(
                                      '9.0 - 10.0',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                              ),
                              Positioned(
                                top: 180.0,
                                left: 0,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Icon(
                                      Icons.calendar_month,
                                      size: 24.0,
                                      color: Colors.white,
                                    ),
                                    const SizedBox(width: 10),
                                    Text(
                                      gempa?[0].tanggal ?? 'Not Available',
                                      style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 18,
                                          fontWeight: FontWeight.w500),
                                    ),
                                    const SizedBox(width: 90),
                                    const Icon(
                                      Icons.timelapse,
                                      size: 24.0,
                                      color: Colors.white,
                                    ),
                                    const SizedBox(width: 10),
                                    Text(
                                      gempa?[0].jam ?? 'Not Available',
                                      style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 18,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ],
                                ),
                              ),
                              Positioned(
                                top: 0,
                                child: SizedBox(
                                  height: 100,
                                  width: 100,
                                  child: ListView(
                                    shrinkWrap: true,
                                    children: [
                                      const SizedBox(height: 100),
                                      Text(
                                        gempa?[0].wilayah ?? 'Not Available',
                                        style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 18,
                                            fontWeight: FontWeight.w500),
                                        textAlign: TextAlign.center,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              const Positioned(
                                top: 250,
                                child: Text('Latest Earthquake',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 24,
                                        fontWeight: FontWeight.w700)),
                              ),
                              // Card that can scrolled horizontaly
                              Positioned(
                                top: 300,
                                bottom: 0,
                                left: 0,
                                right: 0,
                                child: SizedBox(
                                  height: 200,
                                  width: 200,
                                  child: ListView.builder(
                                    shrinkWrap: true,
                                    scrollDirection: Axis.horizontal,
                                    itemCount: gempa
                                        ?.length, // Change this to the number of cards you want to display
                                    itemBuilder: (context, index) {
                                      return buildEarthquakeCard(gempa?[index]);
                                    },
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          }
        },
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
                decoration: const BoxDecoration(
                  color: Colors.black54,
                ),
                child: Row(
                  children: [
                    const Text(
                      'Earthquake App',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                      ),
                    ),
                    const SizedBox(
                      width: 35,
                    ),
                    IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(Icons.close),
                      color: Colors.white,
                    )
                  ],
                )),
            ListTile(
              leading: const Icon(Icons.home),
              title: const Text('Home'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            Builder(
              builder: (context) => ListTile(
                leading: const Icon(Icons.report),
                title: const Text('Reports'),
                onTap: () {
                  Scaffold.of(context).closeDrawer();
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ReportPage(),
                    ),
                  );
                },
              ),
            ),
            Builder(
              builder: (context) => ListTile(
                leading: const Icon(Icons.add),
                title: const Text('Add Reports'),
                onTap: () {
                  Scaffold.of(context).closeDrawer();
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AddReportPage(),
                    ),
                  );
                },
              ),
            ),
            Builder(
              builder: (context) => ListTile(
                leading: const Icon(Icons.person),
                title: const Text('Profile'),
                onTap: () {
                  Scaffold.of(context).closeDrawer();
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ProfilePage(),
                    ),
                  );
                },
              ),
            ),
            Builder(
              builder: (context) => ListTile(
                leading: const Icon(Icons.money),
                title: const Text('Money Converter'),
                onTap: () {
                  Scaffold.of(context).closeDrawer();
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const MoneyConvertPage(),
                    ),
                  );
                },
              ),
            ),
            Builder(
              builder: (context) => ListTile(
                leading: const Icon(Icons.timelapse),
                title: const Text('Time Converter'),
                onTap: () {
                  Scaffold.of(context).closeDrawer();
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const TimeConvertPage(),
                    ),
                  );
                },
              ),
            ),
            Builder(
              builder: (context) => ListTile(
                leading: const Icon(Icons.feedback),
                title: const Text('Kesan & Pesan'),
                onTap: () {
                  Scaffold.of(context).closeDrawer();
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const KesanPage(),
                    ),
                  );
                },
              ),
            ),
            // Logout
            Builder(
              builder: (context) => ListTile(
                leading: const Icon(Icons.logout),
                title: const Text('Logout'),
                onTap: () async {
                  Scaffold.of(context).closeDrawer();
                  await const FlutterSecureStorage().write(key: 'is_logged_in', value: 'false');
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return const LoginPage();
                      },
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
