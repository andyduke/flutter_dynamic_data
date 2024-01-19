import 'package:dynamic_data/dynamic_data.dart';
import 'package:flutter/material.dart';

class FutureErrorDataView extends StatefulWidget {
  const FutureErrorDataView({super.key});

  @override
  State<FutureErrorDataView> createState() => _FutureErrorDataViewState();
}

class _FutureErrorDataViewState extends State<FutureErrorDataView> {
  late final DynamicData<Map<String, dynamic>> _data = DynamicData(
    futureBuilder: () async => await Future.delayed(
      const Duration(milliseconds: 500),
      () => throw Exception('Data error.'),
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
      body: DynamicDataBuilder<Map<String, dynamic>>(
        data: _data,
        builder: (context, data) {
          return const Padding(
            padding: EdgeInsets.all(16.0),
            child: Text('Data'),
          );
        },
      ),
    );
  }
}
