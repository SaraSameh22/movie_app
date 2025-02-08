import 'package:flutter/material.dart';
import 'package:movies/Provider/language_provider.dart';
import 'package:movies/forgetpassword_screen.dart';
import 'package:movies/login_screen.dart';
import 'package:provider/provider.dart';

class RegisterScreen extends StatefulWidget {
  static const String routeName = "RegisterScreen";

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final List<String> avatars = [
    'assets/images/gamer1.png',
    'assets/images/gamer2.png',
    'assets/images/gamer3.png',
  ];

  int selectedAvatarIndex = 0;

  @override
  Widget build(BuildContext context) {
    final languageProvider = Provider.of<LanguageProvider>(context);
    return Scaffold(
      appBar: AppBar( leading: IconButton(onPressed: () {
        Navigator.pushNamed(
          context,LoginScreen.routeName);
      }, icon: Icon(Icons.arrow_back , color: Color(0XFFF6BD00),) ),
        title: Text(languageProvider.locale.languageCode == 'ar'? 'إنشاء حساب ': 'Register', style: TextStyle(color: Color(0XFFF6BD00), fontSize: 24)),
      backgroundColor: Colors.black,
      centerTitle: true,),
      backgroundColor: Colors.black,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 20),
            Container(
              height: 100,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: avatars.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedAvatarIndex = index;
                      });
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: CircleAvatar(
                        radius: 40,
                        backgroundColor: selectedAvatarIndex == index
                            ? Colors.yellow
                            : Colors.transparent,
                        child: CircleAvatar(
                          radius: 36,
                          backgroundImage: AssetImage(avatars[index]),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: 20),
            TextFormField(
              decoration: InputDecoration(
                hintText: languageProvider.locale.languageCode == 'ar'
                    ? ' الاسم'
                    : 'Name',
                hintStyle: TextStyle( color: Colors.white),
                filled: true,
                fillColor: Color(0XFF282A28),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                prefixIcon: ImageIcon(AssetImage('assets/images/Name_Icon.png') , color: Colors.white,)
              ),
              style: TextStyle(color: Colors.white),
            ),
            SizedBox(height: 15),
            TextFormField(
              decoration: InputDecoration(
                hintText: languageProvider.locale.languageCode == 'ar'
                    ? ' البريد الالكترونى'
                    : 'Email',
                hintStyle: TextStyle( color: Colors.white),
                filled: true,
                fillColor: Color(0XFF282A28),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                prefixIcon: ImageIcon(AssetImage('assets/images/Email_Icon.png') , color: Colors.white,)
              ),
              style: TextStyle(color: Colors.white),
            ),
            SizedBox(height: 15),
            TextFormField(
              obscureText: true,
              decoration: InputDecoration(
                hintText: languageProvider.locale.languageCode == 'ar'
                    ? ' كلمه المرور'
                    : 'Password',
                hintStyle: TextStyle( color: Colors.white),
                filled: true,
                fillColor: Color(0XFF282A28),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                prefixIcon: ImageIcon(AssetImage('assets/images/Passwod_Icon.png') , color: Colors.white,)
              ),
              style: TextStyle(color: Colors.white),
            ),
            SizedBox(height: 15),
            TextFormField(
              decoration: InputDecoration(
                hintText: languageProvider.locale.languageCode == 'ar'
                    ? ' رقم الهاتف'
                    : 'Phone number',
                hintStyle: TextStyle( color: Colors.white),
                filled: true,
                fillColor: Color(0XFF282A28),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                prefixIcon: ImageIcon(AssetImage('assets/images/Phone_Icon.png') , color: Colors.white,)
              ),
              style: TextStyle(color: Colors.white),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => ForgotPasswordScreen()),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0XFFF6BD00),
                minimumSize: Size(double.infinity, 50),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
              ),
              child: Text(languageProvider.locale.languageCode == 'ar'? 'إنشاء حساب': 'Create Account', style: TextStyle(color: Colors.black ,fontSize: 20)),
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(languageProvider.locale.languageCode == 'ar'? ' لدى حساب': 'Already have an Account', style: TextStyle(color: Colors.white , fontWeight: FontWeight.bold )),
                SizedBox(width:2),
                GestureDetector(
                  onTap: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => LoginScreen()),
                    );
                  },
                  child: Text(languageProvider.locale.languageCode == 'ar'? 'تسجيل الدخول': 'Login', style: TextStyle(color: Color(0XFFF6BD00), fontWeight: FontWeight.bold)),
                ),
              ],
            ),
            SizedBox(height: 10,),
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
    // Background for the active side
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
