import 'dart:io';

class ApiUrl {
  static String REMOTE_API = '';
  static String LOCAL_API =
      'http://${Platform.isAndroid ? '192.168.1.41' : 'localhost'}:3000';
}
