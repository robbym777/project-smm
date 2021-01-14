class EmployeeModel {
  Employee employee;
  PersonalInfo personalInfo;
  Address address;
  ContactInfo contactInfo;
  WorkInfo workInfo;

  EmployeeModel(
      {this.employee,
        this.personalInfo,
        this.address,
        this.contactInfo,
        this.workInfo});

  EmployeeModel.fromJson(Map<String, dynamic> json) {
    employee = json['employee'] != null
        ? new Employee.fromJson(json['employee'])
        : null;
    personalInfo = json['personalInfo'] != null
        ? new PersonalInfo.fromJson(json['personalInfo'])
        : null;
    address = json['address'] != null
        ? new Address.fromJson(json['address'])
        : null;
    contactInfo = json['contactInfo'] != null
        ? new ContactInfo.fromJson(json['contactInfo'])
        : null;
    workInfo = json['workInfo'] != null
        ? new WorkInfo.fromJson(json['workInfo'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.employee != null) {
      data['employee'] = this.employee.toJson();
    }
    if (this.personalInfo != null) {
      data['personalInfo'] = this.personalInfo.toJson();
    }
    if (this.address != null) {
      data['address'] = this.address.toJson();
    }
    if (this.contactInfo != null) {
      data['contactInfo'] = this.contactInfo.toJson();
    }
    if (this.workInfo != null) {
      data['workInfo'] = this.workInfo.toJson();
    }
    return data;
  }
}

class Employee {
  String id;
  String personalInfoId;
  String contactInfoId;
  String workInfoId;

  Employee({this.id, this.personalInfoId, this.contactInfoId, this.workInfoId});

  Employee.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    personalInfoId = json['personalInfoId'];
    contactInfoId = json['contactInfoId'];
    workInfoId = json['workInfoId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['personalInfoId'] = this.personalInfoId;
    data['contactInfoId'] = this.contactInfoId;
    data['workInfoId'] = this.workInfoId;
    return data;
  }
}

class PersonalInfo {
  String id;
  String photo;
  String name;
  String gender;
  String birthPlace;
  String birthDate;
  String bloodType;
  String addressId;

  PersonalInfo(
      {this.id,
        this.photo,
        this.name,
        this.gender,
        this.birthPlace,
        this.birthDate,
        this.bloodType,
        this.addressId});

  PersonalInfo.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    photo = json['photo'];
    name = json['name'];
    gender = json['gender'];
    birthPlace = json['birthPlace'];
    birthDate = json['birthDate'];
    bloodType = json['bloodType'];
    addressId = json['addressId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['photo'] = this.photo;
    data['name'] = this.name;
    data['gender'] = this.gender;
    data['birthPlace'] = this.birthPlace;
    data['birthDate'] = this.birthDate;
    data['bloodType'] = this.bloodType;
    data['addressId'] = this.addressId;
    return data;
  }
}

class Address {
  String id;
  String village;
  String street;
  String district;
  String province;

  Address({this.id, this.village, this.street, this.district, this.province});

  Address.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    village = json['village'];
    street = json['street'];
    district = json['district'];
    province = json['province'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['village'] = this.village;
    data['street'] = this.street;
    data['district'] = this.district;
    data['province'] = this.province;
    return data;
  }
}

class ContactInfo {
  String id;
  String phoneNumber;
  String email;
  String familyContact;

  ContactInfo({this.id, this.phoneNumber, this.email, this.familyContact});

  ContactInfo.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    phoneNumber = json['phoneNumber'];
    email = json['email'];
    familyContact = json['familyContact'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['phoneNumber'] = this.phoneNumber;
    data['email'] = this.email;
    data['familyContact'] = this.familyContact;
    return data;
  }
}

class WorkInfo {
  String id;
  String qrId;
  String nfcId;
  int salary;
  String dept;
  String simperIdCard;
  String title;

  WorkInfo(
      {this.id,
        this.qrId,
        this.nfcId,
        this.salary,
        this.dept,
        this.simperIdCard,
        this.title});

  WorkInfo.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    qrId = json['qrId'];
    nfcId = json['nfcId'];
    salary = json['salary'];
    dept = json['dept'];
    simperIdCard = json['simperIdCard'];
    title = json['title'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['qrId'] = this.qrId;
    data['nfcId'] = this.nfcId;
    data['salary'] = this.salary;
    data['dept'] = this.dept;
    data['simperIdCard'] = this.simperIdCard;
    data['title'] = this.title;
    return data;
  }
}
