import 'package:flutter/material.dart';
import '../models/employee.dart';

class EmployeeTable extends StatelessWidget {
  final List<Employee> employees;
  final Function(Employee) onEdit;
  final Function(Employee) onDelete;

  const EmployeeTable({
    super.key,
    required this.employees,
    required this.onEdit,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: SingleChildScrollView(
        child: DataTable(
          columns: const [
            DataColumn(label: Text('Nome')),
            DataColumn(label: Text('CPF')),
            DataColumn(label: Text('Setor')),
            DataColumn(label: Text('Ações')),
          ],
          rows: employees.map((employee) {
            return DataRow(cells: [
              DataCell(Text(employee.name)),
              DataCell(Text(employee.cpf)),
              DataCell(Text(employee.sector)),
              DataCell(Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.edit),
                    onPressed: () => onEdit(employee),
                  ),
                  IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () => onDelete(employee),
                  ),
                ],
              )),
            ]);
          }).toList(),
        ),
      ),
    );
  }
} 