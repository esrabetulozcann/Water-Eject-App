import 'package:flutter/material.dart';

class NavIcon extends StatelessWidget {
  final IconData icon;
  const NavIcon(this.icon, {super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 28,
      height: 28,
      child: Center(child: Icon(icon, size: 22)),
    );
  }
}
