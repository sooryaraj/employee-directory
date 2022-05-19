import 'package:employee_directory/controllers/employee_screen_controller.dart';
import 'package:employee_directory/helpers/data_base.dart';
import 'package:employee_directory/utils/route_paths.dart' as routes;
import 'package:employee_directory/utils/router.dart' as router;
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
  runApp(MyApp());
  initController();
}

void initController() {
  Get.isLogEnable = false;
  AppDatabase.instance.database;
  Get.put(EmployeeScreenController());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Holidays',
      theme: ThemeData(
        backgroundColor: Colors.grey[800],
        primarySwatch: Colors.blueGrey,
      ),
      onGenerateRoute: router.generateRoute,
      initialRoute: routes.holidayScreen,
    );
  }
}
