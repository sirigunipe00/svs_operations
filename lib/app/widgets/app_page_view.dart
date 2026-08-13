// import 'package:svs_operations/core/ext/context_ext.dart';
// import 'package:svs_operations/styles/app_colors.dart';
// import 'package:svs_operations/styles/app_text_styles.dart';
// import 'package:svs_operations/styles/icons.dart';
// import 'package:svs_operations/widgets/spaced_column.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';

// enum PageMode {home, profile}

// class AppPageView extends StatelessWidget {
//   const AppPageView({super.key, required this.child, required this.mode});

//   final Widget child;
//   final PageMode mode;

//   @override
//   Widget build(BuildContext context) {
//     return Stack(
//       fit: StackFit.expand,
//       children: [
//         Positioned(
//           left: 52,
//           top: -24,
//           child: Image.asset(AppIcons.bgFrame1.path, alignment: Alignment.topRight, fit: BoxFit.cover,height: 210),
//         ),
//         Positioned(
//           left: 18,
//           right: 8,
//           top: kToolbarHeight,
//           child: Text(mode.name.toUpperCase(), 
//             style: AppTextStyles.titleLarge(context).copyWith(color: AppColors.black),
//           ),
//         ),
        
//         Positioned.fill(
//           top: kToolbarHeight + 112,
//           child: Container(
//             width: context.sizeOfWidth,
//             padding: const EdgeInsets.all(8.0).copyWith(top: 100),
//             decoration: BoxDecoration(
//               color: AppColors.pageViewColor,
//               borderRadius: const BorderRadius.only(
//                 topLeft: Radius.circular(32.0),
//                 topRight: Radius.circular(32.0),
//               ),
//               border: Border.all(color: AppColors.pageViewColor),
//               boxShadow: [
//                 BoxShadow(
//                   color: AppColors.black.withOpacity(0.5),
//                   blurRadius: 10,
//                   offset: const Offset(0, -1),
//                 )
//               ],
//             ),
//             child: child,
//           ),
//         ),
        
//         Positioned(
//           left: 24,
//           right: 24,
//           top: 100,
//           child: Card(
//             color: AppColors.lavender,
//             shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(8.0),
//               side: const BorderSide(color: AppColors.white)
//             ),
//             child: mode == PageMode.home ? const _HomeCardContent() : const _SettingsCardContent(),
//           ),
//         ),
//       ],
//     );
//   }
// }

// class _HomeCardContent extends StatelessWidget {
//   const _HomeCardContent();

//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//       children: [
//         Flexible(
//           flex: 2,
//           child: SpacedColumn(
//             margin: const EdgeInsets.all(8.0),
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(context.dayOfTimeGreeting(), 
//                 style: AppTextStyles.titleLarge(context).copyWith(fontSize: 20)),
//               Text('Ready to capture some entries & exits?', 
//                 style: AppTextStyles.titleMediumWhite(context).copyWith(fontSize: 14)),
//             ],
//           ),
//         ),
//         SvgPicture.asset(AppIcons.helloCuate.path, alignment: Alignment.topRight),
//       ],
//     );
//   }
// }

// class _SettingsCardContent extends StatelessWidget {
//   const _SettingsCardContent();

//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//       children: [
//         Flexible(
//           flex: 2,
//           child: SpacedColumn(
//             margin: const EdgeInsets.all(8.0),
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text('Welcome,', 
//                 style: AppTextStyles.titleLarge(context).copyWith(fontSize: 20)),
//               Text('Your security and convenience, prioritized.', 
//                 style: AppTextStyles.titleMediumWhite(context).copyWith(fontSize: 14)),
//             ],
//           ),
//         ),
//         SvgPicture.asset(AppIcons.settingsCuate.path, alignment: Alignment.topRight),
//       ],
//     );
//   }
// }
