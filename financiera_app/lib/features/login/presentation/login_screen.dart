import 'package:financiera_app/core/widgets/custom_button.dart';
import 'package:financiera_app/core/widgets/custom_text_field.dart';
import 'package:financiera_app/features/home/presentation/home_screen.dart';
import 'package:financiera_app/features/login/domain/login_service.dart';
import 'package:financiera_app/features/login/presentation/providers/login_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return ChangeNotifierProvider(
      create: (_) => LoginProvider(),
      builder: (context, child) {
        final loginProvider = Provider.of<LoginProvider>(context);
        return Scaffold(
          body: Padding(
            padding: const EdgeInsets.all(20),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(height: 50),
                  SizedBox(
                    height: size.height * 0.4,
                    child: Hero(
                      tag: 'logo',
                      child: Image.network(
                        'https://cdn-icons-png.freepik.com/256/9321/9321926.png?semt=ais_hybrid',
                      ),
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
                    controller: loginProvider.emailController,
                    hintText: 'Email',
                    keyboardType: TextInputType.emailAddress,
                    textCapitalization: TextCapitalization.none,
                    onChanged: (value) {
                      loginProvider.changeEmail(value);
                    },
                    validator: (value) {
                      return loginProvider.emailError;
                    },
                  ),
                  const SizedBox(height: 10),
                  CustomTextFormField(
                    controller: loginProvider.passwordController,
                    hintText: 'Contraseña',
                    obscureText: !loginProvider.showPassword,
                    maxLines: 1,
                    keyboardType: TextInputType.visiblePassword,
                    suffixIcon: IconButton(
                      icon: Icon(
                        loginProvider.showPassword
                            ? Icons.visibility
                            : Icons.visibility_off,
                      ),
                      onPressed: () {
                        loginProvider.togglePasswordVisibility();
                      },
                    ),
                    onChanged: (value) {
                      loginProvider.changePassword(value);
                    },
                    validator: (value) {
                      return loginProvider.passwordError;
                    },
                  ),
                  const SizedBox(height: 20),
                  CustomButtonWidget(
                    text: 'Iniciar sesión',
                    isLoading: loginProvider.isLoading,
                    texTcolor: Colors.white,
                    onPressed: () {
                      if (!loginProvider.isLoading) {
                        if (loginProvider.isFormValid()) {
                          loginProvider.login().then((success) {
                            if (success) {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const HomeScreen(),
                                ),
                              );
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text(
                                    'Error al iniciar sesión. Por favor, inténtelo de nuevo.',
                                  ),
                                ),
                              );
                            }
                          });
                        } else {
                          loginProvider.setLoading(false);
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text(
                                'Por favor, complete el formulario correctamente.',
                              ),
                            ),
                          );
                        }
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
