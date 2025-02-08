import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:movies/Provider/language_provider.dart';
import 'package:movies/forgetpassword_screen.dart';
import 'package:movies/home_screen.dart';
import 'package:movies/register_screen.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatelessWidget {
  static const String routeName = "LoginScreen";
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final languageProvider = Provider.of<LanguageProvider>(context);
    return Scaffold(
      backgroundColor: Colors.black,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image(image: AssetImage("assets/images/splash.png")),
            SizedBox(height: 20),
             TextFormField(
              decoration: InputDecoration(
                hintText: languageProvider.locale.languageCode == 'ar'
                    ? 'البريد الإلكتروني'
                    : 'Email',
                filled: true,
                fillColor: Color(0XFF282A28),
                hintStyle: TextStyle( color: Colors.white , fontWeight: FontWeight.bold),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                prefixIcon: ImageIcon(AssetImage('assets/images/Email_Icon.png') , color: Colors.white,)
              ),
              style: TextStyle(color: Colors.white),
            ),
            SizedBox(height: 15),
             TextFormField(
              obscureText: true,
              decoration: InputDecoration(
                hintText: languageProvider.locale.languageCode == 'ar'
                    ? 'كلمة المرور'
                    : 'Password',
                filled: true,
                fillColor: Color(0XFF282A28),
                hintStyle: TextStyle( color: Colors.white , fontWeight: FontWeight.bold),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                prefixIcon: ImageIcon(AssetImage('assets/images/Passwod_Icon.png') , color: Colors.white,),
                suffixIcon: Icon(Icons.visibility_off, color: Colors.white),
              ),
              style: TextStyle(color: Colors.white),
            ),
            SizedBox(height: 10),
      Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => ForgotPasswordScreen()),
                  );
                },
                child: Text( languageProvider.locale.languageCode == 'ar'? 'نسيت كلمة المرور؟': 'Forgot Password?', style: TextStyle(color: Color(0XFFF6BD00) , fontWeight: FontWeight.bold)),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => HomeScreen()),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0XFFF6BD00),
                minimumSize: Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
              ),
              child: Text(languageProvider.locale.languageCode == 'ar'? 'تسجيل الدخول': 'Login', style: TextStyle(color: Colors.black  , fontSize: 16)),
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(languageProvider.locale.languageCode == 'ar'? '  ليس لدى حساب ؟': 'Don’t Have Account ? ', style: TextStyle(color: Colors.white , fontWeight: FontWeight.bold)),
                GestureDetector(
                  onTap: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => RegisterScreen()),
                    );
                  },
                  child: Text(
                    languageProvider.locale.languageCode == 'ar'? 'إنشاء': 'Create one',
                    style: TextStyle(color: Color(0XFFF6BD00), fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            Text('OR', style: TextStyle(color: Colors.white)),
            SizedBox(height: 10),
            ElevatedButton.icon(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0XFFF6BD00),
                minimumSize: Size(double.infinity, 50),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
              ),
              icon: SvgPicture.asset(
                'assets/images/google.svg',
                width: 20,
                height: 20,
              ),
              label: Text(languageProvider.locale.languageCode == 'ar'? 'تسجيل الدخول بحساب جوجل': 'Login with Google', style: TextStyle(color: Colors.black , fontSize: 16) ),

            ),
            SizedBox(height: 20),
            GestureDetector(
              onTap: () {
                languageProvider.toggleLanguage();
              },
              child: Container(
                width: 70,
                height: 35,
                padding: EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: Color(0XFFF6BD00),
                    width: 2,
                  ),
                ),
                child: Stack(
                  children: [
                    AnimatedAlign(
                      duration: Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                      alignment: languageProvider.locale.languageCode == 'ar'
                          ? Alignment.centerRight
                          : Alignment.centerLeft,
                      child: Container(
                        width: 30,
                        height: 30,
                        decoration: BoxDecoration(
                          color: Color(0XFFF6BD00),
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),
                    // US Flag (English)
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Image.asset(
                        'assets/images/EN.png',
                        width: 25,
                        height: 25,
                      ),
                    ),

                    Align(
                      alignment: Alignment.centerRight,
                      child: Image.asset(
                        'assets/images/EG.png',
                        width: 25,
                        height: 25,
                      ),
                    ),
                  ],
                ),
              ),

            ),

          ],
        ),
      ),

    );
  }
}


