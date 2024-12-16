import 'package:flutter/material.dart';
import './data_science_search/job_card_ds.dart';
import './navigation/pancake.dart';
import 'data_science_search/job_presenter_ds.dart';
import 'navigation/bottomNavBar.dart';

class JobSearchPageDS extends StatefulWidget {
  const JobSearchPageDS({super.key});

  @override
  State<JobSearchPageDS> createState() => _JobPageDSState();
}

class _JobPageDSState extends State<JobSearchPageDS> with TickerProviderStateMixin {
  late final TabController _tabController;
  late final TextEditingController _jobSearchController;
  bool isSearchClicked = false;
  String searchText = '';
  final JobPresenterDS jobPresenter = JobPresenterDS();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
    _jobSearchController = TextEditingController();
    jobPresenter.fetchJobs("", 20);
  }

  @override
  void dispose() {
    _tabController.dispose();
    _jobSearchController.dispose();
    super.dispose();
  }

  void _onSearchChanged(String s) {
    setState(() {
      searchText = s;
      searchJobs();
    });
  }

  void searchJobs() {
    jobPresenter.fetchJobs(searchText, 20);
  }

  Future<void> _showSalariesByJobPosition() async {
    // Fetching the salaries for job positions
    final salariesByJobPosition = await jobPresenter.getAverageSalariesByJobPosition();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Average Salaries by Job Position"),
          content: SizedBox(
            width: double.maxFinite,
            child: ListView(
              children: salariesByJobPosition.entries.map((entry) {
                return ListTile(
                  title: Text(entry.key),
                  subtitle: Text("Average Salary: \$${entry.value}"),
                  onTap: () async {
                    // Fetch jobs related to the selected position
                    var jobPositions = await jobPresenter.getJobsByPosition(entry.key);

                    // Navigating to a new screen with job details
                    Navigator.push(
                      context,
                      MaterialPageRoute<Widget>(
                        builder: (BuildContext context) {
                          return Scaffold(
                            appBar: AppBar(title: Text(entry.key)),
                            body: ListView.builder(
                              itemCount: jobPositions.length,
                              itemBuilder: (context, index) {
                                var job = jobPositions.entries.elementAt(index);
                                return ListTile(
                                  title: Text(job.key),
                                  subtitle: Text('Average Salary: \$${job.value}'),
                                  tileColor: Colors.blueAccent,
                                  onTap: () {
                                    Navigator.pop(context);
                                  },
                                );
                              },
                            ),
                          );
                        },
                      ),
                    );
                  },
                );
              }).toList(),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text("Close"),
            ),
          ],
        );
      },
    );
  }



  @override
  Widget build(BuildContext context) {
    // jobPresenter.fetchJobs("", 20);

    return Scaffold(
        appBar: AppBar(
          title: isSearchClicked ?
          Container(
            height: 40,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(5),
            ),
            child: TextField(
                controller: _jobSearchController,
                onChanged: _onSearchChanged,
                decoration: const InputDecoration(
                  contentPadding: EdgeInsets.fromLTRB(16,20,16,12),
                  hintStyle: TextStyle(color: Colors.grey),
                  hintText: 'Search',
                  border: InputBorder.none,)
            ),
          )
              : const Text('Data Science Jobs'),
          actions: [
            IconButton(
                onPressed: () {
                  setState(() {
                    isSearchClicked = !isSearchClicked;
                    if (!isSearchClicked) {
                      _jobSearchController.clear();
                      _onSearchChanged('');
                    }
                  });
                },
                icon: Icon(isSearchClicked ? Icons.close : Icons.search)
            ),
            IconButton(
              icon: const Icon(Icons.bar_chart),
              onPressed: _showSalariesByJobPosition,
            ),
            const PancakeMenuButton(),
          ],
          bottom: TabBar(
            splashFactory: NoSplash.splashFactory,
              // labelColor: Colors.black,
              // indicatorColor: Colors.black,
              // unselectedLabelColor: Colors.black45,
              controller: _tabController,
              tabs: const <Widget>[
                Tab(
                    text: 'In-person',
                    icon: Icon(Icons.apartment_sharp) // IN_PERSON
                ),
                Tab(
                    text: 'Hybrid',
                    icon: Icon(Icons.home_work_outlined) // HYBRID
                ),
                Tab(
                    text: 'Remote',
                    icon: Icon(Icons.home_outlined) // REMOTE
                ),
                Tab(
                    text: 'All',
                    icon: Icon(Icons.work_outline_sharp) // ALL
                )
              ]
          ),
        ),
        body: TabBarView(
            controller: _tabController,
            children: <Widget>[
              ListView.builder(
                padding: const EdgeInsets.all(16.0),

                itemCount: jobPresenter.getInPersonJobs().length,

                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 16.0),

                    // display jobs
                    child: JobCardDS(job: jobPresenter.getInPersonJobs()[index]),
                  );
                },
              ),
              ListView.builder(
                padding: const EdgeInsets.all(16.0),

                itemCount: jobPresenter.getHybridJobs().length,

                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 16.0),

                    // display jobs
                    child: JobCardDS(job: jobPresenter.getHybridJobs()[index]),
                  );
                },
              ),
              ListView.builder(
                padding: const EdgeInsets.all(16.0),

                itemCount: jobPresenter.getRemoteJobs().length,

                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 16.0),

                    // display jobs
                    child: JobCardDS(job: jobPresenter.getRemoteJobs()[index]),
                  );
                },
              ),
              ListView.builder(
                padding: const EdgeInsets.all(16.0),

                itemCount: jobPresenter.getSearchResults().length,

                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 16.0),

                    // display jobs
                    child: JobCardDS(job: jobPresenter.getSearchResults()[index]),
                  );
                },
              ),
            ]
        ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              offset: Offset(0, -2),
              blurRadius: 6,
              spreadRadius: 1,
            ),
          ],
        ),
        child: const WhiteBottomBar(page: 'jobSearchDS'),
      ),
    );
  }
}

