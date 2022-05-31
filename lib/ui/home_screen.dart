import 'package:flutter/material.dart';
import 'package:keda_flutter/ui/bottomNavigation/profileModule/screens/profile_screen.dart';
import 'package:keda_flutter/ui/bottomNavigation/rentalModule/screens/rental_screen.dart';
import 'package:keda_flutter/ui/bottomNavigation/savedModule/screens/saved_screen.dart';
import 'bottomNavigation/explore_module/screens/explore_screen.dart';



import 'bottomNavigation/chatModule/screens/inbox_screen.dart';
import 'bottomNavigation/explore_module/screens/explore_screen.dart';



class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);
  static const routeName = '/home-screen';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  int _currentIndex = 0;
  late List<Map<String, Object>> _widgetOptions;

  @override
  void initState() {
    _widgetOptions = [
      {'page': const ExploreScreen() },
      {'page': SavedScreen() },
      {'page': ProfileScreen() },
      {'page': const InboxScreen() },
      {'page': const RentalScreen() },
    ];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).primaryColor,
      child: SafeArea(
        child: Scaffold(
          bottomNavigationBar: BottomNavigationBar(
            items: const [
              BottomNavigationBarItem(
                  icon: Icon(Icons.search), label: "Explore" ),
              BottomNavigationBarItem(
                  icon: Icon(Icons.bookmark_border), label: "Saved" ),
              BottomNavigationBarItem(
                  icon: Icon(Icons.person_outline), label: "Profile" ),
              BottomNavigationBarItem(
                  icon: Icon(Icons.chat), label: "Inbox" ),
              BottomNavigationBarItem(
                  icon: Icon(Icons.swap_horiz_outlined), label: "Rentals" ),
            ],
            type: BottomNavigationBarType.fixed,
            currentIndex: _currentIndex,
            onTap: (index) {
              setState(() {
                _currentIndex = index;
              });
            },
          ),
          body: _widgetOptions.elementAt(_currentIndex)['page'] as Widget,
        ),
      ),
    );
  }
}
