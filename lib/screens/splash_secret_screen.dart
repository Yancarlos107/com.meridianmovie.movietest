import 'dart:async';

import 'package:flutter/material.dart';

class SecretScreen extends StatefulWidget {
  const SecretScreen({Key? key}) : super(key: key);

  @override
  State<SecretScreen> createState() => _SecretScreen();
}

class _SecretScreen extends State<SecretScreen> with TickerProviderStateMixin {
  late AnimationController _controller;
  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _controller.repeat();
    return Container(
      color: Colors.white,
      height: double.infinity,
      width: double.infinity,
      child: Center(
          child: AnimatedIcon(
        size: 100,
        color: Colors.black,
        icon: AnimatedIcons.home_menu,
        progress: _controller,
      )),
    );
  }
}
