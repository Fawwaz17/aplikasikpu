// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// ignore_for_file: type=lint
class $PersonsTable extends Persons with TableInfo<$PersonsTable, Person> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PersonsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _nikMeta = const VerificationMeta('nik');
  @override
  late final GeneratedColumn<String> nik = GeneratedColumn<String>(
      'nik', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _namaMeta = const VerificationMeta('nama');
  @override
  late final GeneratedColumn<String> nama = GeneratedColumn<String>(
      'nama', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _nohpMeta = const VerificationMeta('nohp');
  @override
  late final GeneratedColumn<String> nohp = GeneratedColumn<String>(
      'nohp', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _tanggalMeta =
      const VerificationMeta('tanggal');
  @override
  late final GeneratedColumn<String> tanggal = GeneratedColumn<String>(
      'tanggal', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _alamatMeta = const VerificationMeta('alamat');
  @override
  late final GeneratedColumn<String> alamat = GeneratedColumn<String>(
      'alamat', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _genderMeta = const VerificationMeta('gender');
  @override
  late final GeneratedColumn<String> gender = GeneratedColumn<String>(
      'gender', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _imageMeta = const VerificationMeta('image');
  @override
  late final GeneratedColumn<String> image = GeneratedColumn<String>(
      'image', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns =>
      [id, nik, nama, nohp, tanggal, alamat, gender, image];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'persons';
  @override
  VerificationContext validateIntegrity(Insertable<Person> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('nik')) {
      context.handle(
          _nikMeta, nik.isAcceptableOrUnknown(data['nik']!, _nikMeta));
    }
    if (data.containsKey('nama')) {
      context.handle(
          _namaMeta, nama.isAcceptableOrUnknown(data['nama']!, _namaMeta));
    }
    if (data.containsKey('nohp')) {
      context.handle(
          _nohpMeta, nohp.isAcceptableOrUnknown(data['nohp']!, _nohpMeta));
    }
    if (data.containsKey('tanggal')) {
      context.handle(_tanggalMeta,
          tanggal.isAcceptableOrUnknown(data['tanggal']!, _tanggalMeta));
    }
    if (data.containsKey('alamat')) {
      context.handle(_alamatMeta,
          alamat.isAcceptableOrUnknown(data['alamat']!, _alamatMeta));
    }
    if (data.containsKey('gender')) {
      context.handle(_genderMeta,
          gender.isAcceptableOrUnknown(data['gender']!, _genderMeta));
    }
    if (data.containsKey('image')) {
      context.handle(
          _imageMeta, image.isAcceptableOrUnknown(data['image']!, _imageMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Person map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Person(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      nik: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}nik']),
      nama: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}nama']),
      nohp: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}nohp']),
      tanggal: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}tanggal']),
      alamat: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}alamat']),
      gender: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}gender']),
      image: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}image']),
    );
  }

  @override
  $PersonsTable createAlias(String alias) {
    return $PersonsTable(attachedDatabase, alias);
  }
}

class Person extends DataClass implements Insertable<Person> {
  final int id;
  final String? nik;
  final String? nama;
  final String? nohp;
  final String? tanggal;
  final String? alamat;
  final String? gender;
  final String? image;
  const Person(
      {required this.id,
      this.nik,
      this.nama,
      this.nohp,
      this.tanggal,
      this.alamat,
      this.gender,
      this.image});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    if (!nullToAbsent || nik != null) {
      map['nik'] = Variable<String>(nik);
    }
    if (!nullToAbsent || nama != null) {
      map['nama'] = Variable<String>(nama);
    }
    if (!nullToAbsent || nohp != null) {
      map['nohp'] = Variable<String>(nohp);
    }
    if (!nullToAbsent || tanggal != null) {
      map['tanggal'] = Variable<String>(tanggal);
    }
    if (!nullToAbsent || alamat != null) {
      map['alamat'] = Variable<String>(alamat);
    }
    if (!nullToAbsent || gender != null) {
      map['gender'] = Variable<String>(gender);
    }
    if (!nullToAbsent || image != null) {
      map['image'] = Variable<String>(image);
    }
    return map;
  }

  PersonsCompanion toCompanion(bool nullToAbsent) {
    return PersonsCompanion(
      id: Value(id),
      nik: nik == null && nullToAbsent ? const Value.absent() : Value(nik),
      nama: nama == null && nullToAbsent ? const Value.absent() : Value(nama),
      nohp: nohp == null && nullToAbsent ? const Value.absent() : Value(nohp),
      tanggal: tanggal == null && nullToAbsent
          ? const Value.absent()
          : Value(tanggal),
      alamat:
          alamat == null && nullToAbsent ? const Value.absent() : Value(alamat),
      gender:
          gender == null && nullToAbsent ? const Value.absent() : Value(gender),
      image:
          image == null && nullToAbsent ? const Value.absent() : Value(image),
    );
  }

  factory Person.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Person(
      id: serializer.fromJson<int>(json['id']),
      nik: serializer.fromJson<String?>(json['nik']),
      nama: serializer.fromJson<String?>(json['nama']),
      nohp: serializer.fromJson<String?>(json['nohp']),
      tanggal: serializer.fromJson<String?>(json['tanggal']),
      alamat: serializer.fromJson<String?>(json['alamat']),
      gender: serializer.fromJson<String?>(json['gender']),
      image: serializer.fromJson<String?>(json['image']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'nik': serializer.toJson<String?>(nik),
      'nama': serializer.toJson<String?>(nama),
      'nohp': serializer.toJson<String?>(nohp),
      'tanggal': serializer.toJson<String?>(tanggal),
      'alamat': serializer.toJson<String?>(alamat),
      'gender': serializer.toJson<String?>(gender),
      'image': serializer.toJson<String?>(image),
    };
  }

  Person copyWith(
          {int? id,
          Value<String?> nik = const Value.absent(),
          Value<String?> nama = const Value.absent(),
          Value<String?> nohp = const Value.absent(),
          Value<String?> tanggal = const Value.absent(),
          Value<String?> alamat = const Value.absent(),
          Value<String?> gender = const Value.absent(),
          Value<String?> image = const Value.absent()}) =>
      Person(
        id: id ?? this.id,
        nik: nik.present ? nik.value : this.nik,
        nama: nama.present ? nama.value : this.nama,
        nohp: nohp.present ? nohp.value : this.nohp,
        tanggal: tanggal.present ? tanggal.value : this.tanggal,
        alamat: alamat.present ? alamat.value : this.alamat,
        gender: gender.present ? gender.value : this.gender,
        image: image.present ? image.value : this.image,
      );
  @override
  String toString() {
    return (StringBuffer('Person(')
          ..write('id: $id, ')
          ..write('nik: $nik, ')
          ..write('nama: $nama, ')
          ..write('nohp: $nohp, ')
          ..write('tanggal: $tanggal, ')
          ..write('alamat: $alamat, ')
          ..write('gender: $gender, ')
          ..write('image: $image')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, nik, nama, nohp, tanggal, alamat, gender, image);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Person &&
          other.id == this.id &&
          other.nik == this.nik &&
          other.nama == this.nama &&
          other.nohp == this.nohp &&
          other.tanggal == this.tanggal &&
          other.alamat == this.alamat &&
          other.gender == this.gender &&
          other.image == this.image);
}

