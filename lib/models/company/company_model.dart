class Company{
  int id;
  String name;
  String location;
  String email;
  String phoneNumber;
  // List of jobs

  Company({
    required this.id,
    required this.name,
    required this.email,
    required this.phoneNumber,
    required this.location,
});

  static Company FromJson (dynamic json) => Company(
      id: json["id"],
      name: json["name"],
      email: json["email"],
      phoneNumber: json["phoneNumber"],
      location: json["location"]
  );

}