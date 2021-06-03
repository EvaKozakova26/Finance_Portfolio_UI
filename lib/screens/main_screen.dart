import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mystocks_ui/components/side_menu.dart';
import 'package:mystocks_ui/dashboard_screen.dart';

class MainScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              // 1/6 part of the screen by default
              child: SideMenu()
            ),
            Expanded(
              // 5/6 part of the screen
              flex: 5,
              child: DashboardScreen()
            )
          ],
        )
      ),
    );
  }
}