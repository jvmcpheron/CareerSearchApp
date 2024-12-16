import 'package:flutter/material.dart';
import '../alarms/alarmWidget.dart';
import '../main.dart';
import '../videoplayer/job_video_page.dart';

class WhiteBottomBar extends StatelessWidget {
  const WhiteBottomBar({super.key, required this.page});

  final String page;





  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      // color: Colors.white,
      shape: const CircularNotchedRectangle(),
      notchMargin: 8.0,
      height: 65,

      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          IconButton(
            icon: Icon(Icons.alarm, color: page =='alarmPage'
                ? Theme.of(context).colorScheme.primary
                : Theme.of(context).colorScheme.inverseSurface),
            onPressed: () {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => const InterviewAlarmHomeScreen()),
                    (Route<dynamic> route) => false,
              );


            },
          ),
          IconButton(
            icon: Icon(Icons.home, color: page =='home'
                ? Theme.of(context).colorScheme.primary
                : Theme.of(context).colorScheme.inverseSurface),
            onPressed: () {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => const MyHomePage()),
                    (Route<dynamic> route) => false,);

            },
          ),

          IconButton(
            icon: Icon(Icons.school, color: page =='learning'
                ? Theme.of(context).colorScheme.primary
                : Theme.of(context).colorScheme.inverseSurface),
            onPressed: () {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) =>  LearningPage()),
                    (Route<dynamic> route) => false,);

            },
          ),
        ],
      ),
    );
  }
}