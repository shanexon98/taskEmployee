import 'package:employee_task/models/user.dart';
import 'package:flutter/material.dart';


class AuthProvider with ChangeNotifier {
  // Usuario autenticado
  User? _user;

  User? get user => _user;
  // Iniciar sesión
  Future<void> login(String email, String password) async {
    // Simular la autenticación
    await Future.delayed(const Duration(seconds: 1));
    if (email == 'user' && password == '123') {
      _user = User(email: email, password: password);
      notifyListeners();
    } else {
      throw 'Usuario o contraseña incorrecto';
    }
  }
  // Cerrar sesión
  Future<void> logout() async {
    _user = null;
    notifyListeners();
    
  }
}
