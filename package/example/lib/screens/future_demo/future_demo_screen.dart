import 'package:dynamic_data_example/screens/future_demo/widgets/empty_data_view.dart';
import 'package:dynamic_data_example/screens/future_demo/widgets/error_data_view.dart';
import 'package:dynamic_data_example/screens/future_demo/widgets/listenable_builder_demo_view.dart';
import 'package:dynamic_data_example/screens/future_demo/widgets/success_simple_data_view.dart';
import 'package:dynamic_data_example/screens/future_demo/widgets/success_data_view.dart';
import 'package:dynamic_data_example/screens/future_demo/widgets/success_model_data_view.dart';
import 'package:dynamic_data_example/screens/widgets/tab_scaffold.dart';
import 'package:flutter/material.dart';

class FutureDemoScreen extends StatelessWidget {
  const FutureDemoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return TabScaffold(
      appBar: AppBar(
        title: const Text('Future Demo'),
      ),
      tabs: [
        TabDetails(
          icon: Icons.check_circle,
          text: 'Simple data',
          color: Colors.teal,
          builder: (context) => const FutureSuccessSimpleDataView(),
        ),
        TabDetails(
          icon: Icons.check_circle,
          text: 'Map',
          color: Colors.teal,
          builder: (context) => const FutureSuccessDataView(),
        ),
        TabDetails(
          icon: Icons.check_circle,
          text: 'Model',
          color: Colors.teal,
          builder: (context) => const FutureSuccessModelDataView(),
        ),
        TabDetails(
          icon: Icons.check_circle,
          text: 'Listenable Builder Demo',
          color: Colors.teal,
          builder: (context) => const FutureListenableBuilderDemoView(),
        ),
        TabDetails(
          icon: Icons.crop_square_rounded,
          text: 'Empty',
          color: Colors.amber,
          builder: (context) => const FutureEmptyDataView(),
        ),
        TabDetails(
          icon: Icons.error,
          text: 'Error',
          color: Colors.red,
          builder: (context) => const FutureErrorDataView(),
        ),
      ],
    );
  }
}
