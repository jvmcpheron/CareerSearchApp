import 'dart:core';

import '../data_science_search/job_ds.dart';
import '../soft_eng_search/JobSE.dart';

class Entry {

  final DateTime date;
  // String company;
  String listingInfo;
  String jobTitle;
  String positives;
  String firstImpression;
  String challenges;
  String improvements;
  String notes;
  double rating;

  JobDS jobDS = JobDS('', 0, '', '', '', 0, 0, '', '', '', '', '', '');
  JobSE jobSE = JobSE('', '','', 0, '', 0);

  Entry(this.date, this.listingInfo, this.jobTitle, this.positives,
      this.firstImpression, this.challenges, this.improvements,
      this.notes, this.rating);

  Entry.fromJobDS(this.jobDS, this.date, this.listingInfo, this.jobTitle,
      this.positives, this.firstImpression, this.challenges,
      this.improvements, this.notes, this.rating);

  // Entry.fromJobSE(this.jobSE, this.date, this.listingInfo, this.jobTitle,
  //     this.positives, this.firstImpression, this.challenges,
  //     this.improvements, this.notes, this.rating);
  //
  // Entry.fromEntry(this.jobDS, this.jobSE, this.date, this.listingInfo,
  //     this.jobTitle, this.positives, this.firstImpression, this.challenges,
  //     this.improvements, this.notes, this.rating);

  DateTime get getDate => date;
  String get getListingInfo => listingInfo;
  String get getJobTitle => jobTitle;
  String get getPositives => positives;
  String get getFirstImpression => firstImpression;
  String get getChallenges => challenges;
  String get getImprovements => improvements;
  String get getNotes => notes;
  double get getRating => rating;

}