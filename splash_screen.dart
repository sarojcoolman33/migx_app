import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    )..repeat(reverse: true);

    Timer(const Duration(seconds: 3), () {
      Navigator.pushReplacementNamed(context, '/login');
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Widget fadedIcon(IconData icon) {
    return Opacity(
      opacity: 0.1,
      child: Icon(icon, size: 40, color: Colors.black),
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: const Color(0xFFB3E5FC),
      body: Stack(
        children: [
          // Faded background icons
          Positioned(top: 80, left: 30, child: fadedIcon(Icons.card_giftcard)),
          Positioned(top: 160, right: 40, child: fadedIcon(Icons.chat_bubble)),
          Positioned(bottom: 150, left: 50, child: fadedIcon(Icons.sports_baseball)),
          Positioned(bottom: 100, right: 50, child: fadedIcon(Icons.style)),

          // Center logo
          Align(
            alignment: Alignment(0, -0.5),
            child: Image.asset(
              'assets/logo.png',
              width: size.width * 0.4,
              fit: BoxFit.contain,
            ),
          ),

          // Loading dots
          Align(
            alignment: Alignment(0, 0.6),
            child: AnimatedBuilder(
              animation: _controller,
              builder: (context, child) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(4, (index) {
                    return Container(
                      margin: const EdgeInsets.symmetric(horizontal: 4),
                      width: 10,
                      height: 10,
                      decoration: BoxDecoration(
                        color: Colors.orange.withOpacity(
                          (index + 1) / 4 * _controller.value,
                        ),
                        shape: BoxShape.circle,
                      ),
                    );
                  }),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
