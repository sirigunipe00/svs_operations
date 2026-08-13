import 'package:svs_operations/app/widgets/statusmenu_widget.dart';
import 'package:svs_operations/core/core.dart';
import 'package:svs_operations/core/model/page_view_filters_cubit.dart';
import 'package:svs_operations/styles/app_colors.dart';
import 'package:svs_operations/styles/app_text_styles.dart';
import 'package:svs_operations/widgets/app_spacer.dart';
import 'package:svs_operations/widgets/inputs/simple_search_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

enum PageMode2 {
  gateentry('Gate Entry'),
  gateexit('Gate Exit'),
  incidentregister('Incident Register'),
  inviteVisitor('Invite Visitor'),
  visitorInOut('Visitor In Out Register'),
  createVisit('Create Visit'),
  outWardGatePass('Outward Gate Pass'),
  inWardGatePass('Inward Gate Pass'),
  emptyVehicle('Empty Vehicle Tracking');

  final String name;
  const PageMode2(this.name);
}

class AppPageView2<T extends PageViewFiltersCubit> extends StatelessWidget {
  const AppPageView2({
    super.key,
    required this.child,
    required this.mode,
    required this.onNew,
    required this.backgroundColor,
    required this.scaffoldBg,
  });

  final Widget child;
  final PageMode2 mode;
  final VoidCallback onNew;
  final Color backgroundColor;
  final String scaffoldBg;

  String get hintText => switch (mode) {
    PageMode2.gateentry => 'Search Gate-Entry ID',
    PageMode2.gateexit => 'Search Gate-Exit ID',
    PageMode2.incidentregister => 'Search Incident Register ID',
    PageMode2.inviteVisitor => 'Search Invite Visitor ID',
    PageMode2.visitorInOut => 'Search Visitor In Out',
    PageMode2.createVisit => 'Search Visit ID',
    PageMode2.outWardGatePass => 'Search Gate Pass ID',
    PageMode2.inWardGatePass => 'Search Gate Pass ID',

    PageMode2.emptyVehicle => 'Search Empty Vehicle ID',
  };

  Color get bgColor => switch (mode) {
    PageMode2.gateentry => AppColors.marigoldDDust,
    PageMode2.gateexit => AppColors.shyMoment,
    PageMode2.incidentregister => const Color(0xFF808080),
    PageMode2.inviteVisitor => AppColors.invite,
    PageMode2.visitorInOut => AppColors.registration,
    PageMode2.createVisit => AppColors.invite,
    PageMode2.outWardGatePass => AppColors.shyMoment,
    PageMode2.inWardGatePass => AppColors.marigoldDDust,
    PageMode2.emptyVehicle => AppColors.registration,
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: bgColor,
      body: Stack(
        fit: StackFit.expand,
        children: [
          Positioned(
            left: 52,
            top: -24,
            child: Image.asset(scaffoldBg),
          ),
          Positioned(
            left: 18,
            top: kToolbarHeight - 8,
            child: IntrinsicHeight(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const _GoBackWidget(),
                  AppSpacer.p8(),
                  Text(mode.name,
                      style: AppTextStyles.titleLarge(context)
                          .copyWith(color: AppColors.black, fontSize: 18)),
                ],
              ),
            ),
          ),
          Positioned(
            top: kToolbarHeight + 32,
            left: 0,
            right: 0,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: SimpleSearchBar(
                      initial: context.read<T>().state.query,
                      hintText: hintText,
                      onCancel: context.cubit<T>().onSearch,
                      onSearch: context.cubit<T>().onSearch,
                    ),
                  ),
                  AppSpacer.p8(),
                  Expanded(
                    flex: 1,
                    child: StatusMenuWidget(
                      defaultSel: context.read<T>().state.status,
                      items: mode == PageMode2.createVisit ?  ['Draft','Submitted','Pending', 'Approved', 'Rejected'] :
                      const ['Draft', 'Submitted'],
                      onChange: context.cubit<T>().onChangeStatus,
                    ),
                  )
                ],
              ),
            ),
          ),
          Positioned.fill(
            top: kToolbarHeight + 100,
            child: Container(
              width: context.sizeOfWidth,
              height: context.sizeOfHeight,
              padding: const EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(32.0),
                  topRight: Radius.circular(32.0),
                ),
                border: Border.all(color: AppColors.white),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.black.withOpacity(0.5),
                    blurRadius: 10,
                    offset: const Offset(0, -1),
                  )
                ],
              ),
              child: child,
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        extendedPadding: const EdgeInsets.symmetric(
          horizontal: 28,
        ),
        onPressed: onNew,
        backgroundColor: backgroundColor,
        icon: const Icon(
          Icons.add,
          color: AppColors.white,
        ),
        label: Text(
          "New",
          style: AppTextStyles.titleLarge(context)
              .copyWith(color: AppColors.white, fontSize: 22),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}

class _GoBackWidget extends StatelessWidget {
  const _GoBackWidget();

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: context.pop,
      child: const CircleAvatar(
        radius: 16,
        backgroundColor: AppColors.black,
        child: Icon(Icons.arrow_back, color: AppColors.white, size: 22),
      ),
    );
  }
}
