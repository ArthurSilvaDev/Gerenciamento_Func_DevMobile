import 'package:firebase_database/firebase_database.dart';
import '../models/employee.dart';

class FirebaseService {
  final DatabaseReference _database = FirebaseDatabase.instance.ref();

  Future<List<Employee>> getEmployees() async {
    try {
      final snapshot = await _database.child('employees').get();
      if (snapshot.exists) {
        final Map<dynamic, dynamic> data = snapshot.value as Map<dynamic, dynamic>;
        return data.entries.map((entry) => Employee(
          id: entry.key,
          name: entry.value['name'] ?? '',
          cpf: entry.value['cpf'] ?? '',
          sector: entry.value['sector'] ?? '',
        )).toList();
      }
      return [];
    } catch (e) {
      print('Erro ao buscar funcionários: $e');
      return [];
    }
  }

  Future<List<Employee>> getEmployeesBySector(String sector) async {
    try {
      final snapshot = await _database
          .child('employees')
          .orderByChild('sector')
          .equalTo(sector)
          .get();
      
      if (snapshot.exists) {
        final Map<dynamic, dynamic> data = snapshot.value as Map<dynamic, dynamic>;
        return data.entries.map((entry) => Employee(
          id: entry.key,
          name: entry.value['name'] ?? '',
          cpf: entry.value['cpf'] ?? '',
          sector: entry.value['sector'] ?? '',
        )).toList();
      }
      return [];
    } catch (e) {
      print('Erro ao buscar funcionários por setor: $e');
      return [];
    }
  }

  Future<void> addEmployee(Employee employee) async {
    try {
      await _database.child('employees').push().set(employee.toMap());
    } catch (e) {
      print('Erro ao adicionar funcionário: $e');
    }
  }

  Future<void> updateEmployee(Employee employee) async {
    try {
      await _database
          .child('employees')
          .child(employee.id)
          .update(employee.toMap());
    } catch (e) {
      print('Erro ao atualizar funcionário: $e');
    }
  }

  Future<void> deleteEmployee(String id) async {
    try {
      await _database.child('employees').child(id).remove();
    } catch (e) {
      print('Erro ao deletar funcionário: $e');
    }
  }

  Future<List<String>> getSectors() async {
    try {
      final snapshot = await _database.child('employees').get();
      if (snapshot.exists) {
        final Map<dynamic, dynamic> data = snapshot.value as Map<dynamic, dynamic>;
        return data.values
            .map((employee) => employee['sector'] as String)
            .toSet()
            .toList();
      }
      return [];
    } catch (e) {
      print('Erro ao buscar setores: $e');
      return [];
    }
  }
} 