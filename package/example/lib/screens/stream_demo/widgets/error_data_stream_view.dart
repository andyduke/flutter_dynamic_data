import 'package:dynamic_data/dynamic_data.dart';
import 'package:dynamic_data_example/screens/stream_demo/stream_demo_screen.dart';
import 'package:flutter/material.dart';

class StreamErrorDataView extends StatefulWidget {
  final StreamedApiService service;

  const StreamErrorDataView({
    super.key,
    required this.service,
  });

  @override
  State<StreamErrorDataView> createState() => _StreamErrorDataViewState();
}

class _StreamErrorDataViewState extends State<StreamErrorDataView> {
  late final DynamicData<String> _data = DynamicData.stream(
    streamBuilder: () async => Future.delayed(
      const Duration(milliseconds: 300),
      () => widget.service.stream,
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
      body: Column(
        children: [
          Expanded(
            child: Center(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16.0),
                child: DynamicDataBuilder(
                  data: _data,
                  // emptyBuilder: (context) => const Center(
                  //   child: Text('No data.'),
                  // ),
                  builder: (context, data) {
                    return Center(
                      child: Text(data),
                    );
                  },
                ),
              ),
            ),
          ),

          //
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            color: Colors.blueGrey.shade100,
            alignment: Alignment.center,
            child: TextButton(
              onPressed: () {
                widget.service.addError('Error ${DateTime.now()}');
              },
              child: const Text('Make error'),
            ),
          ),
        ],
      ),
    );
  }
}
