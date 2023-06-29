import 'package:bottomnav/profile_page.dart';
import 'package:bottomnav/setting_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

import 'landing_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<BottomNavigationBarItem> items = <BottomNavigationBarItem>[
    const BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
    const BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
    const BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Setting'),
  ];
  int index = 0;
  List<Widget> pages = [
    const LandingPage(),
    const ProfilePage(),
    const SettingPage(),
  ];

//this items will used for show element in navigation rails
  List<NavigationRailDestination> destinations = [
    const NavigationRailDestination(
        icon: Icon(Icons.home), label: Text('Home')),
    const NavigationRailDestination(
        icon: Icon(Icons.person), label: Text('Profile')),
    const NavigationRailDestination(
        icon: Icon(Icons.settings), label: Text('Setting')),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Navigations'),
      ),
      body: kIsWeb ||
              Orientation.landscape == MediaQuery.of(context).orientation
          ? Row(
              children: [
                NavigationRail(
                  destinations: destinations,
                  selectedIndex: index,
                  onDestinationSelected: updateSelected,
                  // extended: true,
                  // minExtendedWidth: 140,
                  labelType: NavigationRailLabelType.all,
                  selectedLabelTextStyle: const TextStyle(color: Colors.green),
                  leading: Container(
                    height: 100,
                    color: Colors.green,
                    child: const Text('Header'),
                  ),
                  trailing: SizedBox(
                    height: 100,
                    child: Column(
                      children: const [
                        Text('Ver : 5.4'),
                        SizedBox(
                          height: 20,
                        ),
                        Text('LogOut')
                      ],
                    ),
                  ),
                  minWidth: 80,
                ),
                SizedBox(
                    width: MediaQuery.of(context).size.width - 100,
                    child: pages[index])
              ],
            )
          : pages[index],
      bottomNavigationBar:
          !kIsWeb && Orientation.portrait == MediaQuery.of(context).orientation
              ? BottomNavigationBar(
                  items: items,
                  currentIndex: index,
                  onTap: updateSelected,
                )
              : null,
    );
  }

  updateSelected(int i) {
    setState(() {
      index = i;
    });
  }
}
