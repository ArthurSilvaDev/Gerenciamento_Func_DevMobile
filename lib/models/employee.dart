import 'package:mongo_dart/mongo_dart.dart';

class Employee {
  final String id;
  String name;
  String cpf;
  String sector;

  Employee({
    required this.id,
    required this.name,
    required this.cpf,
    required this.sector,
  });

  Map<String, dynamic> toMap() {
    return {
      '_id': id.isEmpty ? ObjectId() : ObjectId.fromHexString(id),
      'name': name,
      'cpf': cpf,
      'sector': sector,
    };
  }

  factory Employee.fromMap(Map<String, dynamic> map) {
    return Employee(
      id: map['_id'] is ObjectId ? map['_id'].toHexString() : map['_id'].toString(),
      name: map['name'],
      cpf: map['cpf'],
      sector: map['sector'],
    );
  }
} 