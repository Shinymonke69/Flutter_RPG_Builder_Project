import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../services/auth_service.dart';
import '../../../app_routes.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmController = TextEditingController();

  String? error;

  Future<void> _register(AuthService authService) async {
    setState(() {
      error = null;
    });
    if (passwordController.text != confirmController.text) {
      setState(() {
        error = 'As senhas estão diferentes';
      });
      return;
    }
    try {
      await authService.register(emailController.text, passwordController.text);
      if (!mounted) return;
      Navigator.of(context).pushReplacementNamed(AppRoutes.home);
    } catch (e) {
      if (!mounted) return;
      setState(() {
        error = 'Falha ao criar conta: ${e.toString()}';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Cadastro')),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            TextField(
              controller: emailController,
              decoration: const InputDecoration(labelText: 'Email'),
            ),
            TextField(
              controller: passwordController,
              decoration: const InputDecoration(labelText: 'Senha'),
              obscureText: true,
            ),
            TextField(
              controller: confirmController,
              decoration: const InputDecoration(labelText: 'Confirmar senha'),
              obscureText: true,
            ),
            if (error != null)
              Padding(
                padding: const EdgeInsets.only(top: 8),
                child: Text(error!, style: const TextStyle(color: Colors.red)),
              ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () => _register(authService),
              child: const Text('Criar conta'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pushReplacementNamed(AppRoutes.login);
              },
              child: const Text('Já tenho conta'),
            ),
          ],
        ),
      ),
    );
  }
}
