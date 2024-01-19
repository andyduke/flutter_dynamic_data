import 'dart:async';
import 'package:dynamic_data_example/screens/stream_demo/widgets/error_data_stream_view.dart';
import 'package:dynamic_data_example/screens/stream_demo/widgets/success_data_stream_view.dart';
import 'package:dynamic_data_example/screens/widgets/tab_scaffold.dart';
import 'package:flutter/material.dart';

class StreamedApiService {
  final StreamController<String> streamController = StreamController.broadcast();

  Stream<String> get stream => streamController.stream;

  void add(String data) {
    streamController.add(data);
  }

  void addError([String? error]) {
    streamController.addError(Exception(error ?? 'Stream error.'), StackTrace.current);
  }
}

// ---

class StreamDemoScreen extends StatefulWidget {
  const StreamDemoScreen({super.key});

  @override
  State<StreamDemoScreen> createState() => _StreamDemoScreenState();
}

class _StreamDemoScreenState extends State<StreamDemoScreen> {
  final service = StreamedApiService();

  @override
  Widget build(BuildContext context) {
    return TabScaffold(
      appBar: AppBar(
        title: const Text('Stream Demo'),
      ),
      tabs: [
        TabDetails(
          icon: Icons.check_circle,
          text: 'Success',
          color: Colors.teal,
          builder: (context) => StreamSuccessDataView(service: service),
        ),
        /*
        TabDetails(
          icon: Icons.crop_square_rounded,
          text: 'Empty',
          color: Colors.amber,
          builder: (context) => const Text('Empty'),
        ),
        */
        TabDetails(
          icon: Icons.error,
          text: 'Error',
          color: Colors.red,
          builder: (context) => StreamErrorDataView(service: service),
        ),
      ],
    );
  }
}
