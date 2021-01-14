class AttendanceModel {
  String employeeId;
  String tanggal;
  String jam;
  String location;

  AttendanceModel({this.employeeId, this.tanggal, this.jam, this.location});

  AttendanceModel.fromJson(Map<String, dynamic> json) {
    employeeId = json['employeeId'];
    tanggal = json['tanggal'];
    jam = json['jam'];
    location = json['location'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['employeeId'] = this.employeeId;
    data['tanggal'] = this.tanggal;
    data['jam'] = this.jam;
    data['location'] = this.location;
    return data;
  }
}
