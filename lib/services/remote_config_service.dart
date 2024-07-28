import 'package:firebase_remote_config/firebase_remote_config.dart';

class RemoteConfigService {
  final FirebaseRemoteConfig _remoteConfig = FirebaseRemoteConfig.instance;

  RemoteConfigService() {
    _initializeRemoteConfig();
  }

  Future<void> _initializeRemoteConfig() async {
    try {
      await _remoteConfig.setConfigSettings(
        RemoteConfigSettings(
          fetchTimeout: Duration(seconds: 10),
          minimumFetchInterval: Duration(minutes: 1),
        ),
      );
      await _remoteConfig.setDefaults(const {
        "country_code": 'in',
      });
      await _remoteConfig.fetchAndActivate();
    } catch (e) {
      print("Error initializing Remote Config: $e");
    }
  }

  String getCountryCode() {
    String code = _remoteConfig.getString('country_code') ?? 'in';
    // print(code);
    return code;
  }
}
