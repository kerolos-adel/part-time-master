class Job {
  String title;
  String companyName;
  String location;
  String description;
  String salary;
  String requirements;
  String benefits;
  String deadline;
  String contactEmail;
  String contactPhone;
  bool isSaved = false;

  Job({
    required this.location,
    required this.benefits,
    required this.companyName,
    required this.contactEmail,
    required this.contactPhone,
    required this.deadline,
    required this.description,
    required this.requirements,
    required this.salary,
    required this.title,
    required this.isSaved,
  });
}
