import 'dart:io';

import 'package:aplikasikpu/models/database.dart';
import 'package:drift/drift.dart' hide Column;
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:intl/intl.dart';

class FormEntryPage extends StatefulWidget {
  final MyDatabase database;

  const FormEntryPage({super.key, required this.database});
  @override
  _FormEntryPageState createState() => _FormEntryPageState();
}

class _FormEntryPageState extends State<FormEntryPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nikController = TextEditingController();
  final TextEditingController _namaController = TextEditingController();
  final TextEditingController _nohpController = TextEditingController();
  final TextEditingController _alamatController = TextEditingController();

  //tanggal
  late TextEditingController _tanggalController;
  late DateTime selectedDate;
  @override
  void initState() {
    super.initState();
    _tanggalController = TextEditingController();
    selectedDate = DateTime.now();
  }

  @override
  void dispose() {
    _tanggalController.dispose();
    super.dispose();
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2010),
      lastDate: DateTime(2101),
    );
    if (pickedDate != null && pickedDate != selectedDate) {
      setState(() {
        selectedDate = pickedDate;
        _tanggalController.text =
            DateFormat('dd MMMM yyyy').format(selectedDate);
      });
    }
  }

  //gender
  String? _gender;
  String? _getDisplayGender(String? value) {
    if (value == 'L') {
      return 'Laki-laki';
    } else if (value == 'P') {
      return 'Perempuan';
    } else {
      return null;
    }
  }

  //image
  File? image;
  final picker = ImagePicker();
  Future<void> _getImage(ImageSource source) async {
    final pickedFile = await picker.getImage(source: source);
    if (pickedFile != null) {
      setState(() {
        image = File(pickedFile.path);
      });
    }
  }

  Future<String> saveImageFile(File image) async {
    final directory = await getApplicationDocumentsDirectory();
    final imagePath =
        '${directory.path}/${DateTime.now().millisecondsSinceEpoch}.png';
    final savedImage = await image.copy(imagePath);
    return savedImage.path;
  }

  //location
  String strAlamat = '';
  bool loading = false;
  //getLatLong
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

  //getAddress
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

  //submit form
  Future<void> submitForm() async {
    if (_formKey.currentState!.validate() && _gender != null && image != null) {
      final imagePath = await saveImageFile(image!);
      final newPerson = PersonsCompanion(
          nik: Value(_nikController.text),
          nama: Value(_namaController.text),
          nohp: Value(_nohpController.text),
          tanggal: Value(_tanggalController.text),
          alamat: Value(_alamatController.text),
          image: Value(imagePath),
          gender: Value(_gender));
      await widget.database.addPerson(newPerson);
      // Fetch and print the latest added person
      final List<Person> people = await widget.database.getAllPersons();
      final addedPerson = people
          .last; // Assuming the last added person is the one we just inserted
      print(
          'Added person: ${addedPerson.nama}, ${addedPerson.nik}, ${addedPerson.nohp}, ${addedPerson.tanggal}, ${addedPerson.alamat}');
      // Jika semua validasi terpenuhi
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Formulir telah dikirim')),
      );
      _namaController.clear();
      _nikController.clear();
      _alamatController.clear();
      _nohpController.clear();
      _tanggalController.clear();
      setState(() {
        _gender = null;
        image = null;
      });
    } else if (_gender == null ||
        image == null ||
        !_formKey.currentState!.validate()) {
      // Jika gender belum dipilih
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Inputkan semua data')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Halaman Formulir'),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop(); // Aksi kembali
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsetsDirectional.symmetric(
              vertical: 40, horizontal: 24),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  children: [
                    const SizedBox(
                      width: 64,
                      child: Text(
                        'NIK',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ),
                    const SizedBox(width: 24),
                    Expanded(
                      child: TextFormField(
                        controller: _nikController,
                        decoration: const InputDecoration(
                          hintText: 'Masukkan NIK',
                          border: OutlineInputBorder(),
                        ),
                        keyboardType: TextInputType.number,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'NIK belum diinput';
                          }
                          return null;
                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24.0),
                Row(
                  children: [
                    const SizedBox(
                      width: 64,
                      child: Text(
                        'Nama',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ),
                    const SizedBox(width: 24),
                    Expanded(
                      child: TextFormField(
                        controller: _namaController,
                        decoration: const InputDecoration(
                          hintText: 'Masukkan Nama',
                          border: OutlineInputBorder(),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Nama belum diinput';
                          }
                          return null;
                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24.0),
                Row(
                  children: [
                    const SizedBox(
                      width: 64,
                      child: Text(
                        'No. HP',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ),
                    const SizedBox(width: 24),
                    Expanded(
                      child: TextFormField(
                        controller: _nohpController,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          hintText: 'Masukkan No. Handphone',
                          border: OutlineInputBorder(),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'No. HP belum diinput';
                          }
                          return null;
                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                Row(
                  children: [
                    const SizedBox(
                      width: 64,
                      child: Text('Jenis Kelamin',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold)),
                    ),
                    Expanded(
                      child: ListTile(
                        title: const Text('L'),
                        leading: Radio<String>(
                          value: 'L',
                          groupValue: _gender,
                          onChanged: (String? value) {
                            setState(() {
                              _gender = value;
                            });
                          },
                        ),
                      ),
                    ),
                    Expanded(
                      child: ListTile(
                        title: const Text('P'),
                        leading: Radio<String>(
                          value: 'P',
                          groupValue: _gender,
                          onChanged: (String? value) {
                            setState(() {
                              _gender = value;
                            });
                          },
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24.0),
                Row(
                  children: [
                    const SizedBox(
                      width: 64,
                      child: Text(
                        'Tanggal',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ),
                    const SizedBox(width: 24),
                    Expanded(
                      child: TextFormField(
                        controller: _tanggalController,
                        readOnly: true,
                        onTap: () => _selectDate(context),
                        decoration: InputDecoration(
                          hintText: 'Masukkan Tanggal',
                          border: OutlineInputBorder(),
                          suffixIcon: IconButton(
                            onPressed: () => _selectDate(context),
                            icon: Icon(Icons.calendar_today),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Tanggal belum diinput';
                          }
                          return null;
                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24.0),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Row(
                      children: [
                        const SizedBox(
                          width: 64,
                          child: Text(
                            'Alamat',
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                        ),
                        const SizedBox(width: 24),
                        Expanded(
                          child: TextFormField(
                            controller: _alamatController,
                            decoration: const InputDecoration(
                              hintText: 'Masukkan Alamat',
                              border: OutlineInputBorder(),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Alamat belum diinput';
                              }
                              return null;
                            },
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 12,
                    ),
                    TextButton(
                      onPressed: () async {
                        setState(() {
                          loading = true;
                        });

                        try {
                          Position position = await _getGeoLocationPosition();
                          await getAddressFromLongLat(position);
                        } finally {
                          setState(() {
                            loading = false;
                          });
                        }
                      },
                      child: Text(
                        loading ? 'Mengecek' : 'Cek Lokasi',
                        style: TextStyle(color: Colors.blue),
                      ),
                    )
                  ],
                ),
                const SizedBox(height: 24.0),
                Column(
                  children: [
                    Row(
                      children: [
                        const SizedBox(
                          width: 64,
                          child: Text(
                            'Gambar',
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                        ),
                        const SizedBox(width: 24),
                        Expanded(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Expanded(
                                child: ElevatedButton(
                                  onPressed: () {
                                    _getImage(ImageSource.gallery);
                                  },
                                  child: Text('Galeri'),
                                  style: ElevatedButton.styleFrom(
                                      elevation: 0,
                                      foregroundColor: Colors.blue,
                                      backgroundColor: Colors.transparent,
                                      side: BorderSide(color: Colors.blue)),
                                ),
                              ),
                              SizedBox(
                                width: 12,
                              ),
                              Expanded(
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      elevation: 0,
                                      foregroundColor: Colors.white,
                                      backgroundColor: Colors.blue,
                                      side: BorderSide(
                                        color: Colors.blue,
                                      )),
                                  onPressed: () {
                                    _getImage(ImageSource.camera);
                                  },
                                  child: Text('Kamera'),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Center(
                      child: image == null
                          ? SizedBox(
                              height: 0,
                            )
                          : Column(
                              children: [
                                SizedBox(
                                  height: 24,
                                ),
                                Image.file(image!),
                              ],
                            ),
                    ),
                  ],
                ),
                const SizedBox(height: 24.0),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12)),
                      minimumSize: const Size(double.infinity, 60),
                      foregroundColor: Colors.white,
                      backgroundColor: Colors.blue,
                    ),
                    onPressed: submitForm,
                    child: const Text(
                      'Submit Form',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
