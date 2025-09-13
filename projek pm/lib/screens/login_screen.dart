import 'package:flutter/material.dart';
import 'package:project_002/screens/admin_screen.dart';
import 'package:provider/provider.dart';
import '../services/auth_service.dart';
import 'home_screen.dart';
import 'register_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  String _error = '';

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthService>(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Login')),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Logo di tengah atas
              Image.asset('assets/img/logo2.png', height: 100),
              const SizedBox(height: 20),

              // Form login
              TextField(
                controller: _emailController,
                decoration: const InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _passwordController,
                decoration: const InputDecoration(
                  labelText: 'Password',
                  border: OutlineInputBorder(),
                ),
                obscureText: true,
              ),
              const SizedBox(height: 20),

              // Error message
              if (_error.isNotEmpty)
                Text(_error, style: const TextStyle(color: Colors.red)),

              const SizedBox(height: 10),

              // Tombol Login
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () async {
                    try {
                      final user = await auth.signIn(
                        _emailController.text.trim(),
                        _passwordController.text.trim(),
                      );
                      final role = await auth.getUserRole(user!.uid);
                      print('Role user: $role');

                      if (context.mounted) {
                        if (role?.trim().toLowerCase() == 'admin') {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (_) => const AdminScreen()),
                          );
                        } else if (role?.trim().toLowerCase() == 'user') {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (_) => const HomeScreen()),
                          );
                        } else {
                          setState(() {
                            _error = 'Akun tidak memiliki peran yang valid.';
                          });
                        }
                      }
                    } catch (e) {
                      setState(() {
                        _error =
                            'Login gagal, masukkan email dan password dengan benar';
                      });
                    }
                  },
                  child: const Text('Login'),
                ),
              ),

              // Tombol ke halaman register
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const RegisterScreen()),
                  );
                },
                child: const Text('Belum punya akun? Register'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
