import 'package:flutter/services.dart';

class NativeCommunication {
  static const platform = MethodChannel('com.example.native/channel');

  Future<double> getSumFromNative(double num1, double num2) async {
    try {
      final Map<String, dynamic> params = {
        'num1': num1,
        'num2': num2,
      };

      final double result = await platform.invokeMethod('calculateSum', params);
      return result;
    } on PlatformException catch (e) {
      throw 'Failed to get sum: ${e.message}';
    }
  }

  Future<String> getStringFromNative(firstName, lastName) async {
    try {
      final Map<String, dynamic> params = {
        "first_name": firstName,
        "last_name": lastName
      };

      final String result =
          await platform.invokeMethod('getMyFullName', params);
      return result;
    } on PlatformException catch (e) {
      throw 'Failed to get string: ${e.message}';
    }
  }
}
