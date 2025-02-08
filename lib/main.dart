import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:movies/Provider/language_provider.dart';
import 'package:movies/forgetpassword_screen.dart';
import 'package:movies/login_screen.dart';
import 'package:movies/onboarding_screen.dart';
import 'package:movies/register_screen.dart';
import 'package:movies/splash_screen.dart';
import 'package:provider/provider.dart';


void main() {
  runApp( MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => LanguageProvider()),
    ],
    child: MyApp(),
  ),
  );
}




class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<LanguageProvider>(
      builder: (context, languageProvider, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          locale: languageProvider.locale,
          supportedLocales: [
            Locale('en'),
            Locale('ar'),
          ],
          localizationsDelegates: [
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          localeResolutionCallback: (locale, supportedLocales) {
            return supportedLocales.firstWhere(
                  (supportedLocale) =>
              supportedLocale.languageCode == locale?.languageCode,
              orElse: () => supportedLocales.first,
            );
          },
          initialRoute:SplashScreen.routeName,
      routes: {
        SplashScreen.routeName : (context) => SplashScreen(),
        OnboardingScreen.routeName: (context) => OnboardingScreen(),
        LoginScreen.routeName: (context) => LoginScreen(),
        RegisterScreen.routeName: (context) => RegisterScreen(),
        ForgotPasswordScreen.routeName: (context) => ForgotPasswordScreen(),
      },
        );
      },
    );
  }
}























// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//
//      // home: SplashScreen(),
//       initialRoute:SplashScreen.routeName,
//       routes: {
//         SplashScreen.routeName : (context) => SplashScreen(),
//         OnboardingScreen.routeName: (context) => OnboardingScreen(),
//         LoginScreen.routeName: (context) => LoginScreen(),
//         RegisterScreen.routeName: (context) => RegisterScreen(),
//         ForgotPasswordScreen.routeName: (context) => ForgotPasswordScreen(),
//         // ButtonNavscreen.routeName: (context) => ButtonNavscreen(),
//         // UserListScreen.routeName : (context) => UserListScreen(),
//
//
//         // : (context) => const Homepage(),
//       },
//
//     );
//   }
// }

