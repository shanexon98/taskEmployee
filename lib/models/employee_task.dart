
// ignore_for_file: constant_identifier_names

enum TaskStatus { En_Progreso, Completado, Pendiente }

class EmployeeTask {
  final String employeeName;
  final String task;
  final DateTime date;
  final String observations;
    TaskStatus status;

  EmployeeTask({
    required this.employeeName,
    required this.task,
    required this.date,
    required this.observations,
    required this.status,
  });

  factory EmployeeTask.fromJson(Map<String, dynamic> json) {
    return EmployeeTask(
      employeeName: json['employeeName'] ?? '',
      task: json['task'] ?? '',
      date: DateTime.parse(json['date'] ?? ''),
      observations: json['observations'] ?? '',
      status: _parseStatus(json['status'] ?? ''),
    );
  }

  static TaskStatus _parseStatus(String status) {
    switch (status) {
      case 'pending':
        return TaskStatus.Pendiente;
      case 'inProgress':
        return TaskStatus.En_Progreso;
      case 'completed':
        return TaskStatus.Completado;
      default:
        return TaskStatus.Pendiente;
    }
  }
}