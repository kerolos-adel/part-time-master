class Job {
  String title;
  String companyName;
  String location;
  String description;
  String requirements;
  String deadline;
  String contactEmail;
  String contactPhone;
  String applyLink;
  int ageFrom;
  int ageTo;

  Job({
    required this.location,
    required this.companyName,
    required this.contactEmail,
    required this.contactPhone,
    required this.deadline,
    required this.description,
    required this.requirements,
    required this.title,
    required this.applyLink,
    required this.ageFrom,
    required this.ageTo,
  });
}