class PersonsCompanion extends UpdateCompanion<Person> {
  final Value<int> id;
  final Value<String?> nik;
  final Value<String?> nama;
  final Value<String?> nohp;
  final Value<String?> tanggal;
  final Value<String?> alamat;
  final Value<String?> gender;
  final Value<String?> image;
  const PersonsCompanion({
    this.id = const Value.absent(),
    this.nik = const Value.absent(),
    this.nama = const Value.absent(),
    this.nohp = const Value.absent(),
    this.tanggal = const Value.absent(),
    this.alamat = const Value.absent(),
    this.gender = const Value.absent(),
    this.image = const Value.absent(),
  });
  PersonsCompanion.insert({
    this.id = const Value.absent(),
    this.nik = const Value.absent(),
    this.nama = const Value.absent(),
    this.nohp = const Value.absent(),
    this.tanggal = const Value.absent(),
    this.alamat = const Value.absent(),
    this.gender = const Value.absent(),
    this.image = const Value.absent(),
  });
  static Insertable<Person> custom({
    Expression<int>? id,
    Expression<String>? nik,
    Expression<String>? nama,
    Expression<String>? nohp,
    Expression<String>? tanggal,
    Expression<String>? alamat,
    Expression<String>? gender,
    Expression<String>? image,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (nik != null) 'nik': nik,
      if (nama != null) 'nama': nama,
      if (nohp != null) 'nohp': nohp,
      if (tanggal != null) 'tanggal': tanggal,
      if (alamat != null) 'alamat': alamat,
      if (gender != null) 'gender': gender,
      if (image != null) 'image': image,
    });
  }

  PersonsCompanion copyWith(
      {Value<int>? id,
      Value<String?>? nik,
      Value<String?>? nama,
      Value<String?>? nohp,
      Value<String?>? tanggal,
      Value<String?>? alamat,
      Value<String?>? gender,
      Value<String?>? image}) {
    return PersonsCompanion(
      id: id ?? this.id,
      nik: nik ?? this.nik,
      nama: nama ?? this.nama,
      nohp: nohp ?? this.nohp,
      tanggal: tanggal ?? this.tanggal,
      alamat: alamat ?? this.alamat,
      gender: gender ?? this.gender,
      image: image ?? this.image,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (nik.present) {
      map['nik'] = Variable<String>(nik.value);
    }
    if (nama.present) {
      map['nama'] = Variable<String>(nama.value);
    }
    if (nohp.present) {
      map['nohp'] = Variable<String>(nohp.value);
    }
    if (tanggal.present) {
      map['tanggal'] = Variable<String>(tanggal.value);
    }
    if (alamat.present) {
      map['alamat'] = Variable<String>(alamat.value);
    }
    if (gender.present) {
      map['gender'] = Variable<String>(gender.value);
    }
    if (image.present) {
      map['image'] = Variable<String>(image.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PersonsCompanion(')
          ..write('id: $id, ')
          ..write('nik: $nik, ')
          ..write('nama: $nama, ')
          ..write('nohp: $nohp, ')
          ..write('tanggal: $tanggal, ')
          ..write('alamat: $alamat, ')
          ..write('gender: $gender, ')
          ..write('image: $image')
          ..write(')'))
        .toString();
  }
}

abstract class _$MyDatabase extends GeneratedDatabase {
  _$MyDatabase(QueryExecutor e) : super(e);
  _$MyDatabaseManager get managers => _$MyDatabaseManager(this);
  late final $PersonsTable persons = $PersonsTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [persons];
}

typedef $$PersonsTableInsertCompanionBuilder = PersonsCompanion Function({
  Value<int> id,
  Value<String?> nik,
  Value<String?> nama,
  Value<String?> nohp,
  Value<String?> tanggal,
  Value<String?> alamat,
  Value<String?> gender,
  Value<String?> image,
});
typedef $$PersonsTableUpdateCompanionBuilder = PersonsCompanion Function({
  Value<int> id,
  Value<String?> nik,
  Value<String?> nama,
  Value<String?> nohp,
  Value<String?> tanggal,
  Value<String?> alamat,
  Value<String?> gender,
  Value<String?> image,
});

class $$PersonsTableTableManager extends RootTableManager<
    _$MyDatabase,
    $PersonsTable,
    Person,
    $$PersonsTableFilterComposer,
    $$PersonsTableOrderingComposer,
    $$PersonsTableProcessedTableManager,
    $$PersonsTableInsertCompanionBuilder,
    $$PersonsTableUpdateCompanionBuilder> {
  $$PersonsTableTableManager(_$MyDatabase db, $PersonsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          filteringComposer:
              $$PersonsTableFilterComposer(ComposerState(db, table)),
          orderingComposer:
              $$PersonsTableOrderingComposer(ComposerState(db, table)),
          getChildManagerBuilder: (p) => $$PersonsTableProcessedTableManager(p),
          getUpdateCompanionBuilder: ({
            Value<int> id = const Value.absent(),
            Value<String?> nik = const Value.absent(),
            Value<String?> nama = const Value.absent(),
            Value<String?> nohp = const Value.absent(),
            Value<String?> tanggal = const Value.absent(),
            Value<String?> alamat = const Value.absent(),
            Value<String?> gender = const Value.absent(),
            Value<String?> image = const Value.absent(),
          }) =>
              PersonsCompanion(
            id: id,
            nik: nik,
            nama: nama,
            nohp: nohp,
            tanggal: tanggal,
            alamat: alamat,
            gender: gender,
            image: image,
          ),
          getInsertCompanionBuilder: ({
            Value<int> id = const Value.absent(),
            Value<String?> nik = const Value.absent(),
            Value<String?> nama = const Value.absent(),
            Value<String?> nohp = const Value.absent(),
            Value<String?> tanggal = const Value.absent(),
            Value<String?> alamat = const Value.absent(),
            Value<String?> gender = const Value.absent(),
            Value<String?> image = const Value.absent(),
          }) =>
              PersonsCompanion.insert(
            id: id,
            nik: nik,
            nama: nama,
            nohp: nohp,
            tanggal: tanggal,
            alamat: alamat,
            gender: gender,
            image: image,
          ),
        ));
}

class $$PersonsTableProcessedTableManager extends ProcessedTableManager<
    _$MyDatabase,
    $PersonsTable,
    Person,
    $$PersonsTableFilterComposer,
    $$PersonsTableOrderingComposer,
    $$PersonsTableProcessedTableManager,
    $$PersonsTableInsertCompanionBuilder,
    $$PersonsTableUpdateCompanionBuilder> {
  $$PersonsTableProcessedTableManager(super.$state);
}

class $$PersonsTableFilterComposer
    extends FilterComposer<_$MyDatabase, $PersonsTable> {
  $$PersonsTableFilterComposer(super.$state);
  ColumnFilters<int> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get nik => $state.composableBuilder(
      column: $state.table.nik,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get nama => $state.composableBuilder(
      column: $state.table.nama,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get nohp => $state.composableBuilder(
      column: $state.table.nohp,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get tanggal => $state.composableBuilder(
      column: $state.table.tanggal,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get alamat => $state.composableBuilder(
      column: $state.table.alamat,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get gender => $state.composableBuilder(
      column: $state.table.gender,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get image => $state.composableBuilder(
      column: $state.table.image,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));
}

class $$PersonsTableOrderingComposer
    extends OrderingComposer<_$MyDatabase, $PersonsTable> {
  $$PersonsTableOrderingComposer(super.$state);
  ColumnOrderings<int> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get nik => $state.composableBuilder(
      column: $state.table.nik,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get nama => $state.composableBuilder(
      column: $state.table.nama,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get nohp => $state.composableBuilder(
      column: $state.table.nohp,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get tanggal => $state.composableBuilder(
      column: $state.table.tanggal,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get alamat => $state.composableBuilder(
      column: $state.table.alamat,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get gender => $state.composableBuilder(
      column: $state.table.gender,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get image => $state.composableBuilder(
      column: $state.table.image,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));
}

class _$MyDatabaseManager {
  final _$MyDatabase _db;
  _$MyDatabaseManager(this._db);
  $$PersonsTableTableManager get persons =>
      $$PersonsTableTableManager(_db, _db.persons);
}
