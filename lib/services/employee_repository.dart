import 'package:employee_directory/helpers/api_provider.dart';
import 'package:employee_directory/models/employee_obj.dart';

class EmployeeRepository extends ApiProvider {
  Future<List<EmployeeObj>> fetchEmployeeDetails() async {
    List response = await get(
        path:
            '5d565297300000680030a986'); // getting response from ApiProvider class
    print(response);
    // List jsonResult = response["england-and-wales"]['events'];
    return response.map((job) => EmployeeObj.fromJson(job)).toList();
  }
}
