import 'package:flutter/material.dart';
import '../services/mongodb_service.dart';
import '../models/employee.dart';
import '../widgets/employee_table.dart';
import '../widgets/edit_employee_modal.dart';
import '../widgets/delete_employee_modal.dart';

class EmployeeListScreen extends StatefulWidget {
  final String? sector;

  const EmployeeListScreen({super.key, this.sector});

  @override
  _EmployeeListScreenState createState() => _EmployeeListScreenState();
}

class _EmployeeListScreenState extends State<EmployeeListScreen> {
  final MongoDBService _mongoService = MongoDBService();
  List<Employee> employees = [];

  @override
  void initState() {
    super.initState();
    _loadEmployees();
  }

  Future<void> _loadEmployees() async {
    List<Employee> loadedEmployees;
    if (widget.sector != null) {
      loadedEmployees = await _mongoService.getEmployeesBySector(widget.sector!);
    } else {
      loadedEmployees = await _mongoService.getEmployees();
    }
    setState(() {
      employees = loadedEmployees;
    });
  }

  Future<void> _showEditModal(Employee employee) async {
    await showDialog(
      context: context,
      builder: (context) => EditEmployeeModal(
        employee: employee,
        onSave: (updatedEmployee) async {
          await _mongoService.updateEmployee(updatedEmployee);
          _loadEmployees();
        },
      ),
    );
  }

  Future<void> _showDeleteModal(Employee employee) async {
    await showDialog(
      context: context,
      builder: (context) => DeleteEmployeeModal(
        employee: employee,
        onConfirm: () async {
          await _mongoService.deleteEmployee(employee.id);
          _loadEmployees();
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.sector != null
            ? 'Funcionários - ${widget.sector}'
            : 'Todos os Funcionários'),
      ),
      body: EmployeeTable(
        employees: employees,
        onEdit: _showEditModal,
        onDelete: _showDeleteModal,
      ),
    );
  }
} 