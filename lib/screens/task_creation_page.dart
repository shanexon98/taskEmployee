// ignore_for_file: deprecated_member_use, library_private_types_in_public_api

import 'package:animate_do/animate_do.dart';
import 'package:employee_task/providers/task_provider.dart';
import 'package:employee_task/widgets/custom_input.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../models/employee_task.dart';

class TaskCreationPage extends StatefulWidget {
  const TaskCreationPage({super.key});

  @override
  _TaskCreationPageState createState() => _TaskCreationPageState();
}

class _TaskCreationPageState extends State<TaskCreationPage> {
  final TextEditingController _employeeNameController = TextEditingController();
  final TextEditingController _taskController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _observationsController = TextEditingController();
  TaskStatus _selectedStatus = TaskStatus.Pendiente;
  late DateTime _selectedDate;

  @override
  void initState() {
    super.initState();
    _selectedDate = DateTime.now();
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 244, 231, 190),
      appBar: AppBar(title: ElasticIn(child: const Text('Crear Tarea', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),)), backgroundColor: const Color.fromARGB(255, 244, 231, 190),),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              CustomInput(
                controller: _employeeNameController,
                labelText: 'Nombre del empleado',
              ),
                const SizedBox(height: 20),
               CustomInput(
                controller: _taskController,
                labelText: 'Tarea a realizar:',
              ),
              
              const SizedBox(height: 20),
               CustomInput(
                controller: TextEditingController(
                    text: DateFormat('yyyy-MM-dd').format(_selectedDate)),
                labelText: 'Seleccionar fecha:',
                readOnly: true,
                onTap: () => _selectDate(context),
              ),
              
              const SizedBox(height: 20),
              CustomInput(
                controller: _observationsController,
                labelText: "Observaciones:",
              ),
             
              const SizedBox(height: 20),
              FadeInLeft(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: DropdownButtonFormField<TaskStatus>(
                    value: _selectedStatus,
                    onChanged: (newValue) {
                      setState(() {
                        _selectedStatus = newValue!;
                      });
                    },
                    items: TaskStatus.values.map((status) {
                      return DropdownMenuItem<TaskStatus>(
                        value: status,
                        child: Text(describeEnum(status)),
                      );
                    }).toList(),
                    decoration:
                        const InputDecoration(labelText: 'Estado de la tarea'),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              ElasticIn(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: const Color(0xffCD465C), // Color del texto blanco
                  ),
                  onPressed: () {
                    final tasksProvider =
                        Provider.of<TasksProvider>(context, listen: false);
                    final employeeTask = EmployeeTask(
                      employeeName: _employeeNameController.text,
                      task: _taskController.text,
                      date: _dateController.text.isNotEmpty
                          ? DateTime.parse(_dateController.text)
                          : DateTime.now(),
                      observations: _observationsController.text,
                      status: _selectedStatus,
                    );
                    tasksProvider.addEmployeeTask(employeeTask);
                    Navigator.pop(context);
                  },
                  child: const Text('Guardar Tarea'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
