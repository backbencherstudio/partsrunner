import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:partsrunner/core/routes/app_route_names.dart';
import 'package:partsrunner/core/services/api_service/token_service.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    Future.delayed(const Duration(seconds: 1), () async {
      if (mounted) {
        final isLoggedIn = await _isLoggedin();
        if (isLoggedIn) {
          context.goNamed(AppRouteNames.bottomNav);
        } else {
          context.goNamed(AppRouteNames.onboarding);
        }
      }
    });
  }

  Future<bool> _isLoggedin() async {
    final token = await TokenService.getToken();
    return token != null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(child: Image.asset("assets/icons/logo.png")));
  }
}
