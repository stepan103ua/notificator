import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const MyApp());
}

const platform = MethodChannel('com.example.notificator');

Future<void> invokeKotlinMethod() async {
  try {
    await platform.invokeMethod('schedule', {
      'time': DateTime.now().add(const Duration(seconds: 5)).millisecondsSinceEpoch,
      'message': 'test'
    });
  } on PlatformException catch (e) {
    print('Error: ${e.message}');
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const Scaffold(
        body: Center(
          child: ElevatedButton(
            onPressed: invokeKotlinMethod,
            child: const Text('Schedule notification'),
          ),
        )
      ),
    );
  }
}
