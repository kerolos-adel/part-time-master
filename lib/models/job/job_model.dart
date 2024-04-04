class Job {
  int companyId;
  String title;
  String companyName;
  String location;
  String description;
  String requirements;
  String contactEmail;
  String contactPhone;
  String applyLink;
  int ageFrom;
  int ageTo;

  Job({
    required this.companyId,
    required this.location,
    required this.companyName,
    required this.contactEmail,
    required this.contactPhone,
    required this.description,
    required this.requirements,
    required this.title,
    required this.applyLink,
    required this.ageFrom,
    required this.ageTo,
  });

  static Job FromJson(dynamic json, dynamic company) => Job(
      companyId: company.id,
      location: company.location,
      companyName: company.name,
      contactEmail: company.email,
      contactPhone: company.phoneNumber,
      description: json["description"],
      requirements: json["requirements"],
      title: json["title"],
      applyLink: json["applyLink"],
      ageFrom: json["ageFrom"],
      ageTo: json["ageTo"]
  );
}
