import 'package:attendance_application/src/models/attendance_model.dart';
import 'package:attendance_application/src/models/employee_model.dart';
import 'package:sqflite/sqflite.dart' as sql;
import 'package:path/path.dart' as path;

class DbService {
  sql.Database db;

  Future<void> open() async {
    final dbPath = await sql.getDatabasesPath();
    final myDbPath = path.join(dbPath, 'localdata.db');

    db = await sql.openDatabase(
      myDbPath,
      onCreate: (db, version) async {
        //Table for staff
        await db.execute(
            "CREATE TABLE staffProfile(id TEXT PRIMARY KEY, personalInfoId TEXT, contactInfoId TEXT, workInfoId TEXT )");
        //Table for employee
        await db.execute(
            "CREATE TABLE employee(id TEXT PRIMARY KEY, personalInfoId TEXT, contactInfoId TEXT, workInfoId TEXT )");

        //Info table
        await db.execute(
            "CREATE TABLE personalInfo (id TEXT PRIMARY KEY, photo TEXT, name TEXT, gender TEXT, birthPlace TEXT, birthDate TEXT, bloodType TEXT, addressId TEXT )");
        await db.execute(
            "CREATE TABLE address (id TEXT PRIMARY KEY, village TEXT, street TEXT, district TEXT, province TEXT )");
        await db.execute(
            "CREATE TABLE contactInfo (id TEXT PRIMARY KEY, phoneNumber TEXT, email TEXT, familyContact TEXT )");
        await db.execute(
            "CREATE TABLE workInfo (id TEXT PRIMARY KEY, qrId TEXT, nfcId TEXT, salary INTEGER, dept TEXT, simperIdCard TEXT, title TEXT )");

        //Table for attendance
        await db.execute(
            "CREATE TABLE attendance (tanggal TEXT, jam TEXT, location TEXT, employeeId TEXT , status TEXT) ");

        //Table for history
        await db.execute(
            "CREATE TABLE history (date TEXT, hour TEXT, status TEXT, employeeId TEXT )");

        //Table for location
        await db.execute(
            "CREATE TABLE location (address TEXT )");
      },
      version: 1,
    );
  }

  addStaffProfile(EmployeeModel staffData) async {
    await open();
    List<Map<String, dynamic>> checkData = await db.rawQuery(
        "SELECT * FROM staffProfile WHERE id = '${staffData.employee.id}'"
    );

    if (checkData.isEmpty) {
      await db.insert('staffProfile', staffData.employee.toJson());
      await db.insert('personalInfo', staffData.personalInfo.toJson());
      await db.insert('address', staffData.address.toJson());
      await db.insert('contactInfo', staffData.contactInfo.toJson());
      await db.insert('workInfo', staffData.workInfo.toJson());

      print('success');
      return 'success';
    } else {
      return 'already';
    }
  }

  getStaffProfile() async {
    await open();
    List<Map<String, dynamic>> staffProfile = await db.rawQuery(
        "SELECT * FROM staffProfile"
    );
    List<Map<String, dynamic>> personalInfoData = await db.rawQuery(
        "SELECT * FROM personalInfo WHERE personalInfo.id = '${staffProfile[0]['personalInfoId']}'"
    );
    List<Map<String, dynamic>> addressData = await db.rawQuery(
        "SELECT * FROM address WHERE address.id = '${personalInfoData[0]['addressId']}'"
    );
    List<Map<String, dynamic>> contactInfoData = await db.rawQuery(
        "SELECT * FROM contactInfo WHERE contactInfo.id = '${staffProfile[0]['contactInfoId']}'"
    );
    List<Map<String, dynamic>> workInfoData = await db.rawQuery(
        "SELECT * FROM workInfo WHERE workInfo.id = '${staffProfile[0]['workInfoId']}'"
    );

    return EmployeeModel(
      employee: Employee.fromJson(staffProfile[0]),
      personalInfo: PersonalInfo.fromJson(personalInfoData[0]),
      address: Address.fromJson(addressData[0]),
      contactInfo: ContactInfo.fromJson(contactInfoData[0]),
      workInfo: WorkInfo.fromJson(workInfoData[0]),
    );
  }

