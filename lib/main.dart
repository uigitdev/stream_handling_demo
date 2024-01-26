import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stream_handling/my_provider.dart';
import 'package:stream_handling/test_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) => MultiProvider(
        providers: [ChangeNotifierProvider<MyProvider>(create: (_) => MyProvider())],
        child: MaterialApp(
          theme: ThemeData(
            useMaterial3: false,
          ),
          home: const TestPage(),
        ),
      );
}
