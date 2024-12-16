class JobSE {
  final String id;
  final String jobTitle;
  final String location;
  final int salary;
  final String companyName;
  final double companyScore;

  JobSE(this.id, this.jobTitle, this.location, this.salary, this.companyName, this.companyScore);

  // Getters
  String get getId => id;
  String get getJobTitle => jobTitle;
  String get getLocation => location;
  int get getSalary => salary;
  String get getCompanyName => companyName;
  double get getCompanyScore => companyScore;
}