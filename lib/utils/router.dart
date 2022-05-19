import 'package:employee_directory/screens/employee_details_screen.dart';
import 'package:employee_directory/screens/employee_screen.dart';
import 'package:employee_directory/utils/route_paths.dart' as routes;
import 'package:flutter/material.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case routes.employeeScreen:
      return MaterialPageRoute(builder: (context) => const EmployeeScreen());
    case routes.employeeDetailsScreen:
      return MaterialPageRoute(
          builder: (context) => const EmployeeDetailsScreen());
    default:
      return MaterialPageRoute(
        builder: (context) => Scaffold(
          body: Center(
            child: Text('No path for ${settings.name}'),
          ),
        ),
      );
  }
}
