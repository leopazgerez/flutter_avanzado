class UserModel {
  bool? online;
  String? email;
  String? name;
  String? uid;

  UserModel({this.online, this.email, this.name, this.uid});

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
        online: json['online'] as bool?,
        email: json['email'] as String?,
        name: json['name'] as String?,
        uid: json['uid'] as String?);
  }

  Map<String, dynamic> toJson() {
      return {
        'online': online?? false,
        'email': email,
        'name': name,
        'uid': uid
      };
  }

  @override
  String toString() {
    return 'UserModel{online: $online, email: $email, name: $name, uid: $uid}';
  }
}
