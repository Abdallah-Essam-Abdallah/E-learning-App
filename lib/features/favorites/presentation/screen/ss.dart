/*import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class Object {
  final String name;
  final int age;

  Object({required this.name, required this.age});

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'age': age,
    };
  }

  factory Object.fromMap(Map<String, dynamic> map) {
    return Object(
      name: map['name'],
      age: map['age'],
    );
  }
}

Future<void> saveObjects(List<Object> objects) async {
  final prefs = await SharedPreferences.getInstance();
  final List<Map<String, dynamic>> objectMaps = objects.map((e) => e.toMap()).toList();
  await prefs.setStringList('objects', objectMaps.map((e) => json.encode(e)).toList());
}

Future<List<Object>> getObjects() async {
  final prefs = await SharedPreferences.getInstance();
  final List<String> objectStrings = prefs.getStringList('objects') ?? [];
  return objectStrings.map((e) => Object.fromMap(json.decode(e))).toList();
}*/