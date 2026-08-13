import 'package:svs_operations/styles/app_colors.dart';
import 'package:svs_operations/widgets/app_spacer.dart';
import 'package:flutter/material.dart';

class AppFeatureWidget extends StatelessWidget {
  const AppFeatureWidget({
    super.key,
    required this.icon,
    required this.title,
    required this.onTap, 
    this.featureColor,
  });

  final Widget icon;
  final Widget title;
  final Color? featureColor;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4),
      child: InkWell(
        onTap: onTap,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: featureColor ?? AppColors.black, width: 1),
            color: featureColor,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min, 
            children: [
              AppSpacer.p12(),
              Flexible( 
                child: Center(child: icon),
              ),
              Container(
                width: double.infinity, 
                margin: const EdgeInsets.all(4),
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Center(
                  child:title, 
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
