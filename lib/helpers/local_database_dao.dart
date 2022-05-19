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
    if (reset) deleteEmployee();
    return await Future.wait([
      for (var element in value)
        _employeePrefFolder.add(await _db, element.toJson()),
    ]);
  }

  ///// INSERT END
  //
  ///// SELECT BEGIN
  Future<List<EmployeeObj>> getEmployeeFromLocal({String where = ""}) async {
// Using a regular expression matching the exact word (no case)
    List<RecordSnapshot<int, Map<String, Object?>>> recordSnapshot;
    if (where != "") {
      // Using a custom filter exact word (converting everything to lowercase)
      where = where.toLowerCase();
      var filter2 = Filter.custom((snapshot) {
        var value = snapshot["name"] as String;
        print(value);
        return value.toLowerCase() == where;
      });

// Using a regular expression matching the exact word (no case)
      var filter = Filter.or([
        Filter.matchesRegExp('name', RegExp(where, caseSensitive: false)),
        Filter.matchesRegExp('email', RegExp(where, caseSensitive: false)),
      ]);
      recordSnapshot = await _employeePrefFolder.find(await _db,
          finder: Finder(filter: filter));
    } else {
      recordSnapshot = await _employeePrefFolder.find(await _db);
    }
    var recordList = recordSnapshot.map((snapshot) {
      final data = EmployeeObj.fromJson(snapshot.value);
      return data;
    }).toList();
    return recordList;
  }

  ///// SELECT END
  //
  ///// DELETE BEGIN
  Future<int> deleteEmployee() async =>
      await _employeePrefFolder.delete(await _db);
  ///// DELETE END
}
