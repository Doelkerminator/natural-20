class UserModel{
  String? email;
  String? name;
  String? photo;
  String? provider;
  String? uid;

  UserModel({
    this.email,
    this.name,
    this.photo,
    this.provider,
    this.uid
  });

  factory UserModel.fromMap(Map<String, dynamic> map){
    return UserModel(
      email: map['email'],
      name: map['name'],
      photo: map['photo'],
      provider: map['provider'],
      uid: map['uid'],
    );
  }
}