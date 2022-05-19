import 'package:cached_network_image/cached_network_image.dart';
import 'package:employee_directory/controllers/employee_screen_controller.dart';
import 'package:employee_directory/models/employee_obj.dart';
import 'package:employee_directory/utils/constant.dart';
import 'package:employee_directory/utils/enums.dart';
import 'package:employee_directory/utils/route_paths.dart' as routes;
import 'package:employee_directory/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

final EmployeeScreenController _employeeScreenController =
    Get.find<EmployeeScreenController>();

class EmployeeScreen extends StatelessWidget {
  const EmployeeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        minimum: const EdgeInsets.all(10.0),
        child: GestureDetector(
          onTap: () {
            Utils.unfocus(context);
          },
          child: Scaffold(
            appBar: AppBar(
              title: Container(
                width: double.infinity,
                height: 40,
                color: Colors.white,
                child: Center(
                  child: TextField(
                    controller: _employeeScreenController.txtSearch,
                    decoration: const InputDecoration(
                      hintText: 'Search for Employee',
                      prefixIcon: Icon(Icons.search),
                    ),
                  ),
                ),
              ),
            ),
            body: const EmployeeListView(),
          ),
        ));
  }
}

class EmployeeListView extends StatelessWidget {
  const EmployeeListView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      List<EmployeeObj> _employeeData = _employeeScreenController.listEmployees;
      if (_employeeScreenController.status.value == RetriveState.success) {
        return RefreshIndicator(
          displacement: 50,
          backgroundColor: Const.primaryColor,
          color: Colors.white,
          strokeWidth: 3,
          triggerMode: RefreshIndicatorTriggerMode.onEdge,
          onRefresh: () async {
            _employeeScreenController.loadEmployeeDetailsFromServer();
          },
          child: ListView.builder(
            padding: const EdgeInsets.only(bottom: 125),
            physics: const BouncingScrollPhysics(
                parent: AlwaysScrollableScrollPhysics()),
            scrollDirection: Axis.vertical,
            itemCount: _employeeData.length,
            itemBuilder: (BuildContext context, int index) {
              var _data = _employeeData[index];
              return GestureDetector(
                onTap: () {
                  _employeeScreenController.selectedEmpObject.value = _data;
                  Get.toNamed(routes.employeeDetailsScreen);
                },
                child: ListTile(
                  title: Text(_data.name ?? ""),
                  leading: SizedBox(
                    width: 40,
                    height: 40,
                    child: CachedNetworkImage(
                      imageUrl: _data.profileImage ?? "",
                      placeholder: (context, url) => Utils.shimmer(),
                      errorWidget: (context, url, error) =>
                          const Icon(Icons.error),
                    ),

                    // child: Image.network(_data.profileImage ?? ""),
                  ),
                  subtitle: Text(_data.company?.name ?? ""),
                ),
              );
            },
          ),
        );
      } else if (_employeeScreenController.status.value == RetriveState.error) {
        return Text(_employeeScreenController.errorMessage.value);
      } else if (_employeeScreenController.status.value == RetriveState.empty) {
        return Utils.emptyWidget(
            title:
                "No Employee Available"); // custom widget for show a empty message
      } else {
        return Utils.loader();

        /// CircularProgressIndicator()
      }
    });
  }
}
