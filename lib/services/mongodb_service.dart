import 'package:mongo_dart/mongo_dart.dart';
import '../models/employee.dart';

class MongoDBService {
  static const String MONGO_URL = "mongodb://mongo:9N8JinUaxJ7L@185.215.164.180:27999/employees_db?authSource=admin";
  static const String DB_NAME = "employees_db";
  late Db _db;

  Future<void> connect() async {
    try {
      _db = await Db.create(MONGO_URL);
      await _db.open();
      print('Conexão com MongoDB estabelecida com sucesso');
    } catch (e) {
      print('Erro ao conectar ao MongoDB: $e');
      rethrow;
    }
  }

  Future<bool> isConnected() async {
    try {
      return _db.isConnected;
    } catch (e) {
      print('Erro ao verificar conexão: $e');
      return false;
    }
  }

  Future<List<Employee>> getEmployees() async {
    try {
      final collection = _db.collection('employees');
      print('Buscando funcionários...');
      final employees = await collection.find().toList();
      print('Funcionários encontrados: ${employees.length}');
      return employees.map((e) => Employee.fromMap(e)).toList();
    } catch (e) {
      print('Erro ao buscar funcionários: $e');
      return [];
    }
  }

  Future<List<Employee>> getEmployeesBySector(String sector) async {
    try {
      final collection = _db.collection('employees');
      final employees = await collection.find(where.eq('sector', sector)).toList();
      return employees.map((e) => Employee.fromMap(e)).toList();
    } catch (e) {
      print('Erro ao buscar funcionários por setor: $e');
      return [];
    }
  }

  Future<void> addEmployee(Employee employee) async {
    try {
      final collection = _db.collection('employees');
      await collection.insert(employee.toMap());
    } catch (e) {
      print('Erro ao adicionar funcionário: $e');
    }
  }

  Future<void> updateEmployee(Employee employee) async {
    try {
      final collection = _db.collection('employees');
      await collection.update(
        where.id(ObjectId.fromHexString(employee.id)),
        employee.toMap(),
      );
    } catch (e) {
      print('Erro ao atualizar funcionário: $e');
    }
  }

  Future<void> deleteEmployee(String id) async {
    try {
      final collection = _db.collection('employees');
      await collection.remove(where.id(ObjectId.fromHexString(id)));
    } catch (e) {
      print('Erro ao deletar funcionário: $e');
    }
  }

  Future<List<String>> getSectors() async {
    try {
      final collection = _db.collection('employees');
      final sectors = await collection.distinct('sector');
      return List<String>.from(sectors['values']);
    } catch (e) {
      print('Erro ao buscar setores: $e');
      return [];
    }
  }

  Future<void> insertTestEmployees() async {
    try {
      if (!_db.isConnected) {
        await connect();
      }
      
      final collection = _db.collection('employees');
      
      // Limpa a coleção antes de inserir
      await collection.drop();
      
      final testEmployees = [
        {
          '_id': ObjectId(),
          'name': 'João Silva',
          'cpf': '123.456.789-00',
          'sector': 'TI'
        },
        {
          '_id': ObjectId(),
          'name': 'Maria Santos',
          'cpf': '987.654.321-00',
          'sector': 'RH'
        },
        {
          '_id': ObjectId(),
          'name': 'Pedro Oliveira',
          'cpf': '456.789.123-00',
          'sector': 'Financeiro'
        }
      ];

      for (var employee in testEmployees) {
        await collection.insert(employee);
        print('Funcionário inserido: ${employee['name']}');
      }
      
      // Verifica se os dados foram inseridos
      final count = await collection.count();
      print('Total de funcionários inseridos: $count');
      
    } catch (e) {
      print('Erro ao inserir funcionários de teste: $e');
    }
  }
} 