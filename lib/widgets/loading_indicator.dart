import 'package:svs_operations/core/core.dart';
import 'package:flutter/material.dart';

class LoadingIndicator extends StatelessWidget {
  const LoadingIndicator({super.key});

  @override
  Widget build(BuildContext context) => Center(
    child: CircularProgressIndicator(
      color: context.colorScheme.primary,
      strokeWidth: 3,
    ),
  );
}
