import 'dart:ui';
import 'package:dynamic_data/dynamic_data.dart';
import 'package:dynamic_data_example/screens/home/home_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return DynamicDataDefaults(
      emptyBuilder: (context) => const Center(
        child: Text('No data.'),
      ),
      child: MaterialApp(
        scrollBehavior: ScrollConfiguration.of(context).copyWith(dragDevices: {
          PointerDeviceKind.touch,
          PointerDeviceKind.mouse,
        }),
        title: 'Dynamic Data Example',
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF87CEEB)),
          visualDensity: VisualDensity.standard,
        ),
        debugShowCheckedModeBanner: false,
        home: const HomeScreen(),
      ),
    );
  }
}
