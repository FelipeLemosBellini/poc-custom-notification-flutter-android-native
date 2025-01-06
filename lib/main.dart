import 'dart:async';
import 'package:flutter/material.dart';
import 'package:poc_local_notification/controller.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // NotificationFMC notification = NotificationFMC();
  late MainController controller;

  @override
  void initState() {
    super.initState();
    controller = MainController();
    controller.initController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: () {
                controller.simulateProgress();
              },
              child: Text("Increment ProgressBar notification"),
            ),
            ElevatedButton(
              onPressed: () {
                controller.deleteNotification();
              },
              child: Text("Delete local notification"),
            ),
          ],
        ),
      ),
    );
  }
}
