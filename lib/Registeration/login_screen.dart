import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:movies/Provider/language_provider.dart';
import 'package:movies/Registeration/forgetpassword_screen.dart';
import 'package:movies/Registeration/register_api_manager.dart';
import 'package:movies/home_screen.dart';
import 'package:movies/Registeration/register_screen.dart';
import 'package:provider/provider.dart';

import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  static const String routeName = "LoginScreen";
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _isObscure = true;
  final _formKey = GlobalKey<FormState>();
  final _apiLog = RegisterApi();

  String _email = "";
  String _password = "";
  bool _isLoading = false;

  void _login() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      _isLoading = true;
    });

    final response = await _apiLog.loginUser(_email, _password);

    setState(() {
      _isLoading = false;
    });

    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('auth_token');

    if (token != null) {
      await prefs.setBool('isLoggedIn', true);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Login successful"),
          backgroundColor: Colors.green,
        ),
      );
      Navigator.pushReplacementNamed(context, HomeScreen.routName);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Login failed"),
          backgroundColor: Colors.red,
        ),
      );
    }

    // ScaffoldMessenger.of(context).showSnackBar(
    //   SnackBar(
    //     content: Text(response["message"]),
    //     backgroundColor: response["success"] ? Colors.green : Colors.red,
    //   ),
    // );

    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      print("Email: $_email");
      print("Password: $_password");
    }
    // if (response["success"]) {
    //   // Navigator.pushReplacement(
    //   //   context,
    //   //   MaterialPageRoute(builder: (context) => HomeScreen()),
    //   // );
    //   Navigator.pushNamed(context, HomeScreen.routName);
    // }
  }

  @override
  Widget build(BuildContext context) {
    final languageProvider = Provider.of<LanguageProvider>(context);
    return Scaffold(
      backgroundColor: Colors.black,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Image(image: AssetImage("assets/images/splash.png")),
              const SizedBox(height: 20),
              TextFormField(
                decoration: InputDecoration(
                    hintText: languageProvider.locale.languageCode == 'ar'
                        ? 'البريد الإلكتروني'
                        : 'Email',
                    filled: true,
                    fillColor: const Color(0XFF282A28),
                    hintStyle: const TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    prefixIcon: const ImageIcon(
                      AssetImage('assets/images/Email_Icon.png'),
                      color: Colors.white,
                    )),
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please enter your email";
                  }
                  if (!value.contains("@")) {
                    return "Enter a valid email address";
                  }
                  return null;
                },
                onSaved: (value) => _email = value!,
                style: const TextStyle(color: Colors.white),
              ),
              const SizedBox(height: 15),
              TextFormField(
                obscureText: _isObscure,
                decoration: InputDecoration(
                  hintText: languageProvider.locale.languageCode == 'ar'
                      ? 'كلمة المرور'
                      : 'Password',
                  filled: true,
                  fillColor: const Color(0XFF282A28),
                  hintStyle: const TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  prefixIcon: const ImageIcon(
                    AssetImage('assets/images/Passwod_Icon.png'),
                    color: Colors.white,
                  ),
                  suffixIcon: IconButton(
                    icon: Icon(
                      _isObscure ? Icons.visibility_off : Icons.visibility,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      setState(() {
                        _isObscure = !_isObscure;
                      });
                    },
                  ),
                ),
                validator: (value) {
                  if (value == null || value.length < 6) {
                    return "Password must be at least 6 characters";
                  }
                  return null;
                },
                onSaved: (value) => _password = value!,
                style: const TextStyle(color: Colors.white),
              ),
              const SizedBox(height: 10),
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const ForgotPasswordScreen()),
                    );
                  },
                  child: Text(
                      languageProvider.locale.languageCode == 'ar'
                          ? 'نسيت كلمة المرور؟'
                          : 'Forgot Password?',
                      style: const TextStyle(
                          color: Color(0XFFF6BD00),
                          fontWeight: FontWeight.bold)),
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _login,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0XFFF6BD00),
                  minimumSize: const Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15)),
                ),
                child: Text(
                    languageProvider.locale.languageCode == 'ar'
                        ? 'تسجيل الدخول'
                        : 'Login',
                    style: const TextStyle(color: Colors.black, fontSize: 16)),
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                      languageProvider.locale.languageCode == 'ar'
                          ? '  ليس لدى حساب ؟'
                          : 'Don’t Have Account ? ',
                      style: const TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold)),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const RegisterScreen()),
                      );
                    },
                    child: Text(
                      languageProvider.locale.languageCode == 'ar'
                          ? 'إنشاء'
                          : 'Create one',
                      style: const TextStyle(
                          color: Color(0XFFF6BD00),
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              const Text('OR', style: TextStyle(color: Colors.white)),
              const SizedBox(height: 10),
              ElevatedButton.icon(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0XFFF6BD00),
                  minimumSize: const Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15)),
                ),
                icon: SvgPicture.asset(
                  'assets/images/google.svg',
                  width: 20,
                  height: 20,
                ),
                label: Text(
                    languageProvider.locale.languageCode == 'ar'
                        ? 'تسجيل الدخول بحساب جوجل'
                        : 'Login with Google',
                    style: const TextStyle(color: Colors.black, fontSize: 16)),
              ),
              const SizedBox(height: 20),
              GestureDetector(
                onTap: () {
                  languageProvider.toggleLanguage();
                },
                child: Container(
                  width: 70,
                  height: 35,
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: const Color(0XFFF6BD00),
                      width: 2,
                    ),
                  ),
                  child: Stack(
                    children: [
                      AnimatedAlign(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                        alignment: languageProvider.locale.languageCode == 'ar'
                            ? Alignment.centerRight
                            : Alignment.centerLeft,
                        child: Container(
                          width: 30,
                          height: 30,
                          decoration: const BoxDecoration(
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
      ),
    );
  }
}