  deleteProfile() async {
    await open();
    await db.rawQuery("DELETE FROM staffProfile");
  }

  addEmployeeData(EmployeeModel employeeData) async {
    await open();
    List<Map<String, dynamic>> checkData = await db.rawQuery(
        "SELECT id FROM employee WHERE id = '${employeeData.employee.id}'"
    );

    if (checkData.isEmpty) {
      await db.insert('employee', employeeData.employee.toJson());
      await db.insert('personalInfo', employeeData.personalInfo.toJson());
      await db.insert('address', employeeData.address.toJson());
      await db.insert('contactInfo', employeeData.contactInfo.toJson());
      await db.insert('workInfo', employeeData.workInfo.toJson());

      return 'success';
    } else {
      return 'already';
    }
  }

  updateEmployeeData(EmployeeModel employeeData) async {
    await open();
    await db.update('personalInfo',
        employeeData.personalInfo.toJson(), where: "id = ?", whereArgs: [employeeData.personalInfo.id]);
    await db.update('address',
        employeeData.address.toJson(), where: "id = ?", whereArgs: [employeeData.address.id]);
    await db.update('contactInfo',
        employeeData.contactInfo.toJson(), where: "id = ?", whereArgs: [employeeData.contactInfo.id]);
    await db.update('workInfo',
        employeeData.workInfo.toJson(), where: "id = ?", whereArgs: [employeeData.workInfo.id]);

    return 'success';
  }

  addHistory(history) async {
    await open();
    await db.insert('history',
        {"date": history['date'], "hour": history['hour'], "status": history['status']}
    );
  }

  getAllHistory() async {
    await open();
    List<Map<String, dynamic>> history = await db.rawQuery("SELECT * FROM history");

    return history;
  }

  checkLatestHistory() async {
    await open();
    List<Map<String, dynamic>> date = await db.rawQuery("SELECT * FROM history ORDER BY hour DESC LIMIT 1");

    return date;
  }

  //=========== Employee Profile Table ============
  getAllEmployeeData() async {
    await open();
    List<Map<String, dynamic>> employeeData = await db.rawQuery("SELECT * FROM employee");

    return employeeData;
  }

  getEmployeeByQRCode(String code) async {
    await open();
    List<Map<String, dynamic>> employeeData = await db.rawQuery(
        "SELECT "
            "employee.id, "
            "employee.personalInfoId, "
            "employee.contactInfoId, "
            "employee.workInfoId, "
            "personalInfo.addressId "
            "FROM employee "
              "INNER JOIN personalInfo ON employee.personalInfoId = personalInfo.id "
              "INNER JOIN workinfo ON employee.workInfoId = workInfo.id "
              "WHERE workInfo.qrId = '$code' "
    );

    if (employeeData.isEmpty) {
      return employeeData;
    } else {
      List<Map<String, dynamic>> personalInfoData = await db.rawQuery(
          "SELECT * FROM personalInfo WHERE personalInfo.id = '${employeeData[0]['personalInfoId']}'"
      );
      List<Map<String, dynamic>> addressData = await db.rawQuery(
          "SELECT * FROM address WHERE address.id = '${personalInfoData[0]['addressId']}'"
      );
      List<Map<String, dynamic>> contactInfoData = await db.rawQuery(
          "SELECT * FROM contactInfo WHERE contactInfo.id = '${employeeData[0]['contactInfoId']}'"
      );
      List<Map<String, dynamic>> workInfoData = await db.rawQuery(
          "SELECT * FROM workInfo WHERE workInfo.id = '${employeeData[0]['workInfoId']}'"
      );

      return EmployeeModel(
        employee: Employee.fromJson(employeeData[0]),
        personalInfo: PersonalInfo.fromJson(personalInfoData[0]),
        address: Address.fromJson(addressData[0]),
        contactInfo: ContactInfo.fromJson(contactInfoData[0]),
        workInfo: WorkInfo.fromJson(workInfoData[0]),
      );
    }
  }

