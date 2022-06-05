import 'package:db_test_app/data/db_handler.dart';
import 'package:flutter/material.dart';

import 'app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DataBaseHandler.initDataBase();
  runApp(const MyApp());
}
