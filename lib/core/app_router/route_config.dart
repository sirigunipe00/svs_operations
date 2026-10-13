import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:svs_operations/app/presentation/app_splash_scrn.dart';
import 'package:svs_operations/app/presentation/app_update_blocprovider.dart';
import 'package:svs_operations/app/widgets/app_scaffold_widget.dart';
import 'package:svs_operations/app/widgets/image_preview_scrn.dart';
import 'package:svs_operations/core/app_router/app_route.dart';
import 'package:svs_operations/core/core.dart';
import 'package:svs_operations/features/app_profile_page.dart';
import 'package:svs_operations/features/auth/presentation/authentication_scrn.dart';
import 'package:svs_operations/features/dashboard_screen.dart';
import 'package:svs_operations/features/gate_entry/presentation/bloc/bloc_provider.dart';
import 'package:svs_operations/features/gate_entry/presentation/bloc/new_gate_entry/new_gate_entry_cubit.dart';
import 'package:svs_operations/features/gate_entry/presentation/ui/create/new_gate_entry.dart';
import 'package:svs_operations/features/gate_entry/presentation/ui/gate_entry_list/gate_entry_list.dart';
import 'package:svs_operations/features/gate_exit/presentation/bloc/bloc_provider.dart';
import 'package:svs_operations/features/gate_exit/presentation/bloc/create_gate_exit/create_gate_exit_cubit.dart';
import 'package:svs_operations/features/gate_exit/presentation/ui/create/new_gate_exit.dart';
import 'package:svs_operations/features/gate_exit/presentation/ui/gate_exit_list/gate_exit_list.dart';
import 'package:svs_operations/features/operations_screen.dart.dart';
import 'package:svs_operations/features/tube_cutting/model/work_order_model.dart';
import 'package:svs_operations/features/tube_cutting/presentation/bloc/bloc_provider.dart';
import 'package:svs_operations/features/tube_cutting/presentation/bloc/create_item_cubit.dart';
import 'package:svs_operations/features/tube_cutting/presentation/ui/screens/scan_machine_screen.dart';
import 'package:svs_operations/features/tube_cutting/presentation/ui/screens/work_order_list.dart';
import 'package:svs_operations/features/tube_cutting/presentation/work_station_screen.dart';
import 'package:svs_operations/home_screen.dart';

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
                        path: _getPath(AppRoute.gateEntry),
                        builder: (ctxt, state) => const GateEntryListScrn(),
                        routes: [
                          GoRoute(
                            path: _getPath(AppRoute.newGateEntry),
                            builder: (ctxt, state) {
                              final provider = GateEntryBlocProvider.get();

                              final extra =
                                  state.extra as Map<String, dynamic>?;

                              final gateEntryName =
                                  extra?['gate_entry_name'] as String?;
                              final poNumber = extra?['po_number'] as String?;

                              return MultiBlocProvider(
                                providers: [
                                  if (gateEntryName.isNull) ...[
                                    BlocProvider(
                                        create: (_) => provider.getDetails()),
                                  ] else ...[
                                    BlocProvider(
                                        create: (_) => provider.getDetails()
                                          ..request(gateEntryName!)),
                                  ],
                                  if (poNumber.isNull) ...[
                                    BlocProvider(
                                        create: (_) => provider.getItemPO()),
                                  ] else ...[
                                    BlocProvider(
                                        create: (_) => provider.getItemPO()
                                          ..request(poNumber!)),
                                  ],
                                  BlocProvider(
                                      create: (_) =>
                                          provider.fetchPONumbers()..request()),
                                  BlocProvider(
                                      create: (_) =>
                                          $sl.get<NewGateEntryCubit>()),
                                ],
                                child: const NewGateEntry(),
                              );
                            },
                            routes: [
                              GoRoute(
                                path: _getPath(AppRoute.newGateEntryPreview),
                                builder: (_, state) {
                                  final data =
                                      state.extra as Pair<String, String?>;
                                  return ImagePreviewScrn.fromPair(data);
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                      GoRoute(
                        path: _getPath(AppRoute.gateExit),
                        builder: (ctxt, state) => const GateExitListScrn(),
                        routes: [
                          GoRoute(
                            path: _getPath(AppRoute.newGateExit),
                            builder: (_, state) {
                              final provider = GateExitBlocProvider.get();
                              final name = state.extra as String?;
                              return MultiBlocProvider(
                                providers: [
                                  if (name.isNull) ...[
                                    BlocProvider(
                                        create: (_) => provider.getDetails()),
                                  ] else ...[
                                    BlocProvider(
                                        create: (_) => provider.getDetails()
                                          ..request(name!)),
                                  ],
                                  BlocProvider(
                                      create: (_) =>
                                          provider.getVehicleNumber()),
                                  BlocProvider(
                                      create: (_) =>
                                          $sl.get<CreateGateExitCubit>()),
                                ],
                                child: const NewGateExit(),
                              );
                            },
                            routes: [
                              GoRoute(
                                path: _getPath(AppRoute.newGateExitPreview),
                                builder: (_, state) {
                                  final data =
                                      state.extra as Pair<String, String?>;
                                  return ImagePreviewScrn.fromPair(data);
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                      GoRoute(
                          path: _getPath(AppRoute.operations),
                          builder: (_, state) {
                            final extra = state.extra as Map<String, dynamic>?;

                            final sectionRoles =
                                (extra?['sectionRoles'] as List<dynamic>?)
                                        ?.cast<String>() ??
                                    [];

                            return BlocProvider(
                              create: (_) =>
                                  AppUpdateBlocprovider.get().appversionCubit()
                                    ..request(),
                              child: BlocProvider(
                                create: (context) =>
                                    TubeCuttingBlocProvider.get()
                                        .operaionsList()
                                      ..request(),
                                child: OperationsScreen(
                                  sectionRoles: sectionRoles,
                                ),
                              ),
                            );
                          },
                          routes: [
                            GoRoute(
                                path: _getPath(AppRoute.tcList),
                                builder: (_, state) {
                                  final operation = state.extra as String;
                                  return BlocProvider(
                                    create: (context) =>
                                        TubeCuttingBlocProvider.get()
                                            .workOrderList()
                                          ..request(Tuple3(operation, '', 'Open')),
                                    child: WorkOrderListScreen(
                                      operation: operation,
                                    ),
                                  );
                                },
                                routes: [
                                  GoRoute(
                                      path: _getPath(AppRoute.scanMachine),
                                      builder: (_, state) {
                                        final data = state.extra!
                                            as Map<String, dynamic>;
                                        final name = data['name'];
                                        final workorder =
                                            data['order'] as WorkOrderItem;
                                        return MultiBlocProvider(
                                          providers: [
                                            BlocProvider(
                                              create: (context) =>
                                                  TubeCuttingBlocProvider.get()
                                                      .getOperationsStatus()
                                                    ..request(name),
                                            ),
                                            BlocProvider(
                                              create: (context) =>
                                                  TubeCuttingBlocProvider.get()
                                                      .childStatusCubit()
                                                    ..request(workorder.name),
                                            ),
                                            BlocProvider(
                                                create: (_) =>
                                                    $sl.get<CreateItemCubit>()),
                                          ],
                                          child: TubeCuttingScreen(
                                            title: name,
                                            workOrder: workorder,
                                          ),
                                        );
                                      },
                                      // routes: [
                                      //   GoRoute(
                                      //     path: _getPath(AppRoute.scanMachine),
                                      //     builder: (_, state) {
                                      //       final data = state.extra!
                                      //           as Map<String, dynamic>;
                                      //       final name = data['name'];
                                      //       final workorder =
                                      //           data['order'] as WorkOrderItem;
                                      //       return MultiBlocProvider(
                                      //         providers: [
                                      //           BlocProvider(
                                      //             create: (context) =>
                                      //                 TubeCuttingBlocProvider
                                      //                         .get()
                                      //                     .getOperationsStatus()
                                      //                   ..request(name),
                                      //           ),
                                      //           BlocProvider(
                                      //             create: (context) =>
                                      //                 TubeCuttingBlocProvider
                                      //                         .get()
                                      //                     .childStatusCubit()
                                      //                   ..request(
                                      //                       workorder.name),
                                      //           ),
                                      //           BlocProvider(
                                      //               create: (_) => $sl.get<
                                      //                   CreateItemCubit>()),
                                      //         ],
                                      //         child: TubeCuttingWorkStationScreen(
                                      //           title: name,
                                      //           workOrder: workorder,
                                      //         ),
                                      //       );
                                      //     },
                                      //   )
                                      // ]
                                      ),
                                ]),
                          ]),
                    ]),
              ],
            ),
            // StatefulShellBranch(
            //   routes: [
            //     GoRoute(
            //       path: AppRoute.dashboard.path,
            //       builder: (_, __) => const DashboardScreen(),
            //     ),
            //   ],
            // ),
            StatefulShellBranch(
              routes: [
                GoRoute(
                  path: AppRoute.account.path,
                  builder: (_, __) => const AppProfilePage(),
                ),
              ],
            ),
          ],
        ),
      ]);

  static String _getPath(AppRoute route) => route.path.split('/').last;
}
