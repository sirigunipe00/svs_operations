import 'package:flutter/material.dart';
import 'package:svs_operations/app/widgets/app_feature_widget.dart';
import 'package:svs_operations/core/core.dart';
import 'package:svs_operations/features/auth/model/logged_in_user.dart';
import 'package:svs_operations/styles/app_colors.dart';
import 'package:svs_operations/styles/app_text_styles.dart';
import 'package:svs_operations/styles/icons.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  static const Color _backgroundColor = Color(0xFFF7F9FB);
  static const Color _textColor = Color(0xFF131A2A);

  @override
  Widget build(BuildContext context) {
    final userRoles = context.user.roles;

    return Scaffold(
      backgroundColor: _backgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            _buildTopHeader(),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    // First row: Gate Entry and Gate Exit
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (BooleanUtls.fromInt(userRoles?.entry))
                          Expanded(
                            child: AppFeatureWidget(
                              icon: AppIcons.vechileEntry.toWidget(
                                height: 140,
                                width: 120,
                                fit: BoxFit.contain,
                              ),
                              title: Text(
                                'Gate Entry',
                                
                                style: AppTextStyles.textEntryStyle(context),
                              ),
                              featureColor: AppColors.white,
                              onTap: () => AppRoute.gateEntry.push(context),
                            ),
                          ),
                        const SizedBox(width: 8),
                        if (BooleanUtls.fromInt(userRoles?.exit))
                          Expanded(
                            child: AppFeatureWidget(
                              icon: AppIcons.vehcileExit.toWidget(
                                height: 140,
                                width: 140,
                                fit: BoxFit.contain,
                              ),
                              title: Text(
                                'Gate Exit',
                               
                                style: AppTextStyles.textEntryStyle(context),
                              ),
                              featureColor: AppColors.white,
                              onTap: () => AppRoute.gateExit.push(context),
                            ),
                          ),
                      ],
                    ),

                    const SizedBox(height: 8),
                    if (BooleanUtls.fromInt(userRoles?.operations))
                      Row(
                        children: [
                          Expanded(
                            child: AppFeatureWidget(
                              icon: AppIcons.operations.toWidget(
                                height: 140,
                                width: 120,
                                fit: BoxFit.contain,
                              ),
                              title: Text(
                                'Operations',
                                style: AppTextStyles.textEntryStyle(context),
                              ),
                              featureColor: AppColors.white,
                              onTap: () => AppRoute.operations.push(
                                context,
                                extra: {
                                  'sectionRoles': context.user.sectionRoles
                                },
                              ),
                            ),
                          ),
                          const SizedBox(width: 16),
                          const Expanded(
                            child: SizedBox(),
                          ),
                        ],
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

  String dayOfTimeGreeting() {
    final currHour = DFU.now().hour;

    return switch (currHour) {
      < 12 => 'Good Morning,',
      <= 16 => 'Good Afternoon,',
      < 20 => 'Good Evening,',
      _ => 'Good Night,',
    };
  }

  Widget _buildTopHeader() {
    final user = $sl.get<LoggedInUser>();

    return Container(
      width: double.infinity,
      height: 90,
      padding: const EdgeInsets.fromLTRB(20, 12, 20, 10),
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(
          bottom: BorderSide(
            color: Color(0xFFEFF2F5),
            width: 1,
          ),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  dayOfTimeGreeting(),
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: _textColor,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  '${user.username} 👋',
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    color: _textColor,
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withAlpha(4),
                  blurRadius: 10,
                ),
              ],
            ),
            child: const Icon(
              Icons.notifications_none_rounded,
              size: 26,
              color: Color(0xFF91A2BB),
            ),
          ),
        ],
      ),
    );
  }
}
