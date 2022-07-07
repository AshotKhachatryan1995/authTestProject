import 'package:auth_test_project/models/user.dart';
import 'package:auth_test_project/navigation_screen.dart';
import 'package:auth_test_project/preferance/shared_preferance.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final appDocumentDirectory = await getApplicationDocumentsDirectory();

  Hive.init(appDocumentDirectory.path);
  Hive.registerAdapter(UserAdapter());

  await SharedPrefs().init();

  runApp(const NavigationScreen());
}
