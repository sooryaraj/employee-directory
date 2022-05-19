import 'package:cached_network_image/cached_network_image.dart';
import 'package:employee_directory/controllers/employee_screen_controller.dart';
import 'package:employee_directory/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

final EmployeeScreenController _employeeScreenController =
    Get.find<EmployeeScreenController>();

class EmployeeDetailsScreen extends StatelessWidget {
  const EmployeeDetailsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        minimum: const EdgeInsets.all(10.0),
        child: Scaffold(
          appBar: AppBar(
            title: const Text("Employee Details"),
            centerTitle: true,
          ),
          body: Center(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 200,
                    width: 200,
                    child: CachedNetworkImage(
                      imageUrl: _employeeScreenController
                              .selectedEmpObject.value.profileImage ??
                          "",
                      placeholder: (context, url) => Utils.shimmer(),
                      errorWidget: (context, url, error) =>
                          const Icon(Icons.error),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    _employeeScreenController.selectedEmpObject.value.name ??
                        "",
                    style: const TextStyle(
                        color: Colors.black54,
                        fontWeight: FontWeight.bold,
                        fontSize: 25),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    "@${_employeeScreenController.selectedEmpObject.value.username ?? ""}",
                    style: const TextStyle(
                        color: Colors.black54,
                        fontWeight: FontWeight.bold,
                        fontSize: 15),
                  ),
                  Text(
                    _employeeScreenController.selectedEmpObject.value.email ??
                        "",
                    style: const TextStyle(
                        color: Colors.black54,
                        fontWeight: FontWeight.bold,
                        fontSize: 15),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      const Icon(Icons.phone),
                      const SizedBox(
                        width: 20,
                      ),
                      Text(
                        _employeeScreenController
                                .selectedEmpObject.value.phone ??
                            "",
                        style: const TextStyle(
                            color: Colors.black54,
                            fontWeight: FontWeight.bold,
                            fontSize: 15),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      const Icon(Icons.web_rounded),
                      const SizedBox(
                        width: 20,
                      ),
                      Text(
                        _employeeScreenController
                                .selectedEmpObject.value.website ??
                            "",
                        style: const TextStyle(
                            color: Colors.black54,
                            fontWeight: FontWeight.bold,
                            fontSize: 15),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Align(
                      alignment: Alignment.centerLeft,
                      child: Text("Company Details",
                          style: const TextStyle(
                              color: Colors.black54,
                              fontWeight: FontWeight.bold,
                              fontSize: 20))),
                  Card(
                    child: Column(
                      children: [
                        Text(
                          _employeeScreenController
                                  .selectedEmpObject.value.company?.name ??
                              "",
                          style: const TextStyle(
                              color: Colors.black54,
                              fontWeight: FontWeight.bold,
                              fontSize: 20),
                        ),
                        Text(
                          _employeeScreenController
                                  .selectedEmpObject.value.company?.bs ??
                              "",
                          style: const TextStyle(
                              color: Colors.black54,
                              fontWeight: FontWeight.bold,
                              fontSize: 15),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          _employeeScreenController.selectedEmpObject.value
                                  .company?.catchPhrase ??
                              "",
                          style: const TextStyle(
                              color: Colors.black54,
                              fontWeight: FontWeight.bold,
                              fontSize: 15),
                        ),
                      ],
                    ),
                  ),
                  const Align(
                      alignment: Alignment.centerLeft,
                      child: Text("Address",
                          style: const TextStyle(
                              color: Colors.black54,
                              fontWeight: FontWeight.bold,
                              fontSize: 20))),
                  Card(
                    elevation: 3,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Column(
                            children: [
                              Text(
                                _employeeScreenController.selectedEmpObject
                                        .value.address?.city ??
                                    "",
                                style: const TextStyle(
                                    color: Colors.black54,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15),
                              ),
                              Text(
                                _employeeScreenController.selectedEmpObject
                                        .value.address?.street ??
                                    "",
                                style: const TextStyle(
                                    color: Colors.black54,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15),
                              ),
                              Text(
                                _employeeScreenController.selectedEmpObject
                                        .value.address?.suite ??
                                    "",
                                style: const TextStyle(
                                    color: Colors.black54,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15),
                              ),
                              Text(
                                _employeeScreenController.selectedEmpObject
                                        .value.address?.zipcode ??
                                    "",
                                style: const TextStyle(
                                    color: Colors.black54,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15),
                              ),
                            ],
                          ),
                          TextButton.icon(
                              onPressed: () {
                                Utils.openMap(
                                    double.parse(_employeeScreenController
                                            .selectedEmpObject
                                            .value
                                            .address
                                            ?.geo
                                            ?.lat ??
                                        "0.0"),
                                    double.parse(_employeeScreenController
                                            .selectedEmpObject
                                            .value
                                            .address
                                            ?.geo
                                            ?.lng ??
                                        "0.0"));
                              },
                              icon: const Icon(Icons.map_outlined),
                              label: const Text("view in map")),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
