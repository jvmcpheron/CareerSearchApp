class JobDS {
  final String id;
  final int workYear;
  final String jobTitle;
  final String jobCategory;
  final String salaryCurrency;
  final int salary;
  final int salaryInUSDollar;
  final String employeeResidence;
  final String experienceLevel;
  final String employmentType;
  final String workSetting;
  final String companyLocation;
  final String companySize;

  JobDS(this.id, this.workYear, this.jobTitle, this.jobCategory,
      this.salaryCurrency, this.salary, this.salaryInUSDollar,
      this.employeeResidence, this.experienceLevel, this.employmentType,
      this.workSetting, this.companyLocation, this.companySize);


  String get getId => id;
  int get getWorkYear => workYear;
  String get getJobTitle => jobTitle;
  String get getJobCategory => jobCategory;
  String get getSalaryCurrency => salaryCurrency;
  int get getSalary => salary;
  int get getSalaryInUSDollar => salaryInUSDollar;
  String get getEmployeeResidence => employeeResidence;
  String get getExperienceLevel => experienceLevel;
  String get getEmploymentType => employmentType;
  String get getWorkSetting => workSetting;
  String get getCompanyLocation => companyLocation;
  String get getCompanySize => companySize;
}