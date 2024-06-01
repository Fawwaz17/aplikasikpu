import 'dart:io';
import 'package:drift/drift.dart' hide Column;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:aplikasikpu/models/database.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final database = MyDatabase();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Image Form Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ImageFormPage(database: database),
    );
  }
}

class ImageFormPage extends StatefulWidget {
  final MyDatabase database;

  const ImageFormPage({Key? key, required this.database}) : super(key: key);

  @override
  _ImageFormPageState createState() => _ImageFormPageState();
}

class _ImageFormPageState extends State<ImageFormPage> {
  File? _image;
  final picker = ImagePicker();

  Future<void> _getImage(ImageSource source) async {
    final pickedFile = await picker.getImage(source: source);

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  Future<void> _submitForm() async {
    if (_image != null) {
      final imagePath = await saveImageFile(_image!);
      final personsCompanion = PersonsCompanion(
        image: Value(imagePath),
      );
      await widget.database.addPerson(personsCompanion);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Gambar berhasil disimpan')),
      );

      setState(() {
        _image = null;
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Harap pilih gambar')),
      );
    }
  }

  Future<String> saveImageFile(File image) async {
    final directory = await getApplicationDocumentsDirectory();
    final imagePath =
        '${directory.path}/${DateTime.now().millisecondsSinceEpoch}.png';
    final savedImage = await image.copy(imagePath);
    return savedImage.path;
  }

  void _navigateToDisplayPage() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => DisplayImagesPage(database: widget.database),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Formulir dengan Gambar'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Input Gambar
              Center(
                child:
                    _image == null ? Text('Pilih gambar') : Image.file(_image!),
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      _getImage(ImageSource.gallery);
                    },
                    child: Text('Galeri'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      _getImage(ImageSource.camera);
                    },
                    child: Text('Kamera'),
                  ),
                ],
              ),
              SizedBox(height: 20),
              // Tombol Submit
              Center(
                child: ElevatedButton(
                  onPressed: _submitForm,
                  child: Text('Submit'),
                ),
              ),
              SizedBox(height: 20),
              // Tombol Tampilkan Gambar
              Center(
                child: ElevatedButton(
                  onPressed: _navigateToDisplayPage,
                  child: Text('Tampilkan Gambar'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class DisplayImagesPage extends StatelessWidget {
  final MyDatabase database;

  const DisplayImagesPage({Key? key, required this.database}) : super(key: key);

  Future<List<Person>> _fetchPersons() {
    return database.getAllPersons();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Gambar Tersimpan'),
      ),
      body: FutureBuilder<List<Person>>(
        future: _fetchPersons(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('Tidak ada gambar tersimpan.'));
          } else {
            final persons = snapshot.data!;
            return ListView.builder(
              itemCount: persons.length,
              itemBuilder: (context, index) {
                final person = persons[index];
                return ListTile(
                  leading: person.image != null
                      ? Image.file(File(person.image!))
                      : null,
                  title: Text('Gambar ${index + 1}'),
                );
              },
            );
          }
        },
      ),
    );
  }
}
