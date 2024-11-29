import 'package:flutter/material.dart';
import '../services/firebase_service.dart';
import 'employee_list_screen.dart';

class SectorsScreen extends StatefulWidget {
  const SectorsScreen({super.key});

  @override
  _SectorsScreenState createState() => _SectorsScreenState();
}

class _SectorsScreenState extends State<SectorsScreen> {
  final FirebaseService _firebaseService = FirebaseService();
  List<String> sectors = [];

  @override
  void initState() {
    super.initState();
    _loadSectors();
  }

  Future<void> _loadSectors() async {
    final loadedSectors = await _firebaseService.getSectors();
    setState(() {
      sectors = loadedSectors;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Setores'),
      ),
      body: ListView.builder(
        itemCount: sectors.length,
        itemBuilder: (context, index) {
          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: ListTile(
              title: Text(
                sectors[index],
                style: const TextStyle(fontSize: 18.0),
              ),
              trailing: const Icon(Icons.arrow_forward_ios),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => EmployeeListScreen(
                      sector: sectors[index],
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
} 