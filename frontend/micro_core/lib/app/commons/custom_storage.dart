import 'package:commons_deps/commons_deps.dart';

import '../../micro_core.dart';

abstract class CustomStorage {

  static final GetStorage _box = GetStorage(CustomConstants.projeto);

  static saveStore(String key, value) {    
    _box.write(key, value);
  }

  static String readStore(String key) {    
    return _box.read(key) ?? '';
  }
}
