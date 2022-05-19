import 'package:employee_directory/helpers/local_database_dao.dart';
import 'package:employee_directory/models/employee_obj.dart';
import 'package:employee_directory/services/employee_repository.dart';
import 'package:employee_directory/utils/enums.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EmployeeScreenController extends GetxController {
  var listEmployees = <EmployeeObj>[].obs;
  var isLoading = false.obs;
  var errorMessage = "".obs;
  var selectedEmpObject = EmployeeObj().obs;
  final txtSearch = TextEditingController();
  RxString searchText = ''.obs;
  var dao = LocalDatabaseDao();
  Rx<RetriveState> status = RetriveState.loading.obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    // load data from local db
    loadEmployeeDetailsFromLocal();
    txtSearch.addListener(() {
      searchText.value = txtSearch.text;
      loadEmployeeDetailsFromLocal(where: txtSearch.text, search: true);
    });

    // debounce(searchText, (_) {
    //   print("debouce$_");
    // }, time: const Duration(seconds: 1));
  }

  // load details from server when pull down the refresh indicator and loading first time then store in sembast
  void loadEmployeeDetailsFromServer({bool reset = true}) {
    print("Load Employee from server");
    status.value =
        RetriveState.loading; // for showing a CircularProgressIndicator()
    isLoading(true);
    try {
      EmployeeRepository().fetchEmployeeDetails().then((value) {
        listEmployees.value = value;
        if (value.isEmpty) {
          status.value = RetriveState.empty;
        } else {
          dao.insertEmployeeList(value, reset);
          status.value = RetriveState.success;
        }
      });
    } catch (e) {
      status.value = RetriveState.error;
      errorMessage.value = "Error: $e";
    }

    isLoading(false);
  }

  void loadEmployeeDetailsFromLocal({String where = "", bool search = false}) {
    print("Load Employee from local");
    print(where);
    status.value = RetriveState.loading;
    isLoading(true);
    try {
      dao.getEmployeeFromLocal(where: where).then((value) {
        listEmployees.value = value;
        if (value.isEmpty && !search) {
          loadEmployeeDetailsFromServer();
        } else {
          status.value = RetriveState.success;
        }
      });
    } catch (e) {
      status.value = RetriveState.error;
      errorMessage.value = "Error: $e";
    }

    isLoading(false);
  }
}
