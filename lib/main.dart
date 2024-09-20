import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:write_native_code_exampel/native_class/native_communications.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
            seedColor: const Color.fromARGB(255, 10, 70, 118),
            inversePrimary: const Color.fromARGB(255, 10, 70, 118)),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  double num1 = 0.0;
  double num2 = 0.0;
  double theSum = 0.0;

  String fullName = "";

  void calculateSum() async {
    NativeCommunication nativeCommunication = NativeCommunication();
    double sum = await nativeCommunication.getSumFromNative(num1, num2);

    String getFullName =
        await nativeCommunication.getStringFromNative("Abdallah", "Yassein");

    fullName = getFullName;

    log('Sum from native: $sum');
    setState(() {
      theSum = sum;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(
          widget.title,
          style: const TextStyle(color: Colors.white),
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TextField(
                decoration: const InputDecoration(labelText: 'Number 1'),
                onChanged: (value) {
                  num1 = double.tryParse(value) ?? 0.0;
                },
              ),
              const SizedBox(
                height: 10,
              ),
              TextField(
                decoration: const InputDecoration(labelText: 'Number 1'),
                onChanged: (value) {
                  num2 = double.tryParse(value) ?? 0.0;
                },
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                'sum: $theSum' + "\n" + fullName,
                style: Theme.of(context).textTheme.headlineMedium,
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: calculateSum,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
