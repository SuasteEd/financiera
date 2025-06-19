import 'package:financiera_app/features/login/presentation/login_screen.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
const SplashScreen({ super.key });

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}


class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    super.initState();
    goToNextScreen(context);
  }


  void goToNextScreen(BuildContext context) {
  Future.delayed(Duration(seconds: 3), () {
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginScreen()));
  });
}
  @override
  Widget build(BuildContext context){
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Center(
        child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Hero(
              tag: 'logo',
              child: Image.network(
                'https://cdn-icons-png.freepik.com/256/9321/9321926.png?semt=ais_hybrid',
              ),
            ),
            const SizedBox(height: 20),
            CircularProgressIndicator(),
          ],
        ),
      ),
    );
  }
}