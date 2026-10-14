import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:svs_operations/core/core.dart';
import 'package:svs_operations/features/auth/model/logged_in_user.dart';
import 'package:svs_operations/features/auth/presentation/bloc/auth/auth_cubit.dart';
import 'package:svs_operations/widgets/dialogs/app_dialogs.dart';

class AppProfilePage extends StatelessWidget {
  const AppProfilePage({super.key, this.user});

  final LoggedInUser? user;

  LoggedInUser? get _currentUser {
    if (user != null) return user;
    if ($sl.isRegistered<LoggedInUser>()) {
      return $sl<LoggedInUser>();
    }
    return null;
  }

  String _getDisplayName(LoggedInUser? u) {
    if (u == null) return 'User';
    final first = u.firstName.trim();
    final last = u.lastName.trim();
    if (first.isNotEmpty || last.isNotEmpty) {
      return '$first $last'.trim();
    }
    if (u.name.trim().isNotEmpty) return u.name.trim();
    if (u.username.trim().isNotEmpty) return u.username.trim();
    return 'User';
  }

  String _getInitials(String name) {
    final parts = name.trim().split(RegExp(r'\s+'));
    if (parts.isEmpty || parts.first.isEmpty) return 'U';
    if (parts.length == 1) return parts.first[0].toUpperCase();
    return (parts[0][0] + parts[1][0]).toUpperCase();
  }

  Future<String> _appversion() async {
    try {
      if ($sl.isRegistered<PackageInfo>()) {
        final ver = $sl<PackageInfo>().version;
        final build = $sl<PackageInfo>().buildNumber;
        if (ver.isNotEmpty) {
          return build.isNotEmpty ? '$ver ($build)' : ver;
        }
      }
      final pinfo = await PackageInfo.fromPlatform();
      final version = pinfo.version;
      final buildNumber = pinfo.buildNumber;
      return buildNumber.isNotEmpty ? '$version ($buildNumber)' : version;
    } catch (_) {
      return '1.0.0';
    }
  }

