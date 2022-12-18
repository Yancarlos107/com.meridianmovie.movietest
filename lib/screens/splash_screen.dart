import 'dart:async';

import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreen();
}

class _SplashScreen extends State<SplashScreen> with TickerProviderStateMixin {
  late AnimationController _controller;
  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );
    Timer(
        const Duration(seconds: 1),
        (() => Navigator.pushReplacementNamed(
              context,
              'Home',
            )));
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
        icon: AnimatedIcons.play_pause,
        progress: _controller,
      )),
    );
  }
}
