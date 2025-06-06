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
  bool showPassword = false;

  void _login() async {
    setState(() => isLoading = true);

    final success = await _authService.login(_emailCtrl.text, _passCtrl.text);

    setState(() => isLoading = false);

    if (success != null) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomeScreen()),
      );
      // Redirigir a otra pantalla
    } else {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Error al iniciar sesión')));
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const SizedBox(height: 50),
            SizedBox(
              height: size.height * 0.4,
              child: Image.network(
                'https://cdn-icons-png.freepik.com/256/9321/9321926.png?semt=ais_hybrid',
              ),
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Iniciar sesión',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              
              ),
            ),
            const SizedBox(height: 20),
            CustomTextFormField(
              controller: _emailCtrl,
              hintText: 'Email',
              keyboardType: TextInputType.emailAddress,
              textCapitalization: TextCapitalization.none,
            ),
            CustomTextFormField(
              controller: _passCtrl,
              hintText: 'Contraseña',
              obscureText: !showPassword,
              
              maxLines: 1,
              keyboardType: TextInputType.visiblePassword,
              suffixIcon: IconButton(
                icon: Icon(showPassword
                    ? Icons.visibility
                    : Icons.visibility_off),
                onPressed: () {
                  setState(() {
                    showPassword = !showPassword;
                  });
                },
              ),
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
              },
            ),
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
