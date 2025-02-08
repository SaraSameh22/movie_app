import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'onboarding_screen.dart';

class SplashScreen extends StatelessWidget {
  static const String routeName= "SplashScreen";
  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration(seconds: 5), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => OnboardingScreen()),
      );
    });

    return Scaffold(
      backgroundColor: Color(0XFF121312),
      body:
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Spacer(),
                  Image(image: AssetImage('assets/images/splash.png')),
                  Spacer(),
                  Image(image: AssetImage('assets/images/branding.png')),
                  SizedBox(height: 8),
                  Text("Supervised by Mohamed Nabil" , style: TextStyle(
                    color: Colors.white , fontSize: 16
                  ),),
                  SizedBox(height: 22),

                ],
                  ),
            ),
    );
  }
}