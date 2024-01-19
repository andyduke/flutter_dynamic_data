import 'package:dynamic_data/dynamic_data.dart';
import 'package:dynamic_data_example/screens/stream_demo/stream_demo_screen.dart';
import 'package:flutter/material.dart';

class StreamSuccessDataView extends StatefulWidget {
  final StreamedApiService service;

  const StreamSuccessDataView({super.key, required this.service});

  @override
  State<StreamSuccessDataView> createState() => _StreamSuccessDataViewState();
}

class _StreamSuccessDataViewState extends State<StreamSuccessDataView> {
  final _textController = TextEditingController();

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
            padding: const EdgeInsets.symmetric(horizontal: 16),
            color: Colors.blueGrey.shade100,
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    autofocus: true,
                    controller: _textController,
                    decoration: const InputDecoration(
                      hintText: 'Type something...',
                      border: InputBorder.none,
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () {
                    widget.service.add(_textController.text);
                    _textController.clear();
                  },
                  icon: const Icon(Icons.send),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
