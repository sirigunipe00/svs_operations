import 'package:svs_operations/core/di/injector.dart';
import 'package:svs_operations/core/utils/date_format_util.dart';
import 'package:svs_operations/features/auth/model/logged_in_user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:svs_operations/widgets/dialogs/app_snack_bar_widget.dart';

extension BuildContextExt on BuildContext {
  TextTheme get textTheme => Theme.of(this).textTheme;

  ColorScheme get colorScheme => Theme.of(this).colorScheme;

  double get sizeOfWidth => MediaQuery.sizeOf(this).width;
  double get sizeOfHeight => MediaQuery.sizeOf(this).height;

  Future<T?> goToPage<T>(Widget child) => Navigator.of(this).push<T?>(
        MaterialPageRoute(builder: (ctx) => child),
      );

  void close<T>([T? data]) => Navigator.of(this).pop(data);
  void exit<T>([T? data]) => Navigator.of(this, rootNavigator: true).pop(data);

  T cubit<T extends Cubit<Object>>() => BlocProvider.of<T>(this);

  LoggedInUser get user => $sl.get<LoggedInUser>();

  void showSnackbar(String content, AppSnackBarType type) {
    ScaffoldMessenger.of(this).showSnackBar(
      SnackBar(
          behavior: SnackBarBehavior.floating,
          backgroundColor: Colors.transparent,
          elevation: 0,
          content: AppSnackBarWidget(content: content, type: type)),
    );
  }

  void showSnackbartype(String content, AppSnackBarType type) {
    ScaffoldMessenger.of(this)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          behavior: SnackBarBehavior.floating,
          backgroundColor: Colors.transparent,
          elevation: 0,
          content: AppSnackBarWidget(content: content, type: type),
        ),
      );
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
}
