import 'package:financiera_app/core/widgets/custom_button.dart';
import 'package:financiera_app/core/widgets/custom_text_field.dart';
import 'package:financiera_app/features/home/presentation/home_screen.dart';
import 'package:financiera_app/features/login/domain/login_service.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailCtrl = TextEditingController();
  final _passCtrl = TextEditingController();
  final AuthService _authService = AuthService();

  bool isLoading = false;

  void _login() async {
    setState(() => isLoading = true);

    final success =
        await _authService.login(_emailCtrl.text, _passCtrl.text);

    setState(() => isLoading = false);

    if (success != null) {
     Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomeScreen(user: success)),
      );
      // Redirigir a otra pantalla
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Error al iniciar sesión')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            SizedBox(
              height: size.height * 0.4,
            ),
            CustomTextFormField(
              controller: _emailCtrl,
              hintText: 'Email',
              keyboardType: TextInputType.emailAddress,
              textCapitalization: TextCapitalization.none,
            ),
            CustomTextFormField(
              controller: _passCtrl,
              hintText: 'Contraseña',
              obscureText: true,
              maxLines: 1,
            ),
            const SizedBox(height: 20),
            CustomButtonWidget(
              text: 'Iniciar sesión',
              isLoading: isLoading,
              texTcolor: Colors.white,
              onPressed: () {
                if (!isLoading) {
                  _login();
                }
              })
            // ElevatedButton(
            //   onPressed: isLoading ? null : _login,
            //   child: isLoading
            //       ? const CircularProgressIndicator()
            //       : const Text('Login'),
            // ),
          ],
        ),
      ),
    );
  }
}
