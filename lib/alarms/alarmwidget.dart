import 'dart:async';

import 'package:alarm/alarm.dart';
import 'package:final_project/alarms/screens/edit_alarm.dart';
import 'package:final_project/alarms/screens/ring.dart';
import 'package:final_project/alarms/screens/shortcut_button.dart';
import 'package:final_project/alarms/permissions.dart';
import 'package:final_project/alarms/screens/tile.dart';
import 'package:flutter/material.dart';
//import 'package:url_launcher/url_launcher.dart';
import 'package:final_project/navigation/pancake.dart';

import '../navigation/bottomNavBar.dart';


class InterviewAlarmHomeScreen extends StatefulWidget {
  const InterviewAlarmHomeScreen({super.key});

  @override
  State<InterviewAlarmHomeScreen> createState() => _InterviewAlarmHomeScreenState();
}

class _InterviewAlarmHomeScreenState extends State<InterviewAlarmHomeScreen> {
  List<AlarmSettings> alarms = [];

  static StreamSubscription<AlarmSettings>? ringSubscription;
  static StreamSubscription<int>? updateSubscription;

  @override
  void initState() {
    super.initState();
    AlarmPermissions.checkNotificationPermission();
    if (Alarm.android) {
      AlarmPermissions.checkAndroidScheduleExactAlarmPermission();
    }
    unawaited(loadAlarms());
    ringSubscription ??= Alarm.ringStream.stream.listen(navigateToRingScreen);
    updateSubscription ??= Alarm.updateStream.stream.listen((_) {
      unawaited(loadAlarms());
    });
  }

  Future<void> loadAlarms() async {
    final updatedAlarms = await Alarm.getAlarms();
    updatedAlarms.sort((a, b) => a.dateTime.isBefore(b.dateTime) ? 0 : 1);
    setState(() {
      alarms = updatedAlarms;
    });
  }

  Future<void> navigateToRingScreen(AlarmSettings alarmSettings) async {
    await Navigator.push(
      context,
      MaterialPageRoute<void>(
        builder: (context) =>
            AlarmRingScreen(alarmSettings: alarmSettings),
      ),
    );
    unawaited(loadAlarms());
  }

  Future<void> navigateToAlarmScreen(AlarmSettings? settings) async {
    final res = await showModalBottomSheet<bool?>(
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      builder: (context) {
        return FractionallySizedBox(
          heightFactor: 0.75,
          child: AlarmEditScreen(alarmSettings: settings),
        );
      },
    );

    if (res != null && res == true) unawaited(loadAlarms());
  }

  ///Future<void> launchReadmeUrl() async { this is the source of this code
   // final url = Uri.parse('https://pub.dev/packages/alarm/versions/$version');
   // await launchUrl(url);
 // }

  @override
  void dispose() {
    ringSubscription?.cancel();
    updateSubscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Interview Alarms'),
        // backgroundColor: Colors.blueAccent,
        actions: [
          PancakeMenuButton(),  // Add PancakeMenuButton here
         // IconButton(
           // icon: const Icon(Icons.menu_book_rounded,color: Colors.white),
            //onPressed: launchReadmeUrl,
          //),
        ],
      ),
      body: SafeArea(
        child: alarms.isNotEmpty
            ? ListView.separated(
          itemCount: alarms.length,
          separatorBuilder: (context, index) => const Divider(height: 1),
          itemBuilder: (context, index) {
            return AlarmTile(
              key: Key(alarms[index].id.toString()),
              title: TimeOfDay(
                hour: alarms[index].dateTime.hour,
                minute: alarms[index].dateTime.minute,
              ).format(context),
              onPressed: () => navigateToAlarmScreen(alarms[index]),
              onDismissed: () {
                Alarm.stop(alarms[index].id).then((_) => loadAlarms());
              },
            );
          },
        )
            : Center(
          child: Text(
            'No alarms set',
            style: Theme.of(context).textTheme.titleMedium,
          ),
        ),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            AlarmHomeShortcutButton(refreshAlarms: loadAlarms),
            FloatingActionButton(
              onPressed: () => navigateToAlarmScreen(null),
              child: const Icon(Icons.alarm_add_rounded, size: 33),
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,

      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              offset: const Offset(0, -2),
              blurRadius: 6,
              spreadRadius: 1,
            ),
          ],
        ),
        child: const WhiteBottomBar(page: 'alarmPage'),
      ),
    );
  }
}