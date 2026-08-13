import 'package:svs_operations/styles/app_colors.dart';
import 'package:svs_operations/widgets/app_spacer.dart';
import 'package:flutter/material.dart';


class FeatureWidget extends StatelessWidget {
  const FeatureWidget({
    required this.title,
    required this.icon,
    required this.onClick,
    super.key,
    required this.viewCount,
    required this.chartCount,
  });
  final String title;
  final IconData icon;
  final int viewCount;
  final int chartCount;
  final void Function() onClick;

  @override
  Widget build(BuildContext context) {
    final viewCount1 = viewCount.toString();
    final chartCount1 = chartCount.toString();
    return Card(
      color: AppColors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(6.0),
      ),
      surfaceTintColor: AppColors.white,
      child: InkWell(
        onTap: onClick,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    child: Text(
                      title,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: AppColors.chimneySweep,
                          fontSize: 15),
                      textAlign: TextAlign.start,
                    ),
                  ),
                  Icon(icon),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      const Icon(
                        Icons.visibility,
                        color: AppColors.chimneySweep,
                        size: 15,
                      ),
                      Text(viewCount1)
                    ],
                  ),
                  AppSpacer.p8(),
                   Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      const Icon(
                        Icons.bar_chart,
                        color: AppColors.chimneySweep,
                        size: 15,
                      ),
                      Text(chartCount1)
                    ],
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
