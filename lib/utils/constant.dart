import 'package:flutter/material.dart';

class Const {
  static const _scheme = "http://";
  static const _domain = "www.mocky.io/";
  static const _version = "v2/";
  static const baseUrl = _scheme + _domain + _version;
  static const primaryColor = Colors.blueGrey;

  static const String employeePrefFolderName =
      "employeePref"; // local database folder(table) name
}
