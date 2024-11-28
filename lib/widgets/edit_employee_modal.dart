import 'package:flutter/material.dart';
import '../models/employee.dart';

class EditEmployeeModal extends StatefulWidget {
  final Employee employee;
  final Function(Employee) onSave;

  const EditEmployeeModal({super.key, required this.employee, required this.onSave});

  @override
  _EditEmployeeModalState createState() => _EditEmployeeModalState();
}

class _EditEmployeeModalState extends State<EditEmployeeModal> {
  late TextEditingController _nameController;
  late TextEditingController _cpfController;
  late TextEditingController _sectorController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.employee.name);
    _cpfController = TextEditingController(text: widget.employee.cpf);
    _sectorController = TextEditingController(text: widget.employee.sector);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Editar Funcionário'),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(labelText: 'Nome'),
            ),
            TextField(
              controller: _cpfController,
              decoration: const InputDecoration(labelText: 'CPF'),
            ),
            TextField(
              controller: _sectorController,
              decoration: const InputDecoration(labelText: 'Setor'),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancelar'),
        ),
        ElevatedButton(
          onPressed: () {
            final updatedEmployee = Employee(
              id: widget.employee.id,
              name: _nameController.text,
              cpf: _cpfController.text,
              sector: _sectorController.text,
            );
            widget.onSave(updatedEmployee);
            Navigator.pop(context);
          },
          child: const Text('Salvar'),
        ),
      ],
    );
  }
} 