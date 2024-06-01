import 'dart:io';

import 'package:aplikasikpu/models/database.dart';
import 'package:flutter/material.dart';

class FormUserPage extends StatefulWidget {
  final MyDatabase database;
  const FormUserPage({super.key, required this.database});

  @override
  State<FormUserPage> createState() => _FormUserPageState();
}

class _FormUserPageState extends State<FormUserPage> {
  late Future<Person?> _userFuture;
  @override
  void initState() {
    super.initState();
    _userFuture = _getUserData();
  }

  Future<Person?> _getUserData() async {
    final people = await widget.database.getAllPersons();
    return people.isNotEmpty ? people.last : null;
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Data Pemilih'),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop(); // Aksi kembali
          },
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: FutureBuilder<Person?>(
            future: _userFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              }

              if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              }

              final person = snapshot.data;

              if (person == null) {
                return const Center(
                    heightFactor: 33,
                    child: Text(
                      'Data belum diinputkan',
                      style: TextStyle(fontSize: 16),
                    ));
              }

              return SafeArea(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 40, horizontal: 24),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          SizedBox(
                            width: 100,
                            child: Text(
                              "NIK",
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                          ),
                          Flexible(
                              child: Text(': ${person.nik}',
                                  style: TextStyle(fontSize: 16))),
                        ],
                      ),
                      SizedBox(height: 24),
                      Row(
                        children: [
                          SizedBox(
                            width: 100,
                            child: Text(
                              "Nama",
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                          ),
                          Flexible(
                            child: Text(': ${person.nama}',
                                style: TextStyle(fontSize: 16)),
                          ),
                        ],
                      ),
                      SizedBox(height: 24),
                      Row(
                        children: [
                          SizedBox(
                            width: 100,
                            child: Text(
                              "No. HP",
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                          ),
                          Flexible(
                            child: Text(': ${person.nohp}',
                                style: TextStyle(fontSize: 16)),
                          ),
                        ],
                      ),
                      SizedBox(height: 24),
                      Row(
                        children: [
                          SizedBox(
                            width: 100,
                            child: Text(
                              "Gender",
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                          ),
                          Text(
                            ': ${getDisplayGender(person.gender)}',
                            style: TextStyle(fontSize: 16),
                          ),
                        ],
                      ),
                      SizedBox(height: 24),
                      Row(
                        children: [
                          SizedBox(
                            width: 100,
                            child: Text(
                              "Tanggal",
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                          ),
                          Flexible(
                            child: Text(': ${person.tanggal}',
                                style: TextStyle(fontSize: 16)),
                          ),
                        ],
                      ),
                      SizedBox(height: 24),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: 100,
                            child: Text(
                              "Alamat",
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                          ),
                          Flexible(
                            child: Text(': ${person.alamat}',
                                style: TextStyle(fontSize: 16)),
                          ),
                        ],
                      ),
                      SizedBox(height: 24),
                      Column(
                        children: [
                          Row(
                            children: [
                              SizedBox(
                                width: 100,
                                child: Text(
                                  "Gambar",
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 24),
                          Image.file(File(person.image!))
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

String getDisplayGender(String? gender) {
  if (gender == 'L') {
    return 'Laki-laki';
  } else if (gender == 'P') {
    return 'Perempuan';
  } else {
    return 'Tidak Diketahui';
  }
}
