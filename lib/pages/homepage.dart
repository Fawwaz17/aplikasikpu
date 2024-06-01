import 'package:aplikasikpu/models/database.dart';
import 'package:aplikasikpu/pages/formentry.dart';
import 'package:aplikasikpu/pages/formuser.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class HomePage extends StatefulWidget {
  final MyDatabase database;
  const HomePage({super.key, required this.database});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool _isDataExists = false;
  @override
  void initState() {
    super.initState();
    _checkDataExistence();
  }

  Future<void> _checkDataExistence() async {
    final data = await widget.database.getAllPersons();
    setState(() {
      _isDataExists = data.isNotEmpty;
    });
  }

  Future<void> _showConfirmationDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Data Sudah Diinputkan'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Apakah Anda yakin ingin masuk ke Form Entry?'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Tidak'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Ya'),
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        FormEntryPage(database: widget.database),
                  ),
                );
              },
            ),
          ],
        );
      },
    );
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Aplikasi KPU'),
        centerTitle: true,
      ),
      body: SafeArea(
          child: Padding(
        padding:
            const EdgeInsetsDirectional.symmetric(vertical: 40, horizontal: 24),
        child: ListView(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                    minimumSize: const Size(double.infinity, 60),
                    foregroundColor: Colors.white,
                    backgroundColor: Colors.blue,
                  ),
                  onPressed: () async {
                    final allPersons = await widget.database.getAllPersons();
                    print(allPersons);
                    print("Klik Informasi");
                  },
                  child: const Text('Informasi',
                      style: TextStyle(
                          fontSize: 16, fontWeight: FontWeight.bold))),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                    minimumSize: const Size(double.infinity, 60),
                    foregroundColor: Colors.white,
                    backgroundColor: _isDataExists ? Colors.grey : Colors.blue,
                  ),
                  onPressed: _isDataExists
                      ? _showConfirmationDialog
                      : () async {
                          await Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => FormEntryPage(
                                      database: widget.database,
                                    )),
                          );
                          _checkDataExistence();
                          print("Klik Form Entry");
                        },
                  child: const Text('Form Entry',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ))),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                    minimumSize: const Size(double.infinity, 60),
                    foregroundColor: Colors.white,
                    backgroundColor: Colors.blue,
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => FormUserPage(
                                database: widget.database,
                              )),
                    );
                    print("Klik Lihat Data");
                  },
                  child: const Text('Lihat Data',
                      style: TextStyle(
                          fontSize: 16, fontWeight: FontWeight.bold))),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                    minimumSize: const Size(double.infinity, 60),
                    foregroundColor: Colors.white,
                    backgroundColor: Colors.red,
                  ),
                  onPressed: () {
                    SystemNavigator.pop();
                  },
                  child: const Text('Keluar',
                      style: TextStyle(
                          fontSize: 16, fontWeight: FontWeight.bold))),
            ),
          ],
        ),
      )),
    );
  }
}
