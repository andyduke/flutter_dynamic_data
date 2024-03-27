import 'package:dynamic_data/dynamic_data.dart';
import 'package:flutter/material.dart';

class FutureListenableBuilderDemoView extends StatefulWidget {
  const FutureListenableBuilderDemoView({super.key});

  @override
  State<FutureListenableBuilderDemoView> createState() => _FutureListenableBuilderDemoViewState();
}

class _FutureListenableBuilderDemoViewState extends State<FutureListenableBuilderDemoView> {
  late final DynamicData<String> _data = DynamicData(
    futureBuilder: () async => await Future.delayed(
      const Duration(milliseconds: 500),
      () => 'Test data: ${DateTime.now()}',
    ),
  );

  @override
  void dispose() {
    _data.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ListenableBuilder(
            listenable: _data,
            builder: (context, child) {
              return switch (_data) {
                (DynamicData<String> d) when d.isEmpty => DynamicDataDefaults.of(context).emptyBuilder(context),
                (DynamicData<String> d) when d.isLoading => DynamicDataDefaults.of(context).loadingBuilder(context),
                (DynamicData<String> d) when d.hasError =>
                  DynamicDataDefaults.of(context).errorBuilder(context, d.error!, d.reload),
                (DynamicData<String> d) => Text('${d.data}'),
              };
            },
          ),
        ),
      ),
    );
  }
}
