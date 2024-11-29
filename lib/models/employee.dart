import 'package:cloud_firestore/cloud_firestore.dart';

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
      'name': name,
      'cpf': cpf,
      'sector': sector,
    };
  }

  factory Employee.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return Employee(
      id: doc.id,
      name: data['name'] ?? '',
      cpf: data['cpf'] ?? '',
      sector: data['sector'] ?? '',
    );
  }
} 