import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:movies/Provider/history_provider.dart';
import 'package:movies/Provider/language_provider.dart';
import 'package:movies/Registeration/forgetpassword_screen.dart';
import 'package:movies/Registeration/login_screen.dart';
import 'package:movies/home_screen.dart';
import 'package:movies/onboarding_screen.dart';
import 'package:movies/Registeration/register_screen.dart';
import 'package:movies/splash_screen.dart';
import 'package:provider/provider.dart';
import 'package:movies/Taps/profile_update_screen.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => LanguageProvider()),
        ChangeNotifierProvider(create: (_) => HistoryManager()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<LanguageProvider>(
      builder: (context, languageProvider, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          locale: languageProvider.locale,
          supportedLocales: const [
            Locale('en'),
            Locale('ar'),
          ],
          localizationsDelegates: const [
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
          initialRoute: SplashScreen.routeName,
          routes: {
            SplashScreen.routeName: (context) => const SplashScreen(),
            OnboardingScreen.routeName: (context) => const OnboardingScreen(),
            LoginScreen.routeName: (context) => const LoginScreen(),
            RegisterScreen.routeName: (context) => const RegisterScreen(),
            ForgotPasswordScreen.routeName: (context) => const ForgotPasswordScreen(),
            HomeScreen.routName: (context) => const HomeScreen(),
            UpdateProfileScreen.routName: (context) => const UpdateProfileScreen(),
          },
        );
      },
    );
  }
}
