import 'package:flutter/material.dart';
import 'package:movies/Provider/language_provider.dart';
import 'package:movies/Registeration/login_screen.dart';
import 'package:movies/home_screen.dart';
import 'package:provider/provider.dart';

class ForgotPasswordScreen extends StatefulWidget {
  static const String routeName = "ForegetPasswordScreen";

  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final languageProvider = Provider.of<LanguageProvider>(context);
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.pushNamed(context, LoginScreen.routeName);
            },
            icon: const Icon(
              Icons.arrow_back,
              color: Color(0XFFF6BD00),
            )),
        title: Text(
            languageProvider.locale.languageCode == 'ar'
                ? '  كلمه المرور  '
                : 'Forget Password',
            style: const TextStyle(
                color: Color(0XFFF6BD00),
                fontSize: 16,
                fontWeight: FontWeight.bold)),
        backgroundColor: Colors.black,
        centerTitle: true,
      ),
      backgroundColor: Colors.black,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Image(image: AssetImage('assets/images/Forgot_Password.png')),
              const SizedBox(height: 20),
              TextFormField(
                decoration: InputDecoration(
                  hintText: languageProvider.locale.languageCode == 'ar'
                      ? ' الايميل'
                      : 'Email',
                  hintStyle: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16),
                  filled: true,
                  fillColor: Colors.grey[800],
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  prefixIcon: const ImageIcon(
                    AssetImage('assets/images/Email_Icon.png'),
                    color: Colors.white,
                  ),
                ),
                style: const TextStyle(color: Colors.white),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, HomeScreen.routName);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0XFFF6BD00),
                  minimumSize: const Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15)),
                ),
                child: Text(
                    languageProvider.locale.languageCode == 'ar'
                        ? 'تأكيد الايميل'
                        : 'Verify Email',
                    style: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 20)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
