class UserModel{
  String email;
  String name;
  int id;
  String role;

  UserModel({
    required this.email,
    required this.name,
    required this.id,
    required this.role
});

  static UserModel FromJson(Map<String, dynamic> json) => UserModel(
      email: json["sub"],
      name: json["name"],
      id: json["id"],
      role: json["roles"][0],
  );
}