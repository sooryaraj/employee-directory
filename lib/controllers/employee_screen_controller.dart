import 'package:employee_directory/helpers/local_database_dao.dart';
import 'package:employee_directory/models/employee_obj.dart';
import 'package:employee_directory/services/employee_repository.dart';
import 'package:employee_directory/utils/enums.dart';
import 'package:get/get.dart';

class EmployeeScreenController extends GetxController {
  var listEmployees = <EmployeeObj>[].obs;
  var isLoading = false.obs;
  var errorMessage = "".obs;
  var selectedEmpObject = EmployeeObj().obs;
  var dao = LocalDatabaseDao();
  Rx<RetriveState> status = RetriveState.loading.obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    // load data from local db
    loadEmployeeDetailsFromLocal();
  }

  // load details from server when pull down the refresh indicator and loading first time then store in sembast
  void loadEmployeeDetailsFromServer({bool reset = true}) {
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

  void loadEmployeeDetailsFromLocal() {
    status.value = RetriveState.loading;
    isLoading(true);
    try {
      dao.getEmployeeFromLocal().then((value) {
        listEmployees.value = value;
        if (value.isEmpty) {
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
