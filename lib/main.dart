import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter/services.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  static const EventChannel _eventChannel =
      EventChannel('com.example.accelerometer/data');
  StreamSubscription? _accelerometerSubscription;
  String accelerometerData = "Waiting for data...";

  @override
  void initState() {
    super.initState();
    _startListening();
  }

  void _startListening() {
    _accelerometerSubscription =
        _eventChannel.receiveBroadcastStream().listen((dynamic event) {
      setState(() {
        accelerometerData =
            "X: ${event['x']}, Y: ${event['y']}, Z: ${event['z']}";
      });
    });
  }

  @override
  void dispose() {
    _accelerometerSubscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("Accelerometer Data"),
        ),
        body: Center(
          child: Text(
            accelerometerData,
            style: TextStyle(fontSize: 24),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
