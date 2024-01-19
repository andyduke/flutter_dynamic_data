import 'package:flutter/material.dart';

class DynamicDataErrorView extends StatelessWidget {
  final Object error;
  final StackTrace? stackTrace;

  const DynamicDataErrorView({
    super.key,
    required this.error,
    this.stackTrace,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('$error', style: theme.textTheme.titleMedium?.copyWith(color: theme.colorScheme.error)),
            if (stackTrace != null)
              Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: Text('$stackTrace'),
              ),
          ],
        ),
      ),
    );
  }
}
