import 'package:flutter/material.dart';
import 'package:movies/Provider/language_provider.dart';
import 'package:movies/login_screen.dart';
import 'package:provider/provider.dart';
class ForgotPasswordScreen extends StatelessWidget {
  static const String routeName = "ForegetPasswordScreen";
  @override
  Widget build(BuildContext context) {

    final languageProvider = Provider.of<LanguageProvider>(context);
    return Scaffold(
      appBar: AppBar( leading: IconButton(onPressed: () {
        Navigator.pushNamed(
            context,LoginScreen.routeName);
      }, icon: Icon(Icons.arrow_back , color: Color(0XFFF6BD00),) ),
        title: Text(languageProvider.locale.languageCode == 'ar'? '  كلمه المرور  ': 'Forget Password', style: TextStyle(color: Color(0XFFF6BD00), fontSize: 16 , fontWeight: FontWeight.bold)),
        backgroundColor: Colors.black,
        centerTitle: true,),
      backgroundColor: Colors.black,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image(image: AssetImage('assets/images/Forgot_Password.png')),
            SizedBox(height: 20),
            TextFormField(
              decoration: InputDecoration(
                hintText: languageProvider.locale.languageCode == 'ar'
                    ? ' الايميل'
                    : 'Email',
                hintStyle: TextStyle( color: Colors.white , fontWeight: FontWeight.bold , fontSize: 16),
                filled: true,
                fillColor: Colors.grey[800],
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                prefixIcon: ImageIcon(AssetImage('assets/images/Email_Icon.png'),color: Colors.white,),
              ),
              style: TextStyle(color: Colors.white),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0XFFF6BD00),
                minimumSize: Size(double.infinity, 50),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
              ),
              child: Text(languageProvider.locale.languageCode == 'ar'? 'تأكيد الايميل': 'Verify Email', style: TextStyle(color: Colors.black , fontWeight: FontWeight.bold , fontSize: 20)),
            ),
          ],
        ),
      ),
    );
  }
}
