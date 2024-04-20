import 'dart:io';

class ConnectionUtil {
  //The test to actually see if there is a connection
  static Future<bool> checkConnection() async {
    bool _isConnected = false;
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        _isConnected = true;
      } else {
        _isConnected = false;
      }
    } on SocketException catch (_) {
      _isConnected = false;
    }

    return _isConnected;
  }
}
