import 'package:dynamic_data/dynamic_data.dart';
import 'package:flutter/material.dart';

class FutureSuccessSimpleDataView extends StatefulWidget {
  const FutureSuccessSimpleDataView({super.key});

  @override
  State<FutureSuccessSimpleDataView> createState() => _FutureSuccessSimpleDataViewState();
}

class _FutureSuccessSimpleDataViewState extends State<FutureSuccessSimpleDataView> {
  late final DynamicData<String> _data = DynamicData(
    futureBuilder: () async => await Future.delayed(
      const Duration(milliseconds: 500),
      () => 'Test data.',
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
      body: DynamicDataBuilder<String>(
        data: _data,
        builder: (context, data) => Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(data),
          ),
        ),
      ),
    );
  }
}
