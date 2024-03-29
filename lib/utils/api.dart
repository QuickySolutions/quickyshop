import 'dart:io';

import 'package:flutter_dotenv/flutter_dotenv.dart';

class ApiUrl {
  static String _REMOTE_API = 'https://quiky-prod.uc.r.appspot.com';

  static String _LOCAL_API =
      'http://${Platform.isAndroid ? '10.0.2.2' : Platform.isIOS ? 'localhost' : ''}:8080';

  //static String API = dotenv.env['MODE'] == 'dev' ? _LOCAL_API : _REMOTE_API;

  static String API = _LOCAL_API;
}
