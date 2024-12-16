import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './navigation/pancake.dart';
import 'package:firebase_core/firebase_core.dart';
import 'app_themes.dart';
import 'Authentication/login.dart'; // Import your login page
import './navigation/bottomNavBar.dart';
import 'package:alarm/alarm.dart';
import 'package:final_project/alarms/alarmwidget.dart';
import 'SearchPageSE.dart';
import 'search_page_ds.dart';
import './journal/journal_page.dart';
import './videoplayer/job_video_page.dart';
import './CreditPage.dart';
import 'package:final_project/sizesalarygraphs/graphingwidget.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await Alarm.init();
  runApp(
      ChangeNotifierProvider(
        create: (_) => ThemeNotifier(),
        child: MyApp(),
      ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeNotifier>(
      builder: (context, themeNotifier, child) {
        return MaterialApp(
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(
                seedColor: AppColors.blue,
                primary: AppColors.blue,
                brightness: Brightness.light),
            useMaterial3: true,
          ),
          darkTheme: ThemeData(
            colorScheme: ColorScheme.fromSeed(
                seedColor: AppColors.blue,
                primary: AppColors.blue,
                brightness: Brightness.dark),
            useMaterial3: true,
          ),
          themeMode: themeNotifier.getThemeMode,
          title: 'Pancake Menu Demo',
          home: AuthenticationPage(), // Set AuthenticationPage as the initial page
        );
      },
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final ButtonStyle buttonStyle = ElevatedButton.styleFrom(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
        side: BorderSide(color: Theme.of(context).colorScheme.primary, width: 5.0),
      ),
    );

    final TextStyle textStyle = const TextStyle(fontSize: 18);
    final double iconSize = 50;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        foregroundColor: Theme.of(context).colorScheme.primary,
        title: const Text(
          'Home',
          style: TextStyle(fontSize: 40),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.brightness_4_outlined),
            onPressed: () {
              ThemeNotifier themeNotifier = Provider.of<ThemeNotifier>(context, listen: false);
              if (themeNotifier.getThemeMode == ThemeMode.light) {
                themeNotifier.setTheme(ThemeMode.dark);
              } else {
                themeNotifier.setTheme(ThemeMode.light);
              }
            },
          ),
          const PancakeMenuButton(),
        ],
        // backgroundColor: Colors.blueAccent,
        // iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: GridView.count(
        primary: false,
        padding: const EdgeInsets.all(15),
        crossAxisSpacing: 15,
        mainAxisSpacing: 15,
        crossAxisCount: 2,
        children: <Widget>[
          ElevatedButton(
            onPressed: () {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => const InterviewAlarmHomeScreen()),
                    (Route<dynamic> route) => false,
              );
            },
            style: buttonStyle,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Icon(Icons.lock_clock, size: iconSize),
                Text("Alarms", style: textStyle),
              ],
            ),
          ),

          ElevatedButton(
            onPressed: () {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => const JobSearchPageDS()),
                    (Route<dynamic> route) => false,
              );
            },
            style: buttonStyle,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Icon(Icons.analytics, size: iconSize),
                Text("Data Jobs", style: textStyle),
              ],
            ),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => const JournalPage()),
                      (Route<dynamic> route) => false);
            },
            style: buttonStyle,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Icon(Icons.book, size: iconSize),
                Text("Job Journal", style: textStyle),
              ],
            ),
          ),

          ElevatedButton(
            onPressed: () {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => const JobPage()),
                    (Route<dynamic> route) => false,
              );
            },
            style: buttonStyle,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Icon(Icons.laptop, size: iconSize),
                Text("Software Jobs", style: textStyle),
              ],
            ),
          ),


          ElevatedButton(
            onPressed: () {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => const DistributionChartPage()),
                    (Route<dynamic> route) => false,
              );
            },
            style: buttonStyle,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Icon(Icons.bar_chart, size: iconSize),
                Text("Salary Graphs", style: textStyle),
              ],
            ),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) =>  LearningPage()),
                  (Route<dynamic> route) => false,
              );
            },
            style: buttonStyle,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Icon(Icons.school, size: iconSize),
                Text("Career Learning", style: textStyle),
              ],
            ),
          ),

          // ElevatedButton(
          //   onPressed: () {
          //     Navigator.pushAndRemoveUntil(
          //       context,
          //       MaterialPageRoute(builder: (context) => const MyCreditPage()),
          //           (Route<dynamic> route) => false,
          //     );
          //   },
          //   style: ElevatedButton.styleFrom(
          //     backgroundColor: Colors.blueAccent,
          //     foregroundColor: Colors.white,
          //     shape: RoundedRectangleBorder(
          //       borderRadius: BorderRadius.circular(10),
          //     ),
          //     padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
          //   ),
          //   child: const Column(
          //     mainAxisAlignment: MainAxisAlignment.center,
          //     children: <Widget>[
          //       Icon(Icons.info, size: 50),
          //       Text(
          //         "Info",
          //         style: TextStyle(fontSize: 18),
          //         textAlign: TextAlign.center,
          //       ),
          //     ],
          //   ),
          // ),
          //
          //
          //
          // ElevatedButton.icon(
          //   onPressed: () {
          //     Navigator.pushAndRemoveUntil(
          //       context,
          //       MaterialPageRoute(builder: (context) => AuthenticationPage()),
          //           (Route<dynamic> route) => false,
          //     );
          //   },
          //   style: ElevatedButton.styleFrom(
          //     backgroundColor: Colors.redAccent,
          //     foregroundColor: Colors.white,
          //     shape: RoundedRectangleBorder(
          //       borderRadius: BorderRadius.circular(10),
          //     ),
          //     padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 30),
          //   ),
          //   icon: const Icon(Icons.logout),
          //   label: const Text(
          //     "Logout",
          //     style: TextStyle(fontSize: 18),
          //   ),
          // ),

        ],
      ),
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
        child: const WhiteBottomBar(page: 'home'),
      ),
    );
  }
}

class ThemeNotifier with ChangeNotifier{
  ThemeMode _themeMode = ThemeMode.system;
  ThemeMode get getThemeMode => _themeMode;

  void setTheme(ThemeMode themeMode) {
    _themeMode = themeMode;
    notifyListeners();
  }
}