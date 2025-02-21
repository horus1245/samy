import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:samy/core/services/device_services.dart';
import 'package:samy/screens/battary/battary_screen.dart';
import 'package:samy/screens/login/widget/login_view_body.dart';
import 'package:samy/screens/login/widget/logo_widget.dart';
import 'package:samy/screens/map/map_screen.dart';
import 'package:samy/screens/notifications/notificaion_screen.dart';
import 'package:samy/screens/profile_page/profile_screen.dart';
import 'package:samy/screens/sign_up/widgets/signUp_view_body.dart';
import 'package:samy/screens/sign_up/widgets/sign_up_form.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  final List<Widget> _pages = [
    const LogoWidget(),
    const Loginviewbody(),
    const SignUpFrom(),
    const SignupViewBody(),
    const MapPage(),
    const BatteryPage(),
    const NotificationsPage(),
    const ProfilePage()
  ];

  @override
  void initState() {
    super.initState();
    DeviceService.instance.connectToDevice();
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: _pages[_selectedIndex],
        bottomNavigationBar: NavigationBar(
          destinations: const [
            NavigationDestination(
              selectedIcon: Icon(IconlyBold.location),
              icon: Icon(IconlyLight.location),
              label: 'Map',
            ),
            NavigationDestination(
              selectedIcon: Icon(Icons.battery_full),
              icon: Icon(Icons.battery_full),
              label: 'Battery',
            ),
            NavigationDestination(
              selectedIcon: Icon(IconlyBold.notification),
              icon: Icon(Icons.notifications),
              label: 'Notifications',
            ),
            NavigationDestination(
              selectedIcon: Icon(IconlyBold.profile),
              icon: Icon(Icons.person),
              label: 'Profile',
            ),
          ],
          selectedIndex: _selectedIndex,
          onDestinationSelected: _onItemTapped,
        )

        //  BottomNavigationBar(
        //   type: BottomNavigationBarType.fixed,
        //   items: const <BottomNavigationBarItem>[
        //     BottomNavigationBarItem(
        //       icon: Icon(Icons.location_on),
        //       label: 'Map',
        //     ),
        //     BottomNavigationBarItem(
        //       icon: Icon(Icons.battery_full),
        //       label: 'Battery',
        //     ),
        //     BottomNavigationBarItem(
        //       icon: Icon(Icons.notifications),
        //       label: 'Notifications',
        //     ),
        //     BottomNavigationBarItem(
        //       icon: Icon(Icons.person),
        //       label: 'Profile',
        //     ),
        //   ],
        //   currentIndex: _selectedIndex,
        //   onTap: _onItemTapped,
        // ),
        );
  }
}
