import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:svs_operations/app/presentation/app_splash_scrn.dart';
import 'package:svs_operations/app/presentation/app_update_blocprovider.dart';
import 'package:svs_operations/app/widgets/app_scaffold_widget.dart';
import 'package:svs_operations/core/app_router/app_route.dart';
import 'package:svs_operations/features/auth/presentation/authentication_scrn.dart';
import 'package:svs_operations/features/home_screen.dart';
import 'package:svs_operations/features/tube_cutting/presentation/scan_machine_screen.dart';

class AppRouteConfig {
  static final parentNavigatorKey = GlobalKey<NavigatorState>();

  static final GoRouter router = GoRouter(
      navigatorKey: parentNavigatorKey,
      initialLocation: AppRoute.initial.path,
      routes: <RouteBase>[
        GoRoute(
          path: AppRoute.initial.path,
          builder: (_, state) => const AppSplashScreen(),
        ),
        GoRoute(
          path: AppRoute.login.path,
          builder: (_, state) => const LoginScreen(),
        ),
        StatefulShellRoute.indexedStack(
          builder: (context, state, navigationShell) {
            return AppScaffoldWidget(navigationShell: navigationShell);
          },
          branches: [
            StatefulShellBranch(
              routes: [
                GoRoute(
                    path: AppRoute.home.path,
                    builder: (_, state) => BlocProvider(
                          create: (_) =>
                              AppUpdateBlocprovider.get().appversionCubit()
                                ..request(),
                          child: const HomeScreen(),
                        ),
                    routes: [
                      GoRoute(
                        path: _getPath(AppRoute.scanMachine),
                        builder: (_, state) {
                          final data = state.extra! as Map<String, dynamic>;
                          final name = data['name'];
                          final datee = data['date'];
                          return TubeCuttingScreen(
                            date: datee,
                            title: name,
                          );
                        },
                      ),
                    ]),
              ],
            ),
            StatefulShellBranch(
              routes: [
                GoRoute(
                  path: AppRoute.account.path,
                  builder: (_, __) => const HomeScreen(),
                ),
              ],
            ),
          ],
        ),
      ]);



  static String _getPath(AppRoute route) => route.path.split('/').last;
}
