import 'package:svs_operations/core/core.dart';
import 'package:svs_operations/core/model/page_list_filters.dart';
import 'package:svs_operations/features/auth/presentation/bloc/auth/auth_cubit.dart';
import 'package:svs_operations/features/auth/presentation/bloc/sign_in/sign_in_cubit.dart';
import 'package:svs_operations/features/gate_entry/presentation/bloc/bloc_provider.dart';
import 'package:svs_operations/features/gate_entry/presentation/bloc/gate_entry_filter.dart';
import 'package:svs_operations/features/gate_exit/presentation/bloc/bloc_provider.dart';
import 'package:svs_operations/features/gate_exit/presentation/bloc/gate_exit_filter.dart';
import 'package:svs_operations/styles/material_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AparnaApp extends StatelessWidget {
  const AparnaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => $sl.get<AuthCubit>()..authCheckRequested(),
        ),
        BlocProvider(create: (_) => $sl.get<SignInCubit>()),
        BlocProvider(create: (_) => GateEntryFilterCubit()),
        BlocProvider(create: (_) => GateExitFilterCubit()),
        BlocProvider(
            create: (_) =>
                GateEntryBlocProvider.get().createGateEntriesCubit()),
        BlocProvider(
            create: (_) => GateExitBlocProvider.get().createGateExitsCubit()),
      ],
      child: BlocConsumer<AuthCubit, AuthState>(
        listener: (_, state) {
          final routerCtxt = AppRouteConfig.parentNavigatorKey.currentContext!;
          state.maybeWhen(
            orElse: () => AppRoute.initial.go(routerCtxt),
            authenticated: () {
              routerCtxt
                ..cubit<GateEntriesCubit>()
                    .fetchInitial(PageListFilters.initial())
                ..cubit<GateExitsCubit>()
                    .fetchInitial(PageListFilters.initial());
              AppRoute.home.go(routerCtxt);
            },
            unAuthenticated: () => AppRoute.login.go(routerCtxt),
          );
        },
        builder: (_, state) {
          return MaterialApp.router(
            title: "Aparna",
            theme: AppMaterialTheme.lightTheme,
            darkTheme: AppMaterialTheme.lightTheme,
            routerConfig: AppRouteConfig.router,
            debugShowCheckedModeBanner: false,
          );
        },
      ),
    );
  }
}
