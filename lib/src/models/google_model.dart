class GoogleData {
  String uid;
  String displayName;
  String email;
  String phoneNo;
  String photoUrl;

  GoogleData({
    this.uid,
    this.displayName,
    this.email,
    this.phoneNo,
    this.photoUrl
  });

  GoogleData.fromJson(Map<String, dynamic> json)
      : uid = json['uid'] ?? '',
        displayName = json['displayName'] ?? '',
        email = json['email'] ?? '',
        phoneNo = json['phoneNo'] ?? '',
        photoUrl = json['photoUrl'] ?? '';

  Map<String, dynamic> toJson() => {
    'uid' : uid,
    'displayName': displayName,
    'email': email,
    'phonoNo': phoneNo,
    'photoUrl': photoUrl
  };
}