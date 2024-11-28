import 'package:flutter/material.dart';
import '../models/employee.dart';

class DeleteEmployeeModal extends StatelessWidget {
  final Employee employee;
  final VoidCallback onConfirm;

  const DeleteEmployeeModal({
    super.key,
    required this.employee,
    required this.onConfirm,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Confirmar Exclusão'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Deseja realmente excluir este funcionário?'),
          const SizedBox(height: 16.0),
          Text('Nome: ${employee.name}'),
          Text('CPF: ${employee.cpf}'),
          Text('Setor: ${employee.sector}'),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancelar'),
        ),
        ElevatedButton(
          onPressed: () {
            onConfirm();
            Navigator.pop(context);
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.red,
          ),
          child: const Text('Excluir'),
        ),
      ],
    );
  }
} 