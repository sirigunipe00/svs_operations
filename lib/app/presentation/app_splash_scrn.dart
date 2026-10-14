import 'package:flutter/material.dart';
import 'package:svs_operations/styles/icons.dart';

class AppSplashScreen extends StatelessWidget {
  const AppSplashScreen({
    super.key,
    this.version = '1.0.0',
    this.progress, // 0.0 - 1.0, null = indeterminate animation
  });

  final String version;
  final double? progress;

  static const _gradientTop = Color(0xFF0B1F3F);
  static const _gradientMid = Color(0xFF0D3B7D);
  static const _gradientBottom = Color(0xFF1E78DC);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: null,
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [_gradientTop, _gradientMid, _gradientBottom],
            stops: [0.0, 0.45, 1.0],
          ),
        ),
        child: Stack(
          children: [
            // Decorative concentric circles (top-right)
            Positioned(
              top: -140,
              right: -140,
              child: _circle(340, Colors.white.withOpacity(0.06)),
            ),
            Positioned(
              top: -140,
              right: -80,
              child: _circle(220, Colors.white.withOpacity(0.07)),
            ),
            Positioned(
              top: -140,
              right: -20,
              child: _circle(100, Colors.white.withOpacity(0.12)),
            ),

            // Logo + title
            Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 166,
                    height: 78,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 12,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Image.asset(
                      AppIcons.aparnaLogo.path,
                      fit: BoxFit.contain,
                    ),
                  ),
                  const SizedBox(height: 28),
                  Text(
                    'OPERATIONS',
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.85),
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 2.5,
                    ),
                  ),
                ],
              ),
            ),

            // Progress bar + version (bottom)
            Positioned(
              left: 0,
              right: 0,
              bottom: 24,
              child: SafeArea(
                top: false,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(
                      width: 120,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(2),
                        child: LinearProgressIndicator(
                          value: progress,
                          minHeight: 3,
                          backgroundColor: Colors.white.withOpacity(0.25),
                          valueColor: const AlwaysStoppedAnimation<Color>(
                            Colors.white,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 14),
                    Text(
                      'Version [$version]',
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.85),
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _circle(double size, Color color) => Container(
        width: size,
        height: size,
        decoration: BoxDecoration(shape: BoxShape.circle, color: color),
      );
}