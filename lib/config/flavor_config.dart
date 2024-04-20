import 'package:flutter/services.dart';

/// Contains the hard-coded settings per flavor.
class FlavorSettings {
  final String apiBaseUrl;
  // TODO Add any additional flavor-specific settings here.

  FlavorSettings.dev() : apiBaseUrl = 'http://222.252.23.157:62399/api/v1';
  // "http://192.168.2.33:3000/api/v1";
 // 'http://222.252.23.157:62399/api/v1';

  //  FlavorSettings.dev() : apiBaseUrl = 'http://192.168.0.103:3000/api/v1';


  FlavorSettings.stg() : apiBaseUrl = 'http://192.168.2.80:3000/api/v1';

  FlavorSettings.prod() : apiBaseUrl = 'http://192.168.2.80:3000/api/v1';
}