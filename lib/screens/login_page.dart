// ignore_for_file: use_build_context_synchronously

import 'package:animate_do/animate_do.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:employee_task/widgets/custom_input.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/auth_provider.dart';

class LoginPage extends StatelessWidget {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 244, 231, 190),
      body: Padding(
        padding: const EdgeInsets.all(0.0),
        child: SingleChildScrollView(
            child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Center(
                    child: ElasticIn(
                      child: CachedNetworkImage(
                        imageUrl: 'https://iili.io/JGV7NEX.png',
                        placeholder: (context, url) =>
                            const CircularProgressIndicator(),
                        errorWidget: (context, url, error) =>
                            const Icon(Icons.error),
                      ),
                    ),
                  ),
                  const SizedBox(height: 15),
                  BounceInLeft(
                    child: CustomInput(
                      controller: _emailController,
                      labelText: 'Usuario',
                    ),
                  ),
                  const SizedBox(height: 15),
                  BounceInLeft(
                    child: CustomInput(
                      controller: _passwordController,
                      labelText: 'Contraseña',
                      obscureText: true,
                    ),
                  ),
                  const SizedBox(height: 50),
                  BounceInLeft(
                    child: ElevatedButton(
                      onPressed: () async {
                        try {
                          await authProvider.login(
                              _emailController.text, _passwordController.text);
                          Navigator.pushReplacementNamed(context, '/home');
                        } catch (e) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              showCloseIcon: true,
                              elevation: 5,
                              content: Text(e.toString()),
                            ),
                          );
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: const Color(0xffCD465C),
                      ),
                      child: const Text('Iniciar sesión'),
                    ),
                  ),
                  const SizedBox(height: 200),
                ],
              ),
            ),
            Positioned(
              top: 20,
              left: 15,
              child: Center(
                child: Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 253, 171, 29),
                    borderRadius: BorderRadius.circular(50),
                  ),
                ),
              ),
            ),
            Positioned(
              top: 240,
              right: -25,
              child: Center(
                child: Container(
                  width: 70,
                  height: 70,
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 253, 171, 29),
                    borderRadius: BorderRadius.circular(50),
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: 10,
              left: -35,
              child: Center(
                child: Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 253, 171, 29),
                    borderRadius: BorderRadius.circular(50),
                  ),
                ),
              ),
            )
          ],
        )),
      ),
    );
  }
}
