import 'dart:io';

class Reader {
  static String readAsString(String path) => File(path).readAsStringSync();
  static String readAsStringTrim(String path) =>
      readAsString(path).replaceAll(RegExp(r'\s'), '');
}

