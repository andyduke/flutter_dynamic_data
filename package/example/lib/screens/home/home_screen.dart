import 'package:dynamic_data_example/screens/future_demo/future_demo_screen.dart';
import 'package:dynamic_data_example/screens/stream_demo/stream_demo_screen.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ElevatedButton(
                onPressed: () => Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => const FutureDemoScreen(),
                  ),
                ),
                child: const Text('Future'),
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: () => Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => const StreamDemoScreen(),
                  ),
                ),
                child: const Text('Stream'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
