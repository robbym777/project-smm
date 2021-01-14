class DataModel {
  String googleId;
  PersonalInfo personalInfo;
  ContactInfo contactInfo;
  WorkInfo workInfo;

  DataModel(
      {this.googleId, this.personalInfo, this.contactInfo, this.workInfo});

  DataModel.fromJson(Map<String, dynamic> json) {
    googleId = json['googleId'];
    personalInfo = json['personalInfo'] != null
        ? new PersonalInfo.fromJson(json['personalInfo'])
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
    data['googleId'] = this.googleId;
    if (this.personalInfo != null) {
      data['personalInfo'] = this.personalInfo.toJson();
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

class PersonalInfo {
  String photo;
  String name;
  String birthPlace;
  String birthDate;
  String bloodType;
  Address address;

  PersonalInfo(
      {this.photo,
        this.name,
        this.birthPlace,
        this.birthDate,
        this.bloodType,
        this.address});

  PersonalInfo.fromJson(Map<String, dynamic> json) {
    photo = json['photo'];
    name = json['name'];
    birthPlace = json['birthPlace'];
    birthDate = json['birthDate'];
    bloodType = json['bloodType'];
    address =
    json['address'] != null ? new Address.fromJson(json['address']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['photo'] = this.photo;
    data['name'] = this.name;
    data['birthPlace'] = this.birthPlace;
    data['birthDate'] = this.birthDate;
    data['bloodType'] = this.bloodType;
    if (this.address != null) {
      data['address'] = this.address.toJson();
    }
    return data;
  }
}

class Address {
  String village;
  String street;
  String district;
  String province;

  Address({this.village, this.street, this.district, this.province});

  Address.fromJson(Map<String, dynamic> json) {
    village = json['village'];
    street = json['street'];
    district = json['district'];
    province = json['province'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['village'] = this.village;
    data['street'] = this.street;
    data['district'] = this.district;
    data['province'] = this.province;
    return data;
  }
}

class ContactInfo {
  String phoneNumber;
  String email;
  String familyContact;

  ContactInfo({this.phoneNumber, this.email, this.familyContact});

  ContactInfo.fromJson(Map<String, dynamic> json) {
    phoneNumber = json['phoneNumber'];
    email = json['email'];
    familyContact = json['familyContact'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['phoneNumber'] = this.phoneNumber;
    data['email'] = this.email;
    data['familyContact'] = this.familyContact;
    return data;
  }
}

class WorkInfo {
  int salary;
  String dept;
  String simperIdCard;
  String title;

  WorkInfo({this.salary, this.dept, this.simperIdCard, this.title});

  WorkInfo.fromJson(Map<String, dynamic> json) {
    salary = json['salary'];
    dept = json['dept'];
    simperIdCard = json['simperIdCard'];
    title = json['title'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['salary'] = this.salary;
    data['dept'] = this.dept;
    data['simperIdCard'] = this.simperIdCard;
    data['title'] = this.title;
    return data;
  }
}
