import 'package:flutter/material.dart';
import 'employee_list_screen.dart';
import 'employee_register_screen.dart';
import 'sectors_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sistema de Funcionários'),
        automaticallyImplyLeading: false,
      ),
      body: Center(
        child: GridView.count(
          crossAxisCount: 2,
          padding: const EdgeInsets.all(16.0),
          mainAxisSpacing: 16.0,
          crossAxisSpacing: 16.0,
          shrinkWrap: true,
          children: [
            _buildOptionCard(
              context,
              'Listar Funcionários',
              Icons.people,
              () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => EmployeeListScreen()),
              ),
            ),
            _buildOptionCard(
              context,
              'Cadastrar Funcionário',
              Icons.person_add,
              () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => EmployeeRegisterScreen()),
              ),
            ),
            _buildOptionCard(
              context,
              'Ver Setores',
              Icons.business,
              () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SectorsScreen()),
              ),
            ),
            _buildOptionCard(
              context,
              'Sair',
              Icons.exit_to_app,
              () => Navigator.pushReplacementNamed(context, '/'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOptionCard(
      BuildContext context, String title, IconData icon, VoidCallback onTap) {
    return Card(
      elevation: 4.0,
      child: InkWell(
        onTap: onTap,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 48.0),
            const SizedBox(height: 16.0),
            Text(
              title,
              style: const TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
} 