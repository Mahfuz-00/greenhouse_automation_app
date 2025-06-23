import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../Common/Constants/app_colors.dart';
import '../../Common/Constants/app_strings.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _positionAnimation;
  late Animation<double> _glowOpacityAnimation;

  @override
  void initState() {
    super.initState();
    // Initialize animation controller for 3.5-second cycle (2.5s move + 1s pause)
    _controller = AnimationController(
      duration: const Duration(milliseconds: 3500), // Total: 2.5s + 1s
      vsync: this,
    )..repeat(); // Loop animation

    // Animation for left-to-right movement
    _positionAnimation = TweenSequence<double>([
      TweenSequenceItem(
        tween: Tween<double>(begin: -1.2, end: 1.2).chain(
          CurveTween(curve: Curves.easeInOut), // Smooth movement
        ),
        weight: 71.43, // 2.5s / 3.5s
      ),
      TweenSequenceItem(
        tween: ConstantTween<double>(1.2), // Pause at right
        weight: 28.57, // 1s / 3.5s
      ),
    ]).animate(_controller);

    // Animation for glow opacity (fade out during pause)
    _glowOpacityAnimation = TweenSequence<double>([
      TweenSequenceItem(
        tween: ConstantTween<double>(1.0), // Full glow during movement
        weight: 71.43, // 2.5s
      ),
      TweenSequenceItem(
        tween: Tween<double>(begin: 1.0, end: 0.0).chain(
          CurveTween(curve: Curves.easeOut), // Smooth fade out
        ),
        weight: 28.57, // 1s
      ),
    ]).animate(_controller);

    // Check login status and navigate after 5 seconds
    _checkLoginStatus();
  }

  Future<void> _checkLoginStatus() async {
    print('Checking Status');
    await Future.delayed(const Duration(seconds: 5)); // Keep 5-second delay
    if (mounted) {
      final prefs = await SharedPreferences.getInstance();
      final isLoggedIn = prefs.getBool('isLoggedIn') ?? false;
      if (isLoggedIn) {
        context.go('/dashboard');
      } else {
        context.go('/login');
      }
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background image
          Positioned.fill(
            child: Image.asset(
              'Assets/Images/Background.jpg', // Keep original path
              fit: BoxFit.cover, // Ensure image covers screen
            ),
          ),
          // Animated title
          Padding(
            padding: const EdgeInsets.only(bottom: 500.0),
            child: Center(
              child: Stack(
                alignment: Alignment.center,
                children: [
                  // Glow effect layer
                  AnimatedBuilder(
                    animation: _controller,
                    builder: (context, child) {
                      return ShaderMask(
                        shaderCallback: (bounds) {
                          return LinearGradient(
                            begin: Alignment(_positionAnimation.value - 0.3, 0.0),
                            end: Alignment(_positionAnimation.value + 0.3, 0.0),
                            colors: [
                              Colors.transparent,
                              AppColors.primaryLight.withOpacity(_glowOpacityAnimation.value),
                              Colors.transparent,
                            ],
                            stops: const [0.0, 0.5, 1.0],
                          ).createShader(bounds);
                        },
                        blendMode: BlendMode.srcIn,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              AppStrings.appTitle, // "Greenhouse Automation"
                              style: TextStyle(
                                fontFamily: 'Roboto',
                                fontSize: 32,
                                fontWeight: FontWeight.bold,
                                color: Colors.white, // Base for glow
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              'Welcome Greenhouse Automation',
                              style: TextStyle(
                                fontFamily: 'Roboto',
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.white, // Base for glow
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                  // Text layer (always solid)
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        AppStrings.appTitle, // "Greenhouse Automation"
                        style: TextStyle(
                          fontFamily: 'Roboto',
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                          color: AppColors.primary, // Always visible
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Welcome Greenhouse Automation',
                        style: TextStyle(
                          fontFamily: 'Roboto',
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: AppColors.primary, // Always visible
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}