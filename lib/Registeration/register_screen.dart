import 'package:flutter/material.dart';
import 'package:movies/Provider/language_provider.dart';
import 'package:movies/Registeration/forgetpassword_screen.dart';
import 'package:movies/home_screen.dart';
import 'package:movies/Registeration/login_screen.dart';
import 'package:movies/Registeration/register_api_manager.dart';
import 'package:provider/provider.dart';

class RegisterScreen extends StatefulWidget {
  static const String routeName = "RegisterScreen";

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  bool _isObscure = true;
  final _formKey = GlobalKey<FormState>();
  final _apiReg = RegisterApi();

  final List<String> avatars = [
    'assets/images/gamer1.png',
    'assets/images/gamer2.png',
    'assets/images/gamer3.png',
  ];

  int selectedAvatarIndex = 0;
  String _name = "";
  String _email = "";
  String _password = "";
  String _confirmPassword ="" ;
  String _phone = "";
  bool _isLoading = false;


  void _register() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() {
      _isLoading = true;
    });
    final response = await _apiReg.registerUser(_name, _email, _password ,
        _confirmPassword, _phone , selectedAvatarIndex );

    setState(() {
      _isLoading = false;
    });


    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(response["message"]),
        backgroundColor: response["success"] ? Colors.green : Colors.red,
      ),
    );

    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      print("User Name: $_name");
      print("Email: $_email");
      print("Password: $_password");
      print("Confirm Password: $_confirmPassword");
      print("Phone: $_phone");
      print("Avatar ID: $selectedAvatarIndex");
    }


    if (response["success"]) {
      Future.delayed(const Duration(seconds: 2), () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => LoginScreen()),
        );
      });
    }
  }


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
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
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
                  validator: (value) =>
                  value == null || value.isEmpty ? "Please enter your name" : null,
                  onSaved: (value) => _name = value!,
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
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value == null || value.isEmpty) return "Please enter your email";
                    if (!value.contains("@")) return "Enter a valid email address";
                    return null;
                  },
                  onSaved: (value) => _email = value!,
                 style: TextStyle(color: Colors.white),
                ),
                SizedBox(height: 15),
                TextFormField(
                  obscureText:_isObscure,
                  decoration: InputDecoration(
                    hintText: languageProvider.locale.languageCode == 'ar'
                        ? ' كلمه المرور'
                        : 'Password',
                    hintStyle: TextStyle( color: Colors.white),
                    filled: true,
                    fillColor: Color(0XFF282A28),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                    prefixIcon: ImageIcon(AssetImage('assets/images/Passwod_Icon.png') , color: Colors.white,),
                    suffixIcon:IconButton(
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
                    if (value == null || value.length < 6) return "Password must be at least 6 characters";
                    return null;
                  },
                  onSaved: (value) => _password = value!,
                  style: TextStyle(color: Colors.white),
                ),
                SizedBox(height: 15),
                TextFormField(
                  obscureText: _isObscure,
                  decoration: InputDecoration(
                      hintText: languageProvider.locale.languageCode == 'ar'
                          ? '  تأكيد كلمه المرور'
                          : 'Confirm Password',
                      hintStyle: TextStyle( color: Colors.white),
                      filled: true,
                      fillColor: Color(0XFF282A28),
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                      prefixIcon: ImageIcon(AssetImage('assets/images/Passwod_Icon.png') , color: Colors.white,),
                    suffixIcon:IconButton(
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
                  onChanged: (value) => _password = value,
                  validator: (value) {
                    if (value == null || value != _password) return "Passwords do not match";
                    return null;
                  },
                  onSaved: (value) => _confirmPassword = value!,
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
                  keyboardType: TextInputType.phone,
                  validator: (value) =>
                  value == null || value.isEmpty ? "Please enter your phone number" : null,
                  onSaved: (value) => _phone = value!,
                  style: TextStyle(color: Colors.white),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: _register,
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
        ),
      ),
    );
  }
}
