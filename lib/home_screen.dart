import 'package:flutter/material.dart';
import 'package:movies/Taps/browse_tap.dart';
import 'package:movies/Taps/home_tap.dart';
import 'package:movies/Taps/profile_tap.dart';
import 'package:movies/Taps/search_tap.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  static const String routName ='HomeScreen';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  int _selectedIndex = 0;

  final List<Widget> _pages = [
    HomeTap(),
    SearchTab(),
    BrowseTap(),
    ProfileScreen()
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(

      body: IndexedStack(
        index: _selectedIndex,
        children: _pages,
      ),

          backgroundColor: Colors.transparent,
          bottomNavigationBar: BottomNavigationBar(
              currentIndex: _selectedIndex,
              onTap: _onItemTapped,
              selectedItemColor: Color(0XFFF6BD00),
              unselectedItemColor: Colors.white,
              backgroundColor: Color(0XFF282A28),
              showSelectedLabels: false,
              showUnselectedLabels: false,
              type: BottomNavigationBarType.fixed,
              items: [
                BottomNavigationBarItem(icon: ImageIcon(AssetImage('assets/images/home.png') , ), label: '',),
                BottomNavigationBarItem(icon: ImageIcon(AssetImage('assets/images/search.png'), ) , label: "",),
                BottomNavigationBarItem(icon: ImageIcon(AssetImage('assets/images/browse.png'), ) , label: "",),
                BottomNavigationBarItem(icon: ImageIcon(AssetImage('assets/images/Profiel.png'), ) , label: "",),
              ]
          ),

        );



  }
}









// class Screen4 extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.blueAccent,
//       body: Center(
//         child: Text("Profile Screen", style: TextStyle(fontSize: 24, color: Colors.white)),
//       ),
//     );
//   }
// }



