import 'package:flutter/material.dart';
import 'package:mystocks_ui/constants/style.dart';

class MyAssetInfo {
  final String? svgSrc, title, diffBalance;
  final num? balance, percentage;
  final Color? color;

  MyAssetInfo({
    this.svgSrc,
    this.title,
    this.diffBalance,
    this.balance,
    this.percentage,
    this.color,
  });
}

List mockMyAsset = [
  MyAssetInfo(
    title: "Bitcoin",
    balance: 0.0025,
    svgSrc: "assets/icons/Documents.svg",
    diffBalance: "-5298 Kč",
    color: Colors.yellow,
    percentage: -35,
  ),
  /*MyAssetInfo(
    title: "Google Drive",
    balance: 1328,
    svgSrc: "assets/icons/google_drive.svg",
    diffBalance: "2.9GB",
    color: Color(0xFFFFA113),
    percentage: 35,
  ),
  MyAssetInfo(
    title: "One Drive",
    balance: 1328,
    svgSrc: "assets/icons/one_drive.svg",
    diffBalance: "1GB",
    color: Color(0xFFA4CDFF),
    percentage: 10,
  ),
  MyAssetInfo(
    title: "Documents",
    balance: 5328,
    svgSrc: "assets/icons/drop_box.svg",
    diffBalance: "7.3GB",
    color: Color(0xFF007EE5),
    percentage: 78,
  ),*/
];