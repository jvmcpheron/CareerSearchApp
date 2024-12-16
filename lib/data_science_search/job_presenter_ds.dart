import 'dart:core';
import 'job_manager_ds.dart';
import 'job_ds.dart';

class JobPresenterDS {

  final JobManagerDS _jobManagerDS = JobManagerDS();

  void fetchJobs(String q, int n) {
    _jobManagerDS.fetchJobs(q, n);
  }

  List<JobDS> getSearchResults() {
    return _jobManagerDS.getAllResults;
  }

  List<JobDS> getInPersonJobs() {
    return _jobManagerDS.getInPersonJobs;
  }

  List<JobDS> getHybridJobs() {
    return _jobManagerDS.getHybridJobs;
  }

  List<JobDS> getRemoteJobs() {
    return _jobManagerDS.getRemoteJobs;
  }

  Future<Map<String, String>> getAverageSalariesByJobPosition() {
    return _jobManagerDS.fetchAverageSalariesByJobPosition();
  }

  Future<Map<String, String>> getJobsByPosition(String jobPosition) {
    return _jobManagerDS.fetchJobsByPosition(jobPosition);
  }

}