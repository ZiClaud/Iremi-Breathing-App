import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:iremibreathingapp/pages/badge_info_page.dart';
import 'package:iremibreathingapp/utils/theme.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../basics/badge.dart';
import '../basics/exercise.dart';
import '../basics/exercise_history.dart';
import '../pages/home_page.dart';
import '../pages/settings_page.dart';
import 'my_utils.dart';

double defaultCircleSize() {
//  return getMinWindowSize(context) * 2 / 3;
  return 200;
}

Widget showExerciseModel(MyExercise exercise) {
  return Card(
    elevation: 2.0,
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  exercise.name(),
                  style: const TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4.0),
                Row(
                  children: [
                    Icon(Icons.timer, size: 16.0, color: myWhiteBlack()),
                    // TODO: Fix the color, of the icon it doesn't update on dark mode change
                    const SizedBox(width: 4.0),
                    Text(
                      getTimeString(exercise),
                      style: const TextStyle(fontSize: 14.0),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}

TabBar defaultExerciseTopBar(controller) {
  return TabBar(
    controller: controller,
    tabs: const [
      Tab(text: 'Details'),
      Tab(text: 'Steps'),
    ],
    indicatorColor: myBluNeutral,
  );
}

InputDecorator defaultInputDecorator(String label, String text, IconData icon) {
  return InputDecorator(
    decoration: InputDecoration(
      labelText: label,
      icon: Icon(icon),
    ),
    child: Text(text),
  );
}

/// Badge views
Widget defaultBadgeView(context, badge) {
  if (badge.date != "") {
    return defaultUnlockedBadgeView(context, badge);
  } else {
    return defaultLockedBadgeView(context, badge);
  }
}

void Function() _onTapViewBadge(BuildContext context, MyBadge badge) {
  return () {
    showBadgeDialog(context, badge);
  };
}

Widget defaultUnlockedBadgeView(context, MyBadge badge) {
  // TODO: Unite UnlockedView with LockedView in a single widget
  String name = badge.getBadge().badgeName;
  IconData icon = badge.getBadge().icon;
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: GestureDetector(
      onTap: _onTapViewBadge(context, badge),
      child: Container(
        width: 100,
        height: 100,
        decoration: BoxDecoration(
          color: myBluLightDark(),
          shape: BoxShape.circle,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 50,
              color: Colors.white,
            ),
            Text(name, style: defaultSmallButtonTextStyle(), maxLines: 2),
          ],
        ),
      ),
    ),
  );
}

Widget defaultLockedBadgeView(context, PossibleBadges badge) {
  // TODO: Unite UnlockedView with LockedView in a single widget
  String name = badge.badgeName;
  IconData icon = badge.icon;
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: GestureDetector(
      onTap: _onTapViewBadge(context, MyBadge(id: badge.id, date: "")),
      child: Container(
        width: 100,
        height: 100,
        decoration: const BoxDecoration(
          color: myLockedBadgeColor,
          shape: BoxShape.circle,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 50,
              color: Colors.white,
            ),
            Text(name, style: defaultSmallButtonTextStyle(), maxLines: 2),
          ],
        ),
      ),
    ),
  );
}

/// Buttons
Text defaultButtonText(String message) {
  return Text(
    message,
    maxLines: null,
    style: const TextStyle(color: myButtonTextColor),
  );
}

Icon defaultButtonIcon(IconData iconData) {
  return Icon(
    iconData,
    color: myButtonTextColor,
  );
}

Widget defaultOutlinedButton(BuildContext context, String message, IconData iconData,
    {required void Function() onPressed, void Function()? onLongPress}) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: OutlinedButton(
      onPressed: () => onPressed(),
      onLongPress: onLongPress,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          defaultButtonIcon(iconData),
          const Padding(padding: EdgeInsets.only(left: 4.0, right: 4.0)),
          defaultButtonText(message),
        ],
      ),
    ),
  );
}

TextFormField defaultEditTextFormField(String label, IconData icon, controller,
    {required void Function(String?) onChanged}) {
  return TextFormField(
    controller: controller,
    decoration: InputDecoration(label: Text(label), icon: Icon(icon)),
    keyboardType: TextInputType.multiline,
    maxLines: null,
    onChanged: onChanged,
  );
}

TextFormField defaultEditTextFormFieldNum(
    String label, IconData icon, controller,
    {required void Function(String?) onChanged}) {
  return TextFormField(
    controller: controller,
    decoration: InputDecoration(label: Text(label), icon: Icon(icon)),
    keyboardType: TextInputType.number,
    maxLines: null,
    onChanged: onChanged,
    inputFormatters: <TextInputFormatter>[
      FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
      FilteringTextInputFormatter.digitsOnly
    ],
  );
}

RoundedRectangleBorder defaultRoundedRectangleBorder() {
  return RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(10.0),
    side: BorderSide(color: myBluLightDark(), width: 1.5),
  );
}

/// CHART
Widget defaultExerciseHistoryWidget(List<ExerciseHistory> exerciseHistory) {
  return _defaultExerciseHistoryWidget(_filterExerciseHistory(exerciseHistory));
}

