import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;

part 'database.g.dart';

class Persons extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get nik => text().nullable()();
  TextColumn get nama => text().nullable()();
  TextColumn get nohp => text().nullable()();
  TextColumn get tanggal => text().nullable()();
  TextColumn get alamat => text().nullable()();
  TextColumn get gender => text().nullable()();
  TextColumn get image => text().nullable()();
}

@DriftDatabase(tables: [Persons])
class MyDatabase extends _$MyDatabase {
  MyDatabase() : super(NativeDatabase.memory());

  @override
  int get schemaVersion => 1;
  Future<int> addPerson(PersonsCompanion entry) async {
    return into(persons).insert(entry);
  }

  Future<List<Person>> getAllPersons() {
    return select(persons).get();
  }

  Future<int> addImage(PersonsCompanion entry, String? imagePath) async {
    return into(persons).insert(
      entry.copyWith(
        image: Value(imagePath),
      ),
    );
  }
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'db.sqlite'));
    return NativeDatabase(file);
  });
}