  getEmployeeByCardId(String code) async {
    await open();
    List<Map<String, dynamic>> employeeData;

    employeeData = await db.rawQuery(
        "SELECT "
            "employee.id, "
            "employee.personalInfoId, "
            "employee.contactInfoId, "
            "employee.workInfoId, "
            "personalInfo.addressId "
            "FROM employee "
            "INNER JOIN personalInfo ON employee.personalInfoId = personalInfo.id "
            "INNER JOIN workinfo ON employee.workInfoId = workInfo.id "
            "WHERE workInfo.nfcId = '$code' "
    );

    if (employeeData.isEmpty) {
      return 'data not found';
    } else {
      List<Map<String, dynamic>> personalInfoData = await db.rawQuery(
          "SELECT * FROM personalInfo WHERE personalInfo.id = '${employeeData[0]['personalInfoId']}'"
      );
      List<Map<String, dynamic>> addressData = await db.rawQuery(
          "SELECT * FROM address WHERE address.id = '${personalInfoData[0]['addressId']}'"
      );
      List<Map<String, dynamic>> contactInfoData = await db.rawQuery(
          "SELECT * FROM contactInfo WHERE contactInfo.id = '${employeeData[0]['contactInfoId']}'"
      );
      List<Map<String, dynamic>> workInfoData = await db.rawQuery(
          "SELECT * FROM workInfo WHERE workInfo.id = '${employeeData[0]['workInfoId']}'"
      );

      return EmployeeModel(
        employee: Employee.fromJson(employeeData[0]),
        personalInfo: PersonalInfo.fromJson(personalInfoData[0]),
        address: Address.fromJson(addressData[0]),
        contactInfo: ContactInfo.fromJson(contactInfoData[0]),
        workInfo: WorkInfo.fromJson(workInfoData[0]),
      );
    }
  }

  checkAttendanceStatus(AttendanceModel attendanceData) async {
    await open();
    List<Map<String, dynamic>> attendance = await db.rawQuery(
        "SELECT * FROM attendance "
            "WHERE employeeId = '${attendanceData.employeeId}' "
            "AND tanggal = '${attendanceData.tanggal}'"
    );

    return attendance;
  }

  submitAttendanceLocal(AttendanceModel attendanceData, status) async {
    await open();
    await db.insert('attendance', {
      "tanggal": attendanceData.tanggal,
      "jam": attendanceData.jam,
      "location": attendanceData.location,
      "employeeId": attendanceData.employeeId,
      "status": status
    });
    return 'success';
  }

  //=========== Attendance Table ===========
  getAllAttendance() async {
    await open();
    List<Map<String, dynamic>> listAttendance = await db.rawQuery(
        "SELECT * FROM attendance "
            "JOIN employee ON attendance.employeeId = employee.id "
            "JOIN personalInfo ON employee.personalInfoId = personalInfo.id ");

    if (listAttendance.isNotEmpty) {
      return listAttendance;
    } else {
      return listAttendance;
    }
  }

  getAttendance() async {
    await open();
    List<Map<String, dynamic>> listAttendance = await db.rawQuery(
        "SELECT * FROM attendance ");

    if (listAttendance.isNotEmpty) {
      return listAttendance;
    } else {
      return listAttendance;
    }
  }

  getAttendanceByDate(date) async {
    await open();
    List<Map<String, dynamic>> listAttendance = await db.rawQuery(
        "SELECT * FROM attendance "
            "JOIN employee ON attendance.employeeId = employee.id "
            "JOIN personalInfo ON employee.personalInfoId = personalInfo.id "
            "WHERE tanggal = '$date'");

    if (listAttendance.isNotEmpty) {
      return listAttendance;
    } else {
      return listAttendance;
    }
  }

  deleteAttendance() async {
    await open();
    await db.rawQuery("DELETE FROM attendance");
  }

  deleteDataBase() async {
    final dbPath = await sql.getDatabasesPath();
    final myDbPath = path.join(dbPath, 'localdata.db');
    await sql.deleteDatabase(myDbPath);
    print('success');
  }

  //========== Location Table ==============
  setLocation(location) async {
    await open();
    await db.insert('location', {'address' : location});
    return 'success';
  }

  getLocation() async {
    await open();
    List<Map<String, dynamic>> location = await db.rawQuery(
        "SELECT * FROM location ORDER BY address DESC LIMIT 1"
    );
    return location;
  }
}