import 'dart:async';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:flutter/widgets.dart';

//https://blog.devgenius.io/flutter-sqflite-the-complete-guide-88ee2ae999f2
//db variable
var db;
//main function
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //connection and creation
  db = openDatabase(
    join(await getDatabasesPath(), 'studentDB'),
    onCreate: (db, ver) {
      return db.execute(
        'CREATE TABLE Student(email TEXT PRIMARY KEY, name TEXT, age INTEGER, rollNo TEXT)',
      );
    },
    //version is used to execute onCreate and make database upgrades and downgrades.
    version: 1,
  );

  //insertion
  var studentOne = Student(
      email: 'studentOne@gmail.com', name: 'XYZ', age: 20, rollNo: '2P-23');
  await insertStudent(studentOne);
  //read
  print(await getStudents());
  //updation
  var studentUpdate = Student(
    email: studentOne.email,
    name: studentOne.name,
    age: studentOne.age + 7,
    rollNo: studentOne.rollNo,
  );
  await updateStudent(studentUpdate);
  // Print the updated results.
  print(await getStudents());
  //deletion
  deleteStudent("studentOne@gmail.com");
}

//Class
class Student {
  final String email;
  final String name;
  final int age;
  final String rollNo;
//constructor
  Student({
    required this.email,
    required this.name,
    required this.age,
    required this.rollNo,
  });
  Map<String, dynamic> mapStudent() {
    return {
      'email': email,
      'name': name,
      'age': age,
      'rollNo': rollNo,
    };
  }
}

//Insert
//the 'future' keyword defines a function that works asynchronously
Future<void> insertStudent(Student student) async {
  //local database variable
  final curDB = await db;
  //insert function
  await curDB.insert(
    //first parameter is Table name
    'Student',
    //second parameter is data to be inserted
    student.mapStudent(),
    //replace if two same entries are inserted
    conflictAlgorithm: ConflictAlgorithm.replace,
  );
}

//Read
Future<List<Student>> getStudents() async {
  final curDB = await db;
  //query to get all students into a Map list
  final List<Map<String, dynamic>> studentMaps = await curDB.query('Student');
  //converting the map list to student list
  return List.generate(studentMaps.length, (i) {
    //loop to traverse the list and return student object
    return Student(
      email: studentMaps[i]['email'],
      name: studentMaps[i]['name'],
      age: studentMaps[i]['age'],
      rollNo: studentMaps[i]['rollNo'],
    );
  });
}

//Update
Future<void> updateStudent(Student student) async {
  final curDB = await db;
  //update a specific student
  await curDB.update(
    //table name
    'Student',
    //convert student object to a map
    student.mapStudent(),
    //ensure that the student has a matching email
    where: 'email = ?',
    //argument of where statement(the email we want to search in our case)
    whereArgs: [student.email],
  );
}

//Delete
Future<void> deleteStudent(String email) async {
  final curDB = await db;
  // Delete operation
  await curDB.delete(
    //table name
    'Student',
    //'where statement to identify a specific student'
    where: 'email = ?',
    //arguments to the where statement(email passed as parameter in our case)
    whereArgs: [email],
  );
}
