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
      padding: const EdgeInsets.all(1),
      child: InkWell(
        onTap: onTap,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color:  AppColors.grey, width: 0.5),
            color: featureColor,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min, 
            children: [
              // AppSpacer.p12(),
              Flexible( 
                child: Center(child: icon),
              ),
              // AppSpacer.p8(),
              Container(
                width: double.infinity, 
                // margin: const EdgeInsets.all(1),
                // padding: const EdgeInsets.all(1),
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Center(
                  child:title, 
                ),
              ),
              AppSpacer.p8()
            ],
          ),
        ),
      ),
    );
  }
}
