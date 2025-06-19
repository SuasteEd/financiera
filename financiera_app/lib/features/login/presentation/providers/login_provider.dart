import 'package:financiera_app/features/login/domain/login_service.dart';
import 'package:flutter/material.dart';

class LoginProvider extends ChangeNotifier {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool isLoading = false;

  bool showPassword = false;

  bool isError = false;

  String? emailError;
  String? passwordError;

  final AuthService _authService = AuthService();

  void togglePasswordVisibility() {
    showPassword = !showPassword;
    notifyListeners();
  }

  void validateEmail() {
    if (emailController.text.isEmpty) {
      emailError = 'El correo electrónico es obligatorio';
    } else if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(emailController.text)) {
      emailError = 'Ingrese un correo electrónico válido';
    } else {
      emailError = null;
    }
    notifyListeners();
  }

  void validatePassword() {
    if (passwordController.text.isEmpty) {
      passwordError = 'La contraseña es obligatoria';
    } else if (passwordController.text.length < 6) {
      passwordError = 'La contraseña debe tener al menos 6 caracteres';
    } else {
      passwordError = null;
    }
    notifyListeners();
  }

  bool isFormValid() {
    validateEmail();
    validatePassword();
    return emailError == null && passwordError == null;
  }

  void clearForm() {
    emailController.clear();
    passwordController.clear();
    emailError = null;
    passwordError = null;
    notifyListeners();
  }

  void changeEmail(String value) {
    emailController.text = value;
    validateEmail();
  }

  void changePassword(String value) {
    passwordController.text = value;
    validatePassword();
  }

  void setLoading(bool value) {
    isLoading = value;
    notifyListeners();
  }

  Future<bool> login() async {
    if (isFormValid()) {
      setLoading(true);
      final user = await _authService.login(
        emailController.text,
        passwordController.text,
      );
      setLoading(false);
      if (user != null) {
        print('Login successful: ${user.name}');
        return true;
      } else {
        setLoading(false);
        notifyListeners();
      }
    }
    return false;
  }
}
