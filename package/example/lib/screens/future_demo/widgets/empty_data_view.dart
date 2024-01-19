import 'package:dynamic_data/dynamic_data.dart';
import 'package:flutter/material.dart';

class FutureEmptyDataView extends StatefulWidget {
  const FutureEmptyDataView({super.key});

  @override
  State<FutureEmptyDataView> createState() => _FutureEmptyDataViewState();
}

class _FutureEmptyDataViewState extends State<FutureEmptyDataView> {
  late final DynamicData<Map<String, dynamic>> _data = DynamicData(
    futureBuilder: () async => await Future.delayed(
      const Duration(milliseconds: 500),
      () => null,
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
        emptyBuilder: (context) => const Center(
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: Text('No data (inplace).'),
          ),
        ),
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
