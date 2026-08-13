import 'package:svs_operations/styles/icons.dart';
import 'package:flutter/material.dart';

class AppSplashScreen extends StatelessWidget {
  const AppSplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: null,
      body: Center(child: Image.asset(AppIcons.aparnaLogo.path)),
    );
  }
}