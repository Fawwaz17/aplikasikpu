import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Geo Tagging',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: const MyHomePage(title: 'Demo Aplikasi Geo Tagging'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String strAlamat = 'Belum Mendapatkan Alamat, Silahkan tekan tombol';
  bool loading = false;
  final TextEditingController _alamatController = TextEditingController();

  //getLatLong
  Future<Position> _getGeoLocationPosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    //location service not enabled, don't continue
    if (!serviceEnabled) {
      await Geolocator.openLocationSettings();
      return Future.error('Location service Not Enabled');
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permission denied');
      }
    }

    //permission denied forever
    if (permission == LocationPermission.deniedForever) {
      return Future.error(
        'Location permission denied forever, we cannot access',
      );
    }
    //continue accessing the position of device
    return await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
  }

  // //getAddress
  Future<void> getAddressFromLongLat(Position position) async {
    List<Placemark> placemarks =
        await placemarkFromCoordinates(position.latitude, position.longitude);
    Placemark place = placemarks[0];
    setState(() {
      strAlamat = '${place.street}, ${place.subLocality}, ${place.locality}, '
          '${place.postalCode}, ${place.country}';
      _alamatController.text = strAlamat; // Update the TextEditingController
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Alamat',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              TextField(
                controller: _alamatController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Alamat akan muncul di sini',
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              loading
                  ? const CircularProgressIndicator()
                  : TextButton(
                      onPressed: () async {
                        setState(() {
                          loading = true;
                          strAlamat = 'Mencari lokasi...';
                        });

                        Position position = await _getGeoLocationPosition();
                        await getAddressFromLongLat(position);

                        setState(() {
                          loading = false;
                        });
                      },
                      child: Text(
                        loading ? 'Mengecek' : 'Cek Lokasi',
                        style: const TextStyle(color: Colors.blue),
                      ),
                    )
            ],
          ),
        ),
      ),
    );
  }
}
