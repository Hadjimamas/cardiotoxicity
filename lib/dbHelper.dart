// ignore_for_file: file_names, avoid_print

import 'package:path/path.dart' as path;
import 'package:sqflite/sqflite.dart' as sql;

class DBHelper {
  //Class that manages everything that has to do with the database

  static Future<sql.Database> database() async {
    //Creation of db
    final dbPath = await sql.getDatabasesPath();
    return sql.openDatabase(
      path.join(dbPath, 'mydb.db'),
      version: 1,
      onCreate: _createDB,
    );
  }

  static Future _createDB(db, version) async {
    //Creating the table that will store user data
    await db.execute('''
  CREATE TABLE users(
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name VARCHAR NOT NULL,
    surname VARCHAR NOT NULL,
    birthdate VARCHAR,
    gender VARCHAR,
    weight VARCHAR,
    username VARCHAR NOT NULL,
    password VARCHAR NOT NULL,
    email VARCHAR NOT NULL
  )
  ''');
    await db.execute('''CREATE TABLE allergies(
      name VARCHAR PRIMARY KEY
    ) 
    ''');
  }

  static Future<void> insert(String table, Map<String, Object> data) async {
    //Inserting the data into the table
    print(data); //printing data for debugging
    final db = await DBHelper.database();
    db.insert(table, data, conflictAlgorithm: sql.ConflictAlgorithm.ignore);
  }

//Updating
  static Future<int> updateItem(
      int id,
      String name,
      String surname,
      String birthdate,
      String weight,
      String gender,
      String username,
      String password,
      String email) async {
    final db = await DBHelper.database();
    final data = {
      'name': name,
      'surname': surname,
      'birthdate': birthdate,
      'weight': weight,
      'gender': gender,
      'username': username,
      'password': password,
      'email': email,
    };
    final result =
        await db.update('users', data, where: "id = ?", whereArgs: [id]);
    return result;
  }

//Getting data from the database
  static Future<List<Map<String, dynamic>>> getData(table) async {
    final db = await DBHelper.database();
    return db.query(table);
  }

//Getting the Data of a specific user based on the login credentials (Username & Password)
  static Future<Map<String, dynamic>> fetchUser(
      String password, String username) async {
    final db = await DBHelper.database();
    //Sql Query that giving me the expected output
    final result = await db.rawQuery(
        'SELECT * FROM users WHERE username="$username" and password="$password"');
    print(result.first);
    return result.first;
  }
}

//User model and the constructor
class User {
  late final int? id;
  late final String name;
  late final String surname;
  late final String birthdate;
  late final String gender;
  late final String weight;
  late final String username;
  late final String password;
  late final String email;

  User(
      {this.id,
      required this.name,
      required this.surname,
      required this.birthdate,
      required this.gender,
      required this.weight,
      required this.username,
      required this.password,
      required this.email});

  factory User.fromMap(Map<String, dynamic> map) => User(
      id: map['id'],
      name: map['name'],
      surname: map['surname'],
      birthdate: map['birthdate'],
      gender: map['gender'],
      weight: map['weight'],
      username: map['username'],
      password: map['password'],
      email: map['email']);

  Map<String, dynamic> toMap(User user) {
    return {
      'id': user.id,
      'name': user.name,
      'surname': user.surname,
      'birthdate': user.birthdate,
      'gender': user.gender,
      'weight': user.weight,
      'username': user.username,
      'password': user.password,
      'email': user.email
    };
  }
}

class GetAllergy {
  final String? name;

  GetAllergy({
    required this.name,
  });

  factory GetAllergy.fromMap(Map<String, dynamic> map) => GetAllergy(
        name: map['name'],
      );

  Map<String, dynamic> toMap(GetAllergy allergy) {
    return {
      'name': allergy.name,
    };
  }
}
