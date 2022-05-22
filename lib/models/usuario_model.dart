class User{
  String? email;
  String? name;
  String? photo;
  String? provider;
  String? uid;

  User({
    this.email,
    this.name,
    this.photo,
    this.provider,
    this.uid
  });

  factory User.fromMap(Map<String, dynamic> map){
    return User(
      email: map['email'],
      name: map['name'],
      photo: map['photo'] ?? "Not image",
      provider: map['provider'],
      uid: map['uid'],
    );
  }
}