  void _onLogout(BuildContext context) {
    AppDialog.askForConfirmation(
      context,
      title: 'Logout',
      content: 'Are you sure you want to log out of your account?',
      confirmBtnText: 'Logout',
      buttonText: 'Cancel',
      onTapDismiss: context.close,
      onTapConfirm: () {
        context.close();
        context.read<AuthCubit>().signOut();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final currentUser = _currentUser;
    final displayName = _getDisplayName(currentUser);
    final initials = _getInitials(displayName);
    final emailOrUser = currentUser?.email?.isNotEmpty == true
        ? currentUser!.email!
        : (currentUser?.username.isNotEmpty == true
            ? currentUser!.username
            : 'employee@svs.com');
    final role = currentUser?.roleProfileName?.isNotEmpty == true
        ? currentUser!.roleProfileName!
        : 'SVS Operations';

    return Scaffold(
      backgroundColor: const Color(0xFF042247),
      body: SingleChildScrollView(
        physics: const ClampingScrollPhysics(),
        child: Column(
          children: [
            _buildHeader(displayName, initials, emailOrUser, role),
            _buildContent(context, displayName, emailOrUser, role),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(
    String name,
    String initials,
    String emailOrUser,
    String role,
  ) {
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFF042247),
            Color(0xFF06336D),
            Color(0xFF0E60B8),
          ],
          stops: [0.0, 0.45, 1.0],
        ),
      ),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          // Decorative background circles and rings
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
          SafeArea(
            bottom: false,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 12, 20, 24),
              child: Column(
                children: [
                  // Top bar with SVS logo and title
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: 60,
                        height: 40,
                        padding: EdgeInsets.zero,
                        decoration: BoxDecoration(
                          // color: Colors.white,
                          borderRadius: BorderRadius.circular(14),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.08),
                              blurRadius: 6,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        clipBehavior: Clip.antiAlias,
                        child: Image.asset(
                          'assets/images/svs_logo.png',
                          fit: BoxFit.cover,
                        ),
                      ),
                      const Text(
                        'Profile',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                          letterSpacing: 0.2,
                        ),
                      ),
                      const SizedBox(width: 90), // Balances logo on left
                    ],
                  ),
                  const SizedBox(height: 24),
                  // Avatar
                  Container(
                    padding: const EdgeInsets.all(3),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: Colors.white.withOpacity(0.4),
                        width: 2,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.15),
                          blurRadius: 12,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: CircleAvatar(
                      radius: 36,
                      backgroundColor: Colors.white,
                      child: Text(
                        initials,
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w800,
                          color: Color(0xFF0E6DCB),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  // Name
                  Text(
                    name,
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w800,
                      color: Colors.white,
                      letterSpacing: -0.3,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 6),
                  // Role Badge
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 14,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.18),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: Colors.white.withOpacity(0.25),
                      ),
                    ),
                    child: Text(
                      role,
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                        letterSpacing: 0.3,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContent(
    BuildContext context,
    String name,
    String emailOrUser,
    String role,
  ) {
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(32),
          topRight: Radius.circular(32),
        ),
      ),
      padding: const EdgeInsets.fromLTRB(22, 28, 22, 32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'ACCOUNT DETAILS',
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w700,
              color: Color(0xFF52647B),
              letterSpacing: 0.8,
            ),
          ),
          const SizedBox(height: 12),
          // Info Cards Container
          Container(
            decoration: BoxDecoration(
              color: const Color(0xFFF7FAFE),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: const Color(0xFFD3DEEC),
                width: 1.2,
              ),
            ),
            child: Column(
              children: [
                _buildInfoRow(
                  icon: Icons.person_outline_rounded,
                  label: 'Full Name',
                  value: name,
                ),
                const Divider(height: 1, color: Color(0xFFE2E8F0)),
                _buildInfoRow(
                  icon: Icons.mail_outline_rounded,
                  label: 'Email / Username',
                  value: emailOrUser,
                ),
                // const Divider(height: 1, color: Color(0xFFE2E8F0)),
                // _buildInfoRow(
                //   icon: Icons.badge_outlined,
                //   label: 'Role Profile',
                //   value: role,
                // ),
                const Divider(height: 1, color: Color(0xFFE2E8F0)),
                _buildInfoRow(
                  icon: Icons.domain_rounded,
                  label: 'Organization',
                  value: 'SVS Operations',
                ),
                const Divider(height: 1, color: Color(0xFFE2E8F0)),
                FutureBuilder<String>(
                  future: _appversion(),
                  builder: (_, snapshot) {
                    final version = snapshot.data ?? '1.0.0';
                    return _buildInfoRow(
                      icon: Icons.info_outline_rounded,
                      label: 'App Version',
                      value: version,
                    );
                  },
                ),
              ],
            ),
          ),
          const SizedBox(height: 28),
          // Logout Button (matching gradient design)
          Container(
            width: double.infinity,
            height: 52,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              gradient: const LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: [
                  Color(0xFF167DDE),
                  Color(0xFF055EB8),
                ],
              ),
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFF0E6DCB).withOpacity(0.3),
                  blurRadius: 16,
                  offset: const Offset(0, 6),
                ),
              ],
            ),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                borderRadius: BorderRadius.circular(16),
                onTap: () => _onLogout(context),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.logout_rounded,
                      color: Colors.white,
                      size: 20,
                    ),
                    SizedBox(width: 8),
                    Text(
                      'Logout',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                        fontFamily: "Manrope",
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 36),
          // Footer with EasyCloud branding
          Center(
            child: Column(
              children: [
                Image.asset(
                  'assets/images/easycloud_logo.jpeg',
                  height: 26,
                ),
                const SizedBox(height: 6),
                const Text(
                  'Powered by EasyCloud',
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFF78869A),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow({
    required IconData icon,
    required String label,
    required String value,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      child: Row(
        children: [
          Container(
            width: 38,
            height: 38,
            decoration: BoxDecoration(
              color: const Color(0xFF0E6DCB).withOpacity(0.08),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(
              icon,
              color: const Color(0xFF0E6DCB),
              size: 20,
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: const TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF64748B),
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  value,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF1E293B),
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
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
