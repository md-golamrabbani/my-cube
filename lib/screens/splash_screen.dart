import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:travel/config/session.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  // splash animation
  late final AnimationController _lottieController =
      AnimationController(vsync: this);

  @override
  void dispose() {
    _lottieController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Stack(
            alignment: Alignment.center,
            children: [
              Center(
                child: Lottie.asset(
                  'assets/json/splash.json',
                  width: 400,
                  repeat: false,
                  controller: _lottieController,
                  onLoaded: (composition) {
                    _lottieController
                      ..duration = composition.duration
                      ..forward().whenComplete(() async {
                        bool isLogin = await Session().isLogin();
                        if (isLogin) {
                          Get.offAllNamed('/home');
                        } else {
                          Get.offAllNamed('/login');
                        }
                      });
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
