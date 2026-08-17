import 'package:flutter/material.dart';
import 'package:svs_operations/core/app_router/app_route.dart';
import 'package:svs_operations/core/di/injector.dart';
import 'package:svs_operations/core/utils/date_format_util.dart';
import 'package:svs_operations/features/auth/model/logged_in_user.dart';
import 'package:svs_operations/styles/icons.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedIndex = 0;

  final List<OperationItem> operations = [
    OperationItem(
      appRoute: AppRoute.scanMachine,
      title: 'Tube Cutting',
      image: AppIcons.tubeCutting.path,
      iconColor: const Color(0xFFFF6B4A),
      iconBackground: const Color(0xFFFFECE7),
    ),
    OperationItem(
      appRoute: AppRoute.scanMachine,
      title: 'Mesh Insertion',
      image: AppIcons.meshInsertion.path,
      iconColor: const Color(0xFF4D8DFF),
      iconBackground: const Color(0xFFEAF2FF),
    ),
    OperationItem(
      appRoute: AppRoute.scanMachine,
      title: 'Molecular\nSieve Filling',
      image: AppIcons.molecularIcon.path,
      iconColor: const Color(0xFF008FD3),
      iconBackground: const Color(0xFFE4F4F1),
    ),
    OperationItem(
      appRoute: AppRoute.scanMachine,
      title: 'Spinning',
      image: AppIcons.spinningIcon.path,
      iconColor: const Color(0xFFD800D8),
      iconBackground: const Color(0xFFFCE8FB),
    ),
    OperationItem(
      appRoute: AppRoute.scanMachine,
      title: 'Visual\nInspection',
      image: AppIcons.visualInspection.path,
      iconColor: const Color(0xFF2675A7),
      iconBackground: const Color(0xFFE7F1F7),
    ),
    OperationItem(
      appRoute: AppRoute.scanMachine,
      title: 'Brazing',
      image: AppIcons.brazingIcon.path,
      iconColor: const Color(0xFF336C85),
      iconBackground: const Color(0xFFFFF5E8),
    ),
    OperationItem(
      appRoute: AppRoute.scanMachine,
      title: 'Final Quality\nInspection',
      image: AppIcons.qtyInspection.path,
      iconColor: const Color(0xFFFFA648),
      iconBackground: const Color(0xFFFFF1E7),
    ),
    OperationItem(
      appRoute: AppRoute.scanMachine,
      title: 'Vacuum Packing',
      image: AppIcons.vaccumePacking.path,
      iconColor: const Color(0xFF73738D),
      iconBackground: const Color(0xFFF5E7F7),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F9FB),
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            Expanded(
              child: CustomScrollView(
                physics: const BouncingScrollPhysics(),
                slivers: [
                  SliverToBoxAdapter(
                    child: _buildHeader(),
                  ),
                  SliverToBoxAdapter(
                    child: _buildSectionHeader(),
                  ),
                  SliverPadding(
                    padding: const EdgeInsets.fromLTRB(
                      15,
                      25,
                      15,
                      20,
                    ),
                    sliver: SliverGrid(
                      delegate: SliverChildBuilderDelegate(
                        (context, index) {
                          return _OperationCard(
                            item: operations[index],
                            onTap: () {
                              debugPrint(
                                'Selected: ${operations[index].title}',
                              );
                              operations[index].appRoute.push(context, extra: {
                                'name': operations[index].title,
                                'date': _getCurrentDate()
                              });
                            },
                          );
                        },
                        childCount: operations.length,
                      ),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10,
                        childAspectRatio: 0.82,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    final user = $sl.get<LoggedInUser>();
    return Container(
      height: 85,
      padding: const EdgeInsets.fromLTRB(20, 15, 20, 10),
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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  dayOfTimeGreeting(),
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF131A2A),
                  ),
                ),
                Text(
                  '${user.username} 👋',
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF131A2A),
                  ),
                ),
              ],
            ),
          ),
          Stack(
            clipBehavior: Clip.none,
            children: [
              const Icon(
                Icons.notifications,
                size: 23,
                color: Color(0xFF91A2BB),
              ),
              Positioned(
                right: 2,
                top: -1,
                child: Container(
                  width: 7,
                  height: 7,
                  decoration: const BoxDecoration(
                    color: Color(0xFFE94B55),
                    shape: BoxShape.circle,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSectionHeader() {
    return Container(
      height: 49,
      color: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text(
            'Operations',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w700,
              color: Color(0xFF198DD0),
            ),
          ),
          const Spacer(),
          Text(
            '(${_getCurrentDate()})',
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: Color(0xFF61718C),
            ),
          ),
        ],
      ),
    );
  }

  String _getCurrentDate() {
    final now = DateTime.now();

    return '${now.day.toString().padLeft(2, '0')}/'
        '${_getMonthName(now.month)}/'
        '${now.year.toString().substring(2)}';
  }

  String _getMonthName(int month) {
    const months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec',
    ];

    return months[month - 1];
  }

  // ----------------------------------------------------------
  // BOTTOM NAVIGATION
  // ----------------------------------------------------------

  Widget _buildBottomNavigation() {
    return Container(
      height: 80,
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(
          top: BorderSide(
            color: Color(0xFFE1E6EC),
            width: 1,
          ),
        ),
        boxShadow: [
          BoxShadow(
            color: Color(0x12000000),
            blurRadius: 8,
            offset: Offset(0, -2),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: _BottomNavItem(
              icon: Icons.home_rounded,
              label: 'Home',
              selected: selectedIndex == 0,
              onTap: () {
                setState(() {
                  selectedIndex = 0;
                });
              },
            ),
          ),
          Expanded(
            child: _BottomNavItem(
              icon: Icons.dashboard_rounded,
              label: 'Dashboard',
              selected: selectedIndex == 1,
              onTap: () {
                setState(() {
                  selectedIndex = 1;
                });
              },
            ),
          ),
          Expanded(
            child: _BottomNavItem(
              icon: Icons.account_circle,
              label: 'Profile',
              selected: selectedIndex == 2,
              isProfile: true,
              onTap: () {
                setState(() {
                  selectedIndex = 2;
                });
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _OperationCard extends StatelessWidget {
  final OperationItem item;
  final VoidCallback onTap;

  const _OperationCard({
    required this.item,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: const Color(0xFFDCE4EC),
              width: 1,
            ),
            boxShadow: const [
              BoxShadow(
                color: Color(0x08000000),
                blurRadius: 8,
                offset: Offset(0, 3),
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 4,
              vertical: 8,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  width: 70,
                  height: 60,
                  decoration: BoxDecoration(
                    color: item.iconBackground,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Image.asset(item.image),
                ),
                const SizedBox(height: 5),
                Expanded(
                  child: Center(
                    child: Text(
                      item.title,
                      textAlign: TextAlign.center,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 14,
                        height: 1.25,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF101829),
                      ),
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
}

// ==========================================================
// BOTTOM NAV ITEM
// ==========================================================

class _BottomNavItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool selected;
  final bool isProfile;
  final VoidCallback onTap;

  const _BottomNavItem({
    required this.icon,
    required this.label,
    required this.selected,
    required this.onTap,
    this.isProfile = false,
  });

  @override
  Widget build(BuildContext context) {
    const selectedColor = Color(0xFF198FD2);
    const unselectedColor = Color(0xFF8492A9);

    return InkWell(
      onTap: onTap,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (isProfile)
            Container(
              width: 29,
              height: 29,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: selected ? selectedColor : const Color(0xFFB7C2D1),
                  width: 1.5,
                ),
              ),
              child: ClipOval(
                child: Icon(
                  Icons.person,
                  size: 23,
                  color: selected ? selectedColor : unselectedColor,
                ),
              ),
            )
          else
            Icon(
              icon,
              size: 27,
              color: selected ? selectedColor : unselectedColor,
            ),
          const SizedBox(height: 3),
          Text(
            label,
            style: TextStyle(
              fontSize: 14,
              fontWeight: selected ? FontWeight.w500 : FontWeight.w400,
              color: selected ? selectedColor : const Color(0xFF697995),
            ),
          ),
        ],
      ),
    );
  }
}

// ==========================================================
// MODEL
// ==========================================================

class OperationItem {
  final String title;
  final String image;
  final Color iconColor;
  final Color iconBackground;
  final AppRoute appRoute;

  OperationItem(
      {required this.title,
      required this.image,
      required this.iconColor,
      required this.iconBackground,
      required this.appRoute});
}

String dayOfTimeGreeting() {
  final currHour = DFU.now().hour;
  return switch (currHour) {
    < 12 => 'Good Morning,',
    > 12 && <= 16 => 'Good Afternoon,',
    > 16 && < 20 => 'Good Evening,',
    >= 20 => 'Good Night,',
    _ => '',
  };
}
