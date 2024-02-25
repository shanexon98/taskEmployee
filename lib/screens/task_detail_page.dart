// ignore_for_file: deprecated_member_use

import 'package:animate_do/animate_do.dart';
import 'package:employee_task/providers/task_provider.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/employee_task.dart';

class TaskDetailPage extends StatefulWidget {
  final EmployeeTask? task;

  const TaskDetailPage({super.key, this.task});

  @override
  State<TaskDetailPage> createState() => _TaskDetailPageState();
}

class _TaskDetailPageState extends State<TaskDetailPage> {
  TaskStatus _selectedStatus = TaskStatus.Pendiente;

  @override
  void initState() {
    super.initState();
    _selectedStatus = widget.task!.status;
  }

  void _deleteTask(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Eliminar Tarea'),
          content: const Text('¿Está seguro que desea eliminar la tarea?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancelar'),
            ),
            TextButton(
              onPressed: () {
                Provider.of<TasksProvider>(context, listen: false)
                    .deleteEmployeeTask(widget.task!);
                Navigator.of(context).pop();
                Navigator.of(context)
                    .pop(); // Pop twice to return to previous screen
              },
              child: const Text('Eliminar'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 244, 231, 190),
      appBar: AppBar(
        title: const Text(
          'Detalle tarea',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
        ),
        backgroundColor: const Color.fromARGB(255, 244, 231, 190),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            InfoEmployee(
              title: 'Nombre empleado:',
              value: widget.task!.employeeName,
            ),
            const SizedBox(height: 20),
            InfoEmployee(
              title: 'Tarea:',
              value: widget.task!.task,
            ),
            const SizedBox(height: 20),
            InfoEmployee(
              title: 'Fecha:',
              value: widget.task!.date.toString(),
            ),
            const SizedBox(height: 20),
            InfoEmployee(
              title: 'Observaciones:',
              value: widget.task!.observations,
            ),
            const SizedBox(height: 20),
            // InfoEmployee(
            //   title: 'Estado:',
            //   value: describeEnum(widget.task!.status),
            // ),
            DropdownButton<TaskStatus>(
              value: _selectedStatus,
              onChanged: (TaskStatus? newValue) {
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
            ),
            const SizedBox(height: 20),
            Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Row(
                  children: [
                    ElasticIn(
                      child: ElevatedButton(
                        onPressed: () {
                          Provider.of<TasksProvider>(context, listen: false)
                              .updateTaskStatus(widget.task!, _selectedStatus);
                          Navigator.pop(context);
                          ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content: Text('Tarea actualizada correctamente'),
                                      ),
                                    );
                        },
                        child: const Text('Guardar cambios'),
                      ),
                    ),
                    const SizedBox(width: 10),
                    ElasticIn(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.white,
                          backgroundColor:
                              const Color(0xffCD465C), // Color del texto blanco
                        ),
                        onPressed: () => _deleteTask(context),
                        child: const Row(
                          children: [
                            Icon(
                              Icons.delete,
                            ),
                            SizedBox(width: 10),
                            Text('Eliminar tarea'),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class InfoEmployee extends StatelessWidget {
  const InfoEmployee({
    super.key,
    required this.title,
    required this.value,
  });

  final String title;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
        const SizedBox(width: 10),
        Text(
          value,
          style: const TextStyle(fontWeight: FontWeight.w400, fontSize: 15),
        )
      ],
    );
  }
}
