import 'dart:io';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'logger.dart';

class DeviceUtil {
  factory DeviceUtil() {
    return _singleton;
  }

  static final DeviceUtil _singleton = DeviceUtil._internal();

  DeviceUtil._internal() {
    Logger().v("Instance created DeviceUtil");
  }

  String _deviceId = '';
  String get deviceId => _deviceId;

  String? _version = '';
  String? _buildNumber = '';
  bool isPhysicalDevice = false;
  String get versionNumber => _version ?? '1.0' ;
  String get versionName => '$_version (${_buildNumber ?? '1.0'})';
  String get deviceType => Platform.isIOS ? 'ios' : 'android';

  Future<void> updateDeviceInfo() async {

    // Getting Device Info
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    if (Platform.isAndroid) {
      AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
      _deviceId = androidInfo.androidId!;
      isPhysicalDevice = androidInfo.isPhysicalDevice!;
    } else if (Platform.isIOS) {
      IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
      _deviceId = iosInfo.identifierForVendor!;
      isPhysicalDevice = iosInfo.isPhysicalDevice;
    }

    // Getting Device Info
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    _version = packageInfo.version;
    _buildNumber = packageInfo.buildNumber;
  }
}