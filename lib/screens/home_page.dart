// ignore_for_file: use_build_context_synchronously, deprecated_member_use

import 'package:animate_do/animate_do.dart';
import 'package:employee_task/providers/auth_provider.dart';
import 'package:employee_task/providers/task_provider.dart';
import 'package:employee_task/screens/login_page.dart';
import 'package:employee_task/screens/task_detail_page.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../models/employee_task.dart';
import 'task_creation_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TaskStatus _selectedStatus = TaskStatus.Pendiente;
  List<EmployeeTask> _filteredTasks = [];

  @override
  Widget build(BuildContext context) {
    final tasksProvider = Provider.of<TasksProvider>(context);
    List<EmployeeTask> employeeTasks = tasksProvider.employeeTasks;

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 244, 231, 190),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: const Color.fromARGB(255, 244, 231, 190),
        title: ElasticIn(
          child: const Text('Tareas Empleados',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25)),
        ),
        actions: <Widget>[
          ElasticIn(
            child: IconButton(
              icon: const Icon(Icons.logout),
              onPressed: () {
                Provider.of<AuthProvider>(context, listen: false).logout();
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => LoginPage()),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: ElasticIn(
        child: FloatingActionButton(
          backgroundColor: const Color(0xffCD465C),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const TaskCreationPage()),
            );
          },
          child: const Icon(Icons.add),
        ),
      ),
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              IconButton(
                  onPressed: () {
                    setState(() {
                      _selectedStatus = TaskStatus.Pendiente;
                      _filteredTasks = [];
                    });
                  },
                  icon: const Icon(
                    Icons.refresh,
                    color: Color(0xffCD465C),
                  )),
              // select filtro
              DropdownButton<TaskStatus>(
                value: _selectedStatus,
                onChanged: (TaskStatus? newValue) {
                  if (newValue != null) {
                    // Cambiar de estado
                    setState(() {
                      // Cambiar el estado seleccionado
                      _selectedStatus = newValue;
                      // Filtrar las tareas por el estado seleccionado
                      _filteredTasks = employeeTasks
                          .where((task) => task.status == newValue)
                          .toList();
                    });
                  }
                },

                style: const TextStyle(color: Colors.black),

                dropdownColor: Colors.white,

                elevation: 5,

                borderRadius: BorderRadius.circular(10),
                // Mapear los valores de los estados
                items: TaskStatus.values.map((status) {
                  // Retornar un item de la lista
                  return DropdownMenuItem<TaskStatus>(
                    value: status,
                    child: Text(describeEnum(status)),
                  );
                }).toList(),
              ),
            ],
          ),
          Expanded(
            child: ListView.builder(
              // si no hay tareas filtradas, mostrar todas las tareas
              itemCount: _filteredTasks.isEmpty
                  ? employeeTasks.length
                  : _filteredTasks.length,
              itemBuilder: (context, index) {
                // obtener la tarea
                final task = _filteredTasks.isEmpty
                    ? employeeTasks[index]
                    : _filteredTasks[index];
                Color? color;
                switch (task.status) {
                  case TaskStatus.Pendiente:
                    color = Colors.orange;
                    break;
                  case TaskStatus.En_Progreso:
                    color = Colors.blue;
                    break;
                  case TaskStatus.Completado:
                    color = Colors.green;
                    break;
                }

                return BounceInDown(
                  duration: const Duration(milliseconds: 600),
                  from: 100,
                  child: Column(
                    children: [
                      ListTile(
                        title: Row(
                          children: [
                            Text(task.employeeName,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 18)),
                            const SizedBox(width: 10),
                            Text(
                              DateFormat('yyyy-MM-dd').format(task.date),
                              style: const TextStyle(fontSize: 12),
                            ),
                          ],
                        ),
                        subtitle: Text(task.task,
                            style: const TextStyle(
                                fontWeight: FontWeight.w600, fontSize: 13)),
                        trailing: Container(
                          height: 35,
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: Colors.transparent,
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Text(describeEnum(task.status),
                              style: TextStyle(color: color, fontSize: 13)),
                        ),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => TaskDetailPage(task: task),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
