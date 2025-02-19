import 'package:flutter/material.dart';
import 'package:movies/Registeration/login_screen.dart';

class OnboardingScreen extends StatefulWidget {
  static const String routeName = "OnboardingScreen";

  const OnboardingScreen({super.key});
  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _controller = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: PageView(
              controller: _controller,
              children: [
                buildPoster(
                  imagePath: 'assets/images/onboarding1.png',
                  title: 'Find Your Next\n Favorite Movie Here',
                  description:
                      'Get access to a huge library of movies\n to suit all tastes. you will surely like it',
                  buttonText: 'Explore Now',
                  buttonAction: () => _controller.nextPage(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                  ),
                ),
                buildPage(
                    imagePath: 'assets/images/onboarding2.png',
                    title: 'Discover Movies',
                    description:
                        'Explore a vast collection of movies in all qualities and genres  Find your next favorite film with ease.',
                    buttonText: 'Next',
                    buttonAction: () => _controller.nextPage(
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeInOut,
                        ),
                    buttonText2: 'Back',
                    buttonAction2: () => _controller.previousPage(
                          duration: const Duration(microseconds: 300),
                          curve: Curves.easeInOut,
                        )),
                buildPage(
                    imagePath: 'assets/images/onboarding3.png',
                    title: 'Explore All Genres',
                    description:
                        'Discover movies from every genre, in all available qualities. Find something new and exciting to watch every day.',
                    buttonText: 'Next',
                    buttonAction: () => _controller.nextPage(
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeInOut,
                        ),
                    buttonText2: 'Back',
                    buttonAction2: () => _controller.previousPage(
                          duration: const Duration(microseconds: 300),
                          curve: Curves.easeInOut,
                        )),
                buildPage(
                    imagePath: 'assets/images/onboarding4.png',
                    title: 'Create Watchlists',
                    description:
                        'Save movies to your watchlist to keep track of what you want to watch next.',
                    buttonText: 'Next',
                    buttonAction: () => _controller.nextPage(
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeInOut,
                        ),
                    buttonText2: 'Back',
                    buttonAction2: () => _controller.previousPage(
                          duration: const Duration(microseconds: 300),
                          curve: Curves.easeInOut,
                        )),
                buildPage(
                    imagePath: 'assets/images/onboarding5.png',
                    title: 'Rate, Review, and Learn',
                    description:
                        'Share your thoughts and discover great movies with your reviews.',
                    buttonText: 'Next',
                    buttonAction: () => _controller.nextPage(
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeInOut,
                        ),
                    buttonText2: 'Back',
                    buttonAction2: () => _controller.previousPage(
                          duration: const Duration(microseconds: 300),
                          curve: Curves.easeInOut,
                        )),
                buildPage(
                    imagePath: 'assets/images/onboarding6.png',
                    title: 'Start Watching Now',
                    description: '',
                    buttonText: 'Finish',
                    buttonAction: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => const LoginScreen()),
                      );
                    },
                    buttonText2: 'Back',
                    buttonAction2: () => _controller.previousPage(
                          duration: const Duration(microseconds: 300),
                          curve: Curves.easeInOut,
                        )),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildPage({
    required String imagePath,
    required String title,
    required String description,
    required String buttonText,
    required String buttonText2,
    required VoidCallback buttonAction,
    required VoidCallback buttonAction2,
  }) {
    return Container(
      padding: const EdgeInsets.only(top: 700),
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(imagePath),
          fit: BoxFit.cover,
          colorFilter:
              ColorFilter.mode(Colors.black.withOpacity(0.5), BlendMode.darken),
        ),
      ),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        decoration: const BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(40), topLeft: Radius.circular(40))),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              description,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.white70,
                fontSize: 20,
              ),
            ),
            const SizedBox(height: 8),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: buttonAction,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0XFFF6BD00),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
                child: Text(
                  buttonText,
                  style: const TextStyle(color: Colors.black),
                ),
              ),
            ),
            const SizedBox(height: 8),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: buttonAction2,
                style: ElevatedButton.styleFrom(
                  side: const BorderSide(
                    color: Color(0XFFF6BD00), // Border color
                    width: 2, // Border width
                  ),
                  backgroundColor: Colors.black,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
                child: Text(
                  buttonText2,
                  style: const TextStyle(color: Color(0XFFF6BD00)),
                ),
              ),
            ),
            // SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}

Widget buildPoster({
  required String imagePath,
  required String title,
  required String description,
  required String buttonText,
  required VoidCallback buttonAction,
}) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 16.0),
    decoration: BoxDecoration(
      image: DecorationImage(
        image: AssetImage(imagePath),
        fit: BoxFit.cover,
        colorFilter:
            ColorFilter.mode(Colors.black.withOpacity(0.5), BlendMode.darken),
      ),
    ),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          title,
          textAlign: TextAlign.center,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 10),
        Text(
          description,
          textAlign: TextAlign.center,
          style: const TextStyle(
            color: Colors.white70,
            fontSize: 14,
          ),
        ),
        const SizedBox(height: 20),
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: buttonAction,
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0XFFF6BD00),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
            ),
            child: Text(
              buttonText,
              style: const TextStyle(color: Color(0XFF121312)),
            ),
          ),
        ),
        const SizedBox(height: 16),
      ],
    ),
  );
}