List<ExerciseHistory> _filterExerciseHistory(
    List<ExerciseHistory> exerciseHistory) {
  List<DateTime> dateTimes = []; // List of the dateTimes

  // Add the past 6 days + today
  for (int i = 0; i < 7; i++) {
    dateTimes.add(DateTime.now().subtract(Duration(days: i)));
  }

  List<ExerciseHistory> exerciseHistoryFiltered = [];

  for (DateTime dateTime in dateTimes) {
    exerciseHistoryFiltered
        .add(_sumDurationExerciseHistoryThisDay(exerciseHistory, dateTime));
  }

  exerciseHistoryFiltered.sort((a, b) => a.dateTime.compareTo(b.dateTime));

  return exerciseHistoryFiltered;
}

ExerciseHistory _sumDurationExerciseHistoryThisDay(
    List<ExerciseHistory> exerciseHistory, DateTime dateTime) {
  int sumDuration = 0;
  for (ExerciseHistory eh in exerciseHistory) {
    if (eh.dateTime.day == dateTime.day &&
        eh.dateTime.month == dateTime.month &&
        eh.dateTime.year == dateTime.year) {
      sumDuration += eh.exerciseDurationSeconds;
    }
  }
  return ExerciseHistory(
      exerciseDurationSeconds: sumDuration, dateTime: dateTime);
}

Widget _defaultExerciseHistoryWidget(List<ExerciseHistory> exerciseHistory) {
  return SfCartesianChart(
    series: <ChartSeries<ExerciseHistory, String>>[
      ColumnSeries<ExerciseHistory, String>(
          dataSource: exerciseHistory,
          xValueMapper: (ExerciseHistory sales, _) =>
              getWeekLetter(sales.dateTime),
          yValueMapper: (ExerciseHistory sales, _) =>
              sales.exerciseDurationSeconds,
          name: 'Exercise History',
          color: myBluLightDark(),
          dataLabelSettings: const DataLabelSettings(isVisible: false))
    ],
    primaryXAxis: CategoryAxis(
        name: "Date",
        isVisible: true,
        majorGridLines: const MajorGridLines(width: 0)),
    primaryYAxis: CategoryAxis(
        name: "Seconds",
        isVisible: true,
        majorGridLines: const MajorGridLines(width: 0)),
  );
}

/// Loading Screen
Widget defaultLogoWidget() {
  return const Center(
    child: Image(
      image: AssetImage('assets/icon/icon.png'),
    ),
  );
}

class DefaultLoadingScreen2 extends StatefulWidget {
  const DefaultLoadingScreen2({super.key});

  @override
  _DefaultLoadingScreen2State createState() => _DefaultLoadingScreen2State();
}

class _DefaultLoadingScreen2State extends State<DefaultLoadingScreen2>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _opacityAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    )..repeat(reverse: true);
    _opacityAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: FadeTransition(
          opacity: _opacityAnimation,
          child: const Image(
            image: AssetImage('assets/icon/icon.png'),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

/// Drawer
Widget defaultDrawer(context) {
  return Drawer(
    child: Column(
      children: <Widget>[
        DrawerHeader(
          decoration: const BoxDecoration(
            color: myBluNeutral,
          ),
          child: defaultLogoWidget(),
        ),
        ListTile(
          title: Row(
            children: [
              Icon(Icons.home, color: myWhiteBlack()),
              const Padding(padding: EdgeInsets.only(right: 10.0)),
              const Text('Home'),
            ],
          ),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => HomePage()),
            );
          },
        ),
        ListTile(
          title: Row(
            children: [
              Icon(Icons.settings, color: myWhiteBlack()),
              const Padding(padding: EdgeInsets.only(right: 10.0)),
              const Text('Settings'),
            ],
          ),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const SettingsPage()),
            );
          },
        ),
        const Spacer(),
        ListTile(
          title: Row(
            children: [
              Icon(Icons.star, color: myWhiteBlack()),
              const Padding(padding: EdgeInsets.only(right: 10.0)),
              const Text('Rate the App'),
            ],
          ),
          onTap: () {
            // TODO: Add link to rate the app
            Achievement.addAchievement(PossibleBadges.rater, context);
          },
        ),
        ListTile(
          title: Row(
            children: [
              Icon(Icons.share, color: myWhiteBlack()),
              const Padding(padding: EdgeInsets.only(right: 10.0)),
              const Text('Share'),
            ],
          ),
          onTap: () {
            // TODO: Add link to share the app
            Achievement.addAchievement(PossibleBadges.sharingIsCaring, context);
          },
        ),
        ListTile(
          title: Row(
            children: [
              Icon(Icons.attach_money, color: myWhiteBlack()),
              const Padding(padding: EdgeInsets.only(right: 10.0)),
              const Text('Support the Dev'),
            ],
          ),
          onTap: () {
            // TODO: Add link to support the developer
            Achievement.addAchievement(PossibleBadges.supporter, context);
          },
        ),
      ],
    ),
  );
}
