// ignore_for_file: prefer_const_constructors

import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery/controllers/auth_controller.dart';
import 'package:food_delivery/controllers/cart_controller.dart';
import 'package:food_delivery/pages/account/account_page.dart';
import 'package:food_delivery/pages/account/own_product.dart';
import 'package:food_delivery/pages/cart/cart_history.dart';

import 'package:food_delivery/pages/home/main_product_page.dart';
import 'package:food_delivery/utils/colors.dart';
import 'package:food_delivery/utils/dimensions.dart';
import 'package:get/get.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 2;
  List pages = [
    OwnProduct(),
    Container(
      child: Center(child: Text("History page")),
    ),
    MainProductPage(),
    //SignInPage(),
    CartHistory(),
    AccountPage(),
  ];
  void onTapNav(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      backgroundColor: Colors.white,
      body: pages[_selectedIndex],
      bottomNavigationBar: CurvedNavigationBar(
          color: Colors.white,
          onTap: onTapNav,
          animationCurve: Curves.easeInOut,
          animationDuration: Duration(milliseconds: 300),
          backgroundColor: Colors.transparent,
          buttonBackgroundColor: AppColors.mainColor,
          height: 50,
          index: 2,
          // ignore: prefer_const_literals_to_create_immutables
          items: [
            Icon(
              Icons.settings_outlined,
              color: _selectedIndex == 0 ? Colors.white : Color(0xFF333333),
              size: Dimensions.iconSize24,
            ),
            Icon(
              Icons.notifications,
              color: _selectedIndex == 1 ? Colors.white : Color(0xFF333333),
              size: Dimensions.iconSize24,
            ),
            Icon(
              Icons.home_outlined,
              size: Dimensions.iconSize24,
              color: _selectedIndex == 2 ? Colors.white : Color(0xFF333333),
            ),
            Icon(
              Icons.shopping_cart,
              size: Dimensions.iconSize24,
              color: _selectedIndex == 3 ? Colors.white : Color(0xFF333333),
            ),
            Icon(
              Icons.person,
              size: Dimensions.iconSize24,
              color: _selectedIndex == 4 ? Colors.white : Color(0xFF333333),
            ),
          ]),
    );
  }
}
// Container(
//         color: Colors.white,
//         child: Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
//           child: GNav(
//             color: Colors.grey.withOpacity(0.8),
//             iconSize: Dimensions.iconSize24,
//             activeColor: AppColors.mainColor,
//             curve: Curves.decelerate,
//             tabActiveBorder: Border.all(color: AppColors.mainColor, width: 2),
//             onTabChange: onTapNav,
//             padding: const EdgeInsets.all(10),
//             gap: 8,
//             tabs: const [
//               GButton(icon: Icons.home_outlined, text: "Home"),
//               GButton(icon: Icons.archive, text: "History"),
//               GButton(icon: Icons.shopping_cart, text: "Cart"),
//               GButton(icon: Icons.person, text: "Me"),
//             ],
//           ),
//         ),
//       ),