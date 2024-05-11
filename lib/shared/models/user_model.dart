class UserModel {
  late String uid;
  late String email;
  late String name;
  String? profilePicture;
  String? pin;
  String? phone;

  Map<String, dynamic> toJson() => {
        'uid': uid,
        'email': email,
        'name': name,
        'profile_picture': profilePicture,
        'pin': pin,
        'phone': phone
      };

  UserModel.fromJson(Map<String, dynamic> jsonMap, String id) {
    uid = id;
    email = jsonMap['email'];
    name = jsonMap['name'];
    profilePicture = jsonMap['profile_picture'];
    pin = jsonMap['pin'];
    phone = jsonMap['phone'];
  }
}
