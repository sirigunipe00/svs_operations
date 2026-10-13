import 'package:flutter/material.dart';
import 'package:svs_operations/core/core.dart';
import 'package:svs_operations/features/gate_exit/model/gate_exit.dart';
import 'package:svs_operations/styles/app_colors.dart';
import 'package:svs_operations/styles/app_text_styles.dart';
import 'package:svs_operations/styles/icons.dart';
import 'package:svs_operations/widgets/app_spacer.dart';
import 'package:svs_operations/widgets/buttons/app_view_btn.dart';
import 'package:svs_operations/widgets/doc_status_widget.dart';
import 'package:svs_operations/widgets/spaced_column.dart';

class GateExitWidget extends StatelessWidget {
  const GateExitWidget({
    super.key,
    required this.gateExit,
    required this.onTap,
  });

  final GateExit gateExit;
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        color: AppColors.white,
        surfaceTintColor: AppColors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
          side: const BorderSide(color: AppColors.shyMoment, width: 2)
        ),
        child: Stack(
          children: [
            Positioned.fill(
              left: context.sizeOfWidth * 0.3,
              child: Image(
                image: AssetImage(AppIcons.gateExitCurves.path),
                fit: BoxFit.fill,
              ),
            ),
            SpacedColumn(
              defaultHeight: 4,
              margin: const EdgeInsets.all(12),
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(gateExit.name, style: AppTextStyles.titleLarge(context).copyWith(color: AppColors.black)),
                    Text(gateExit.exitDate, style: AppTextStyles.titleLarge(context).copyWith(color: AppColors.black)),
                  ],
                ),
                Text(gateExit.salesInvNo, style: AppTextStyles.titleLarge(context).copyWith(color: AppColors.black)),
                AppSpacer.p8(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ViewBtn(onPressed: onTap),
                    DocStatusWidget(status: gateExit.status!.valueOrEmpty),
                  ],
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
