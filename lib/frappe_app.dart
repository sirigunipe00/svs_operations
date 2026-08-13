import 'package:svs_operations/core/core.dart';
import 'package:svs_operations/features/auth/presentation/bloc/auth/auth_cubit.dart';
import 'package:svs_operations/features/auth/presentation/bloc/sign_in/sign_in_cubit.dart';
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
      ],
      child: BlocConsumer<AuthCubit, AuthState>(
        listener: (_, state) {
          final routerCtxt = AppRouteConfig.parentNavigatorKey.currentContext;
          state.maybeWhen(
            orElse: () => AppRoute.initial.go(routerCtxt!),
            authenticated: () {
              AppRoute.home.go(routerCtxt!);
            },
            unAuthenticated: () => AppRoute.login.go(routerCtxt!),
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
