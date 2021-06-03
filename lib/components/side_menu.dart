import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SideMenu extends StatelessWidget {
  const SideMenu({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SingleChildScrollView(
        // enables scrolling
        child: Column(
          children: [
            DrawerHeader(
                child: Image.asset("icons/logo.png")
            ),
            DrawerListTile(title: "Dashboard", press: () {}, svgSrc: "icons/menu_dashboard.svg"),
            DrawerListTile(title: "Transactions", press: () {}, svgSrc: "icons/menu_tran.svg")
          ],
        ),
      ),
    );
  }
}


class DrawerListTile extends StatelessWidget {

  const DrawerListTile({
    Key? key,
    required this.title,
    required this.svgSrc,
    required this.press,
  }) : super(key: key);

  final String title, svgSrc;
  final VoidCallback press;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: press,
      horizontalTitleGap: 0.0,
      leading: SvgPicture.asset(
        svgSrc,
        color: Colors.white54,
        height: 16,
      ),
      title: Text(
        title,
        style: TextStyle(color: Colors.white54),
      ),
    );
  }
}