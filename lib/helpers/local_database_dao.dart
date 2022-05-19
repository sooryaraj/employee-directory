import 'package:employee_directory/helpers/data_base.dart';
import 'package:employee_directory/models/employee_obj.dart';
import 'package:employee_directory/utils/constant.dart';
import 'package:sembast/sembast.dart';

class LocalDatabaseDao {
  final _employeePrefFolder =
      intMapStoreFactory.store(Const.employeePrefFolderName);

  Future<Database> get _db async => await AppDatabase.instance.database;

  ///// INSERT BEGIN
  Future insertEmployeeList(List<EmployeeObj> value,
      [bool reset = true]) async {
    if (reset) deleteHolidays();
    return await Future.wait([
      for (var element in value)
        _employeePrefFolder.add(await _db, element.toJson()),
    ]);
  }

  ///// INSERT END
  //
  ///// SELECT BEGIN
  Future<List<EmployeeObj>> getEmployeeFromLocal() async {
// Using a regular expression matching the exact word (no case)
    var recordSnapshot = await _employeePrefFolder.find(await _db);
    var recordList = recordSnapshot.map((snapshot) {
      final data = EmployeeObj.fromJson(snapshot.value);
      return data;
    }).toList();
    return recordList;
  }

  ///// SELECT END
  //
  ///// DELETE BEGIN
  Future<int> deleteHolidays() async =>
      await _employeePrefFolder.delete(await _db);
  ///// DELETE END
}
