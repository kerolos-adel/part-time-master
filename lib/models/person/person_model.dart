class Person{
  String name;
  String email;
  DateTime birthDate;
  String gender;

  Person({
    required this.name,
    required this.email,
    required this.birthDate,
    required this.gender,
  });

  static Person FromJson(dynamic json) => Person(
      name: json["name"],
      email: json["email"],
      birthDate: DateTime.parse(json["birthDate"]),
      gender: json["gender"]
  );
}