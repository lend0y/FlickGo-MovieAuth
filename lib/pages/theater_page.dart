import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart' as geo;
import 'package:geolocator/geolocator.dart';
import '../theme.dart';

class TheaterPage extends StatefulWidget {
  const TheaterPage({super.key});

  @override
  State<TheaterPage> createState() => _TheaterPageState();
}

class _TheaterPageState extends State<TheaterPage> {
  String? currentCity;
  bool loading = true;

  final theaters = const [
    'XI CINEMA',
    'PONDOK KELAPA 21',
    'CGV',
    'CINEPOLIS',
    'CP MALL',
    'HERMES',
  ];

  @override
  void initState() {
    super.initState();
    _loadCity();
  }

  Future<void> _loadCity() async {
    try {
      var permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
      }
      final pos = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.medium);
      final placemarks = await geo.placemarkFromCoordinates(pos.latitude, pos.longitude);
      final place = placemarks.isNotEmpty ? placemarks.first : null;
      setState(() {
        currentCity = place?.subAdministrativeArea ?? place?.administrativeArea ?? place?.locality ?? 'Unknown';
        loading = false;
      });
    } catch (_) {
      setState(() {
        currentCity = 'Medan';
        loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF303A55),
        leading: IconButton(onPressed: () {}, icon: const Icon(Icons.arrow_back_ios_new, size: 18)),
        centerTitle: true,
        title: const Text('THEATER', style: TextStyle(letterSpacing: 1.2, fontWeight: FontWeight.w700)),
      ),
      body: Column(
        children: [
          Container(
            color: const Color(0xFF303A55),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Row(
              children: [
                const Icon(Icons.location_on_outlined, color: Colors.white),
                const SizedBox(width: 8),
                Expanded(
                  child: loading
                      ? const Text('Mendeteksi lokasi…')
                      : Text(currentCity ?? '-', style: const TextStyle(fontWeight: FontWeight.w600)),
                ),
                const Icon(Icons.expand_more),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: theaters.length,
              itemBuilder: (context, i) {
                final name = theaters[i];
                return Card(
                  margin: const EdgeInsets.symmetric(vertical: 6),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  child: ListTile(
                    title: Text(name, style: const TextStyle(fontWeight: FontWeight.w600)),
                    trailing: const Icon(Icons.expand_more),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
