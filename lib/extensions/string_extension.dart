import 'dart:convert';
import 'package:crypto/crypto.dart';

extension StringAddition on String {
  String generateMd5() {
    return md5.convert(utf8.encode(this)).toString();
  }
}
