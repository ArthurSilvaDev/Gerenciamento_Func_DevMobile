import 'package:flutter/material.dart';
import 'screens/login_screen.dart';
import 'services/mongodb_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  final mongoService = MongoDBService();
  try {
    await mongoService.connect();
    print('Conexão estabelecida com sucesso');
    
    await mongoService.insertTestEmployees();
    
    final employees = await mongoService.getEmployees();
    print('Total de funcionários carregados: ${employees.length}');
  } catch (e) {
    print('Erro na inicialização: $e');
  }
  
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sistema de Funcionários',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: LoginScreen(),
    );
  }
}
