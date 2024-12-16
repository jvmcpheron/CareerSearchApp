import 'package:cloud_firestore/cloud_firestore.dart';
import '../Authentication/UUID.dart';
import '../data_science_search/csv_reader_ds.dart';
import '../data_science_search/job_ds.dart';
import '../soft_eng_search/JobSE.dart';
import 'entry.dart';

class EntryManager {

  CSVReaderDS csvReader = CSVReaderDS('assets/journal_entries.csv');
  static final EntryManager _instance = EntryManager._internal();

  factory EntryManager() => _instance;

  EntryManager._internal();

  final List<Entry> _entries = [];


  void updateCsv() {
    String? userId = UserSingleton.instance.getUserId();
    List<List<dynamic>> entriesAsList = [];

    for (Entry entry in _entries) {
      entriesAsList.add([
        userId,
        entry.jobDS.getId,
        entry.jobDS.getWorkYear,
        entry.jobDS.getJobTitle,
        entry.jobDS.getJobCategory,
        entry.jobDS.getSalaryCurrency,
        entry.jobDS.getSalary,
        entry.jobDS.getSalaryInUSDollar,
        entry.jobDS.getEmployeeResidence,
        entry.jobDS.getExperienceLevel,
        entry.jobDS.getEmploymentType,
        entry.jobDS.getWorkSetting,
        entry.jobDS.getCompanyLocation,
        entry.jobDS.getCompanySize,
        entry.jobSE.getId,
        entry.jobSE.getJobTitle,
        entry.jobSE.getLocation,
        entry.jobSE.getLocation,
        entry.jobSE.getCompanyName,
        entry.jobSE.getCompanyScore,
        entry.getDate,
        entry.getListingInfo,
        entry.getJobTitle,
        entry.getPositives,
        entry.getFirstImpression,
        entry.getChallenges,
        entry.getImprovements,
        entry.getNotes,
        entry.getRating
      ]);
    }
    csvReader.writeData(entriesAsList);
  }

  List<Entry> getEntries() {
    fetchEntries();
    return _entries;
  }

  Future<void> editEntry(Entry e) async {
    addEntry(e);
  }

  Future<void> removeEntry(Entry e) async {
    String? userId = UserSingleton.instance.getUserId();

    if (userId == null) {
      print("User ID is null. Cannot remove entry.");
      return;
    }

    _entries.removeWhere((entry) => entry.getDate == e.date);

    // updateCsv();
  }

  Future<void> addEntry(Entry e) async {
    String? userId = UserSingleton.instance.getUserId();

    if (userId == null) {
      print("User ID is null. Cannot add entry.");
      return;
    }

    bool entryExists = _entries.any((entry) => entry.getDate == e.date);
    if (entryExists) {
      _entries[_entries.indexWhere(
              (entry) => entry.getDate == e.date)] = e;
      print("entry removed from entries.");
    } else {
      _entries.add(e);
    }
    // updateCsv();
  }

  Future<void> fetchEntries() async {
    //   String? userId = UserSingleton.instance.getUserId();
    //
    //   if (userId == null) {
    //     throw Exception("User ID is null. Cannot fetch entries.");
    //   }
    //
    //   List<List<dynamic>> csvData = await csvReader.fetchData();
    //
    //   csvData.removeWhere((line) => line[0] != userId);
    //
    //   _entries.clear();
    //
    //   _entries.addAll(csvData.map((line) {
    //     return Entry.fromEntry(
    //       JobDS(
    //         line[1],
    //         line[2],
    //         line[3],
    //         line[4],
    //         line[5],
    //         line[6],
    //         line[7],
    //         line[8],
    //         line[9],
    //         line[10],
    //         line[11],
    //         line[12],
    //         line[13],
    //       ),
    //       JobSE(
    //         line[14],
    //         line[15],
    //         line[16],
    //         line[17],
    //         line[18],
    //         line[19],
    //       ),
    //       line[20],
    //       line[21],
    //       line[22],
    //       line[23],
    //       line[24],
    //       line[25],
    //       line[26],
    //       line[27],
    //       line[28],
    //     );
    //   }).toList());
    // }
  }
}
