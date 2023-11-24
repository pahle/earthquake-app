import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'API/gempa.dart';
import 'API/gempa_service.dart';
import 'detail_page.dart';

class MapPage extends StatefulWidget {
 const MapPage({Key? key}) : super(key: key);

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  Future<Map<String, dynamic>>? gempaData;

  @override
  void initState() {
    super.initState();
    // Load gempa data when the screen initializes
    gempaData = GempaService.instance.loadDaftarGempa();
  }

  // getAllGempa
  List<Gempa> getAllGempa(List<Gempa> gempa) {
    final List<Gempa> gempaList = [];
    for (var i = 0; i < gempa.length; i++) {
      gempaList.add(Gempa(
        tanggal: gempa[i].tanggal,
        jam: gempa[i].jam,
        dateTime: gempa[i].dateTime,
        coordinates: gempa[i].coordinates,
        lintang: gempa[i].lintang,
        bujur: gempa[i].bujur,
        magnitude: gempa[i].magnitude,
        kedalaman: gempa[i].kedalaman,
        wilayah: gempa[i].wilayah,
        potensi: gempa[i].potensi,
      ));
    }
    return gempaList;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: const Text(
          'Earthquake Map',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.w700),
        ),
        backgroundColor: Colors.transparent,
      ),
      body: FutureBuilder<Map<String, dynamic>>(
        future: gempaData,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            // Display a loading indicator while waiting for data
            return const CircularProgressIndicator();
          } else if (snapshot.hasError) {
            // Display an error message if there's an error
            return const Center(
              child: Text('Error loading data'),
            );
          } else {
            // Display the gempa data
            final gempaModel = GempaModel.fromJson(snapshot.data!);
            final gempa = gempaModel.infogempa?.gempa;

            return FlutterMap(
              options: const MapOptions(
                initialCenter: LatLng(3.498904,116.130988), // Initial map center
                initialZoom: 4.0, // Initial zoom level
              ),
              children: [
                TileLayer(
                  urlTemplate:
                      'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
                  subdomains: const ['a', 'b', 'c'],
                ),
                MarkerLayer(
                  markers: getAllGempa(gempa ?? [])
                      .map(
                        (gempaList) => Marker(
                          width: 100.0,
                          height: 50.0,
                          point: gempaList.coordinates != null
                              ? LatLng(
                                  double.parse(gempaList.coordinates!
                                      .split(",")[0]),
                                  double.parse(gempaList.coordinates!
                                      .split(",")[1]),
                                )
                              : const LatLng(0.0, 0.0),
                          child: InkWell(
                            onTap: () {
                              Navigator.push(context, MaterialPageRoute(builder: (context) => DetailPage(gempa: gempaList)));
                            },
                            child: Stack(
                              children: [
                                const SizedBox(height: 10),
                                const Icon(
                                  Icons.location_on,
                                  color: Colors.red,
                                  size: 30,
                                ),
                                Positioned(
                                  top: 25,
                                  left: 3,
                                  child: Text(gempaList.magnitude ?? '0.0',
                                    style: const TextStyle(
                                        color: Colors.red,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15)),
                                )
                                
                              ],
                            ),
                          ),
                        ),
                      )
                      .toList(),
                )
              ],
            );
          }
        },
      ),
    );
  }
}
