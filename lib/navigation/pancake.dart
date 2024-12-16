import 'package:final_project/alarms/alarmwidget.dart';
import 'package:flutter/material.dart';
import '../journal/journal_page.dart';
import '../main.dart';
import '../SearchPageSE.dart';
import '../search_page_ds.dart';
import '../videoplayer/job_video_page.dart';
import '../CreditPage.dart';
import '../Authentication/login.dart';
import 'package:final_project/sizesalarygraphs/graphingwidget.dart';

class PancakeMenuButton extends StatelessWidget {
  const PancakeMenuButton({super.key});

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
      onSelected: (value) {
        switch (value) {
          case 'Home':
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => const MyHomePage()), (Route<dynamic> route) => false,);
            break;

          case 'Software Engineering Jobs':
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) =>  JobPage()), (Route<dynamic> route) => false,);
            break;

          case 'Data Science Jobs':
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) =>  const JobSearchPageDS()), (Route<dynamic> route) => false,);
            break;


          case 'Journal':
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) =>  JournalPage()), (Route<dynamic> route) => false,);
            break;


          case 'Data Science Salaries':
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) =>   DistributionChartPage()), (Route<dynamic> route) => false,);
            break;

            case 'Career Learning':
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) =>  LearningPage()), (Route<dynamic> route) => false,);
            break;
            case 'Interview Alarms':
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) =>  InterviewAlarmHomeScreen()), (Route<dynamic> route) => false,);
            break;

            case 'Info':
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) =>  MyCreditPage()), (Route<dynamic> route) => false,);
            break;

            case 'Logout':
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) =>  AuthenticationPage()), (Route<dynamic> route) => false,);


        }
      },
      itemBuilder: (BuildContext context) {

        return {'Home', 'Software Engineering Jobs', 'Data Science Jobs', 'Journal', 'Career Learning', 'Interview Alarms','Data Science Salaries', 'Info', 'Logout'}.map((String choice) {

          return PopupMenuItem<String>(
            value: choice,
            child: Text(choice),
          );
        }).toList();
      },
      icon: const Icon(Icons.menu),
      // color: Colors.white,
    );
  }
}
