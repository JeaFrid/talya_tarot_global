import 'package:device_info_plus/device_info_plus.dart';

Future<Map<String, dynamic>> getDeviceDetails() async {
  final deviceInfoPlugin = DeviceInfoPlugin();
  AndroidDeviceInfo androidInfo = await deviceInfoPlugin.androidInfo;
  return {
    'model': androidInfo.model,
    'androidId': androidInfo.id,
    'version': androidInfo.version,
    'name': androidInfo.name,
  };
}
