import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';

class CustomInput extends StatelessWidget {
  const CustomInput({
    super.key,
    required this.controller,
    required this.labelText, this.obscureText = false, this.onTap, this.readOnly,
  });

  final TextEditingController controller;
  final String labelText;
  final bool? obscureText;
  final  VoidCallback? onTap;
  final bool? readOnly;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60,
      child: FadeInLeft(
        child: TextFormField(
          onTap: onTap,
          readOnly: readOnly ?? false,
          controller: controller,
          obscureText: obscureText ?? false,
          decoration: InputDecoration(
            labelText: labelText,
            filled: true,
            fillColor: Colors.white,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20.0),
              borderSide: const BorderSide(
                color: Colors.white, // Color del borde
                width: 2.0, // Ancho del borde
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20.0),
              borderSide: const BorderSide(
                color: Colors.white, // Color del borde cuando está habilitado
                width: 2.0, // Ancho del borde
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20.0),
              borderSide: const BorderSide(
                color: Colors.white, // Color del borde cuando está enfocado
                width: 2.0, // Ancho del borde
              ),
            ),
          ),
        ),
      ),
    );
  }
}
