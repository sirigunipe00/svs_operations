import 'package:flutter/material.dart';
import 'package:svs_operations/core/core.dart';
import 'package:svs_operations/features/auth/model/logged_in_user.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final user = context.user;
    final userRoles = user.roles;
    final operatorName = _getOperatorName(user);
    final sections = user.sectionRoles ?? const ['SFG', 'FG'];
    final sectionBadgeText =
        sections.isNotEmpty ? sections.join(' · ') : 'SFG · FG';

    return Scaffold(
      backgroundColor: const Color(0xFFEDF2F9),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Stack(
          children: [
            // Top Blue Header Background with decorative concentric rings
            _buildHeaderBackground(context),
            // Main Content Layer
            SafeArea(
              bottom: true,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 12),
                    // Top Bar: SVS Logo + Profile Avatar Button
                    _buildTopBar(context),
                    const SizedBox(height: 22),
                    // Welcome back, [Operator name]
                    _buildGreeting(operatorName),
                    const SizedBox(height: 24),
                    // Operations Hero Card
                    if (BooleanUtls.fromInt(userRoles?.operations)) ...[
                      _buildOperationsCard(
                        context,
                        sectionBadgeText: sectionBadgeText,
                        sectionRoles: user.sectionRoles,
                      ),
                      const SizedBox(height: 16),
                    ],
                    // Gate Entry & Gate Exit Cards Row
                    if (BooleanUtls.fromInt(userRoles?.entry) ||
                        BooleanUtls.fromInt(userRoles?.exit)) ...[
                      Row(
                        children: [
                          if (BooleanUtls.fromInt(userRoles?.entry))
                            Expanded(
                              child: _buildActionCard(
                                title: 'Gate Entry',
                                subtitle: 'Incoming vehicles',
                                icon: Icons.login_rounded,
                                iconGradient: const [
                                  Color(0xFF187EDE),
                                  Color(0xFF0C6ECB),
                                ],
                                onTap: () => AppRoute.gateEntry.push(context),
                              ),
                            ),
                          if (BooleanUtls.fromInt(userRoles?.entry) &&
                              BooleanUtls.fromInt(userRoles?.exit))
                            const SizedBox(width: 14),
                          if (BooleanUtls.fromInt(userRoles?.exit))
                            Expanded(
                              child: _buildActionCard(
                                title: 'Gate Exit',
                                subtitle: 'Outgoing vehicles',
                                icon: Icons.logout_rounded,
                                iconGradient: const [
                                  Color(0xFFF19D1F),
                                  Color(0xFFE47E0E),
                                ],
                                onTap: () => AppRoute.gateExit.push(context),
                              ),
                            ),
                        ],
                      ),
                      const SizedBox(height: 16),
                    ],
                    // Your sections Card
                    if (sections.isNotEmpty) ...[
                      _buildSectionsCard(sections),
                      const SizedBox(height: 24),
                    ],
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _getOperatorName(LoggedInUser user) {
    final first = user.firstName.trim();
    final last = user.lastName.trim();
    if (first.isNotEmpty || last.isNotEmpty) {
      return '$first $last'.trim();
    }
    if (user.name.trim().isNotEmpty) return user.name.trim();
    if (user.username.trim().isNotEmpty) return user.username.trim();
    return 'Operator';
  }

  Widget _buildHeaderBackground(BuildContext context) {
    final topPadding = MediaQuery.of(context).padding.top;
    final headerHeight = topPadding + 235.0;

    return Container(
      height: headerHeight,
      width: double.infinity,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFF04244C),
            Color(0xFF06336D),
            Color(0xFF0E60B8),
          ],
          stops: [0.0, 0.45, 1.0],
        ),
      ),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Positioned(
            top: -140,
            right: -120,
            child: _circle(380, Colors.white.withOpacity(0.04)),
          ),
          Positioned(
            top: -100,
            right: -80,
            child: _circle(280, Colors.white.withOpacity(0.05)),
          ),
          Positioned(
            top: -60,
            right: -40,
            child: _circle(180, Colors.white.withOpacity(0.06)),
          ),
          Positioned(
            top: -140,
            right: -120,
            child: _ring(380, Colors.white.withOpacity(0.07)),
          ),
          Positioned(
            top: -100,
            right: -80,
            child: _ring(280, Colors.white.withOpacity(0.08)),
          ),
        ],
      ),
    );
  }

  Widget _buildTopBar(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // SVS Logo pill
        Container(
          width: 96,
          height: 42,
          padding: const EdgeInsets.symmetric(
            horizontal: 14,
            vertical: 8,
          ),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.08),
                blurRadius: 6,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Image.asset(
            'assets/images/svs_logo.png',
            fit: BoxFit.contain,
          ),
        ),
        // Profile Avatar Button
        // Material(
        //   color: Colors.transparent,
        //   child: InkWell(
        //     borderRadius: BorderRadius.circular(22),
        //     onTap: () => AppRoute.account.push(context),
        //     child: Container(
        //       width: 44,
        //       height: 44,
        //       decoration: BoxDecoration(
        //         shape: BoxShape.circle,
        //         color: Colors.white.withOpacity(0.18),
        //         border: Border.all(
        //           color: Colors.white.withOpacity(0.35),
        //           width: 1.5,
        //         ),
        //       ),
        //       child: const Icon(
        //         Icons.person_outline_rounded,
        //         color: Colors.white,
        //         size: 24,
        //       ),
        //     ),
        //   ),
        // ),
      ],
    );
  }

  Widget _buildGreeting(String operatorName) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Welcome back,',
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w500,
            color: Colors.white.withOpacity(0.9),
          ),
        ),
        const SizedBox(height: 4),
        Text(
          operatorName,
          style: const TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.w800,
            color: Colors.white,
            letterSpacing: -0.5,
          ),
        ),
      ],
    );
  }

  Widget _buildOperationsCard(
    BuildContext context, {
    required String sectionBadgeText,
    required List<String>? sectionRoles,
  }) {
    return Container(
      width: double.infinity,
      height: 195,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF04244C).withOpacity(0.12),
            blurRadius: 18,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(24),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: () => AppRoute.operations.push(
              context,
              extra: {'sectionRoles': sectionRoles},
            ),
            child: Row(
              children: [
                // Left half (Dark Blue)
                Expanded(
                  child: Container(
                    height: double.infinity,
                    color: const Color(0xFF043977),
                    padding: const EdgeInsets.fromLTRB(16, 16, 12, 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // Badge
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.18),
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Text(
                            sectionBadgeText,
                            style: const TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.w700,
                              color: Colors.white,
                              letterSpacing: 0.5,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        // Title & Subtitle
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Operations',
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.w800,
                                color: Colors.white,
                                letterSpacing: -0.4,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              'Start and complete\nproduction steps.',
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                                color: Colors.white.withOpacity(0.85),
                                height: 1.3,
                              ),
                            ),
                          ],
                        ),
                        // Arrow button
                        Container(
                          width: 36,
                          height: 36,
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.arrow_forward_rounded,
                            color: Color(0xFF043977),
                            size: 18,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                // Right half (White background with illustration)
                Expanded(
                  child: Container(
                    height: double.infinity,
                    color: Colors.white,
                    padding: const EdgeInsets.fromLTRB(6, 10, 6, 6),
                    child: Image.asset(
                      'assets/icons/operations.png',
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildActionCard({
    required String title,
    required String subtitle,
    required IconData icon,
    required List<Color> iconGradient,
    required VoidCallback onTap,
  }) {
    return Container(
      height: 155,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(22),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF04244C).withOpacity(0.06),
            blurRadius: 14,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(22),
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(18),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: 44,
                  height: 44,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(14),
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: iconGradient,
                    ),
                  ),
                  child: Icon(
                    icon,
                    color: Colors.white,
                    size: 22,
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF131A2A),
                      ),
                    ),
                    const SizedBox(height: 3),
                    Text(
                      subtitle,
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        color: Color(0xFF64748B),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSectionsCard(List<String> sections) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF04244C).withOpacity(0.05),
            blurRadius: 12,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        children: [
          const Text(
            'Your sections',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w700,
              color: Color(0xFF334155),
            ),
          ),
          const Spacer(),
          Wrap(
            spacing: 8,
            children: sections.map((sec) {
              return Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 14,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xFFE3EEFB),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Text(
                  sec,
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF0C6ECB),
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _circle(double size, Color color) => Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: color,
        ),
      );

  Widget _ring(double size, Color color) => Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: color, width: 1.2),
        ),
      );
}
