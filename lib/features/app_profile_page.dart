import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:svs_operations/features/auth/model/logged_in_user.dart';
import 'package:svs_operations/features/auth/presentation/bloc/auth/auth_cubit.dart';

class AppProfilePage extends StatelessWidget {
  const AppProfilePage({super.key, this.user});

  final LoggedInUser? user;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          const SizedBox(
            height: 70,
          ),
          Column(
            children: [
              Image.asset(
                'assets/images/svs_logo.png',
                height: 100,
                width: 200,
              ),
              const Text(
                'SVS OPERATIONS',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
          const SizedBox(
            height: 30,
          ),
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 10,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Column(
              children: [
                _ProfileItem(
                  const SizedBox(),
                  'Name',
                  user?.firstName ?? 'User',
                ),
                const Divider(height: 1, color: Color(0xFFE0E0E0)),
                const _ProfileItem(
                  SizedBox(),
                  'Organization',
                  'SVS Operations',
                ),
                const Divider(height: 1, color: Color(0xFFE0E0E0)),
                FutureBuilder(
                  future: _appversion(),
                  builder: (_, snapshot) {
                    final version = snapshot.data ?? '0.0.1';
                    return _ProfileItem(
                      const SizedBox(),
                      'App Version',
                      version.split(' ')[0],
                    );
                  },
                ),
                const SizedBox(height: 20),
                Container(
                  margin: const EdgeInsets.all(16),
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () => context.read<AuthCubit>().signOut(),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF168FD0),
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 15),
                    ),
                    child: const Text(
                      'Logout',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        fontFamily: "Manrope",
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 60),
          Column(
            children: [
              Image.asset('assets/images/easycloud_logo.jpeg',
                  height: 40, width: 120),
              const SizedBox(height: 8),
              const Text(
                'Powered by EasyCloud',
                style: TextStyle(fontSize: 12, color: Colors.grey),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Future<String> _appversion() async {
    final pinfo = await PackageInfo.fromPlatform();
    final version = pinfo.version;
    final buildNumber = pinfo.buildNumber;
    return '$version ($buildNumber)';
  }
}

class _ProfileItem extends StatelessWidget {
  const _ProfileItem(this.icon, this.title, this.value);

  final Widget icon;
  final String title;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: 100,
            child: Text(
              title,
              style: const TextStyle(
                fontSize: 16,
                color: Colors.black,
                fontWeight: FontWeight.normal,
                fontFamily: "Manrope",
              ),
            ),
          ),
          const Spacer(),
          Text(
            value,
            style: const TextStyle(
              fontSize: 16,
              color: Color(0xFF1744AB),
              fontWeight: FontWeight.normal,
              fontFamily: "Manrope",
            ),
          ),
        ],
      ),
    );
  }
}
