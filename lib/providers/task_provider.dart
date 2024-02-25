import 'dart:convert';

import 'package:flutter/material.dart';

import '../models/employee_task.dart';
import '../models/task.dart';

class TasksProvider with ChangeNotifier {
  //Lista de tareas
  List<Task> _tasks = [];
  //Lista de tareas de empleados
  List<EmployeeTask> _employeeTasks = [];
  //Getter de las tareas
  List<Task> get tasks => _tasks;
  //Getter de las tareas de empleados
  List<EmployeeTask> get employeeTasks => _filteredTasks.isEmpty ? _employeeTasks : _filteredTasks;
  List<EmployeeTask> _filteredTasks = [];
  
  TasksProvider() {
    loadLocalTasks();
  }
//Carga las tareas locales
  void loadLocalTasks() {
    // Lee el contenido del archivo local_tasks.json
    String jsonString = '''
    [
      {
        "employeeName": "Shanexon Ortiz",
        "task": "Descargar información",
        "date": "2022-03-01",
        "observations": "Tener cuidado con la base",
        "status": "completed"
      },
      {
        "employeeName": "Juanito Alimaña",
        "task": "Preparar presentación",
        "date": "2022-03-02",
        "observations": "Presentación de ventas",
        "status": "inProgress"
      },
      {
        "employeeName": "Pedro Perez",
        "task": "Revisar reporte",
        "date": "2022-03-03",
        "observations": "Reporte de ventas",
        "status": "pending"
      }
    ]
    ''';

    List<dynamic> jsonTasks = json.decode(jsonString);
    _employeeTasks =
        jsonTasks.map((json) => EmployeeTask.fromJson(json)).toList();
    notifyListeners();
  }
  
 void filterTasks(List<EmployeeTask> tasks) {
    _filteredTasks = tasks;
    notifyListeners();
  }

//Agrega una tarea
  void addEmployeeTask(EmployeeTask employeeTask) {
    _employeeTasks.add(employeeTask);
    notifyListeners();
  }

  //Actualiza el estado de la tarea
  void updateTaskStatus(EmployeeTask task, TaskStatus newStatus) {
    // Busca la tarea en la lista
    final index = _employeeTasks.indexWhere((t) => t == task);
    // Si la tarea existe, actualiza el estado
    if (index != -1) {
      _employeeTasks[index].status = newStatus;
      notifyListeners();
    }
    
  }

//Elimina la tarea
  void deleteEmployeeTask(EmployeeTask task) {
    _employeeTasks.remove(task);
    notifyListeners();
  }

//Actualiza la lista de tareas
  Future<void> refreshTasks() async {
    await Future.delayed(const Duration(seconds: 1));

    _tasks = List.from(_tasks);
    notifyListeners();
  }
}
