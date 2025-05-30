import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hotel_crm/config/router/app_router.dart';
import 'package:hotel_crm/config/theme/app_colors.dart';
import 'package:hotel_crm/core/consts/constans.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _animationController;
  late final Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    );
    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(_animationController);
    _animationController.forward();
    _init();
  }

  Future<void> _init() async {
    await Future<void>.delayed(const Duration(seconds: 3));
    if (!mounted) return;

    context.go(Routes.materials);
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final appColors = context.appColors;
    return Scaffold(
      backgroundColor: appColors.primary,
      body: Center(
        child: FadeTransition(
          opacity: _fadeAnimation,
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [Image.asset(Assets.logoPath, width: 150, height: 150)],
            ),
          ),
        ),
      ),
    );
  }
}
