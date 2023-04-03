import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:iremibreathingapp/pages/progress_page.dart';
import 'package:iremibreathingapp/utils/theme.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../basics/exercise.dart';
import '../basics/exercise_history.dart';
import '../pages/main_page.dart';
import '../pages/user_page.dart';
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
                  exercise.name,
                  style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 4.0),
                Row(
                  children: [
                    Icon(Icons.timer, size: 16.0, color: myWhiteBlack()),
                    // TODO: Fix the color, of the icon it doesn't update on dark mode change
                    SizedBox(width: 4.0),
                    Text(
                      getTimeString(exercise),
                      style: TextStyle(fontSize: 14.0),
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

Widget showExerciseModelOld(MyExercise exercise) {
  /// Graphics
  // TODO: IMPROVE, MASSIVELY
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Text(exercise.name),
      Text(getTimeString(exercise)),
    ],
  );
}

BottomNavigationBar _getBottomNavigationBar(context, currentIndex) {
  BottomNavigationBarItem homePageItem = const BottomNavigationBarItem(
    icon: Icon(Icons.home),
    label: "Home",
  );

  BottomNavigationBarItem userPageItem = const BottomNavigationBarItem(
    icon: Icon(Icons.person),
    label: "Profile",
  );

  BottomNavigationBarItem progressPageItem = const BottomNavigationBarItem(
    icon: Icon(Icons.bar_chart),
    label: "Progress",
  );

  List<BottomNavigationBarItem> items = [
    progressPageItem,
    homePageItem,
    userPageItem,
  ];

  return BottomNavigationBar(
    items: items,
    currentIndex: currentIndex,
    onTap: (index) {
      if (index == 0 && currentIndex != 0) {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => ProgressPage()));
      } else if (index == 1 && currentIndex != 1) {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => MainPage()));
      } else if (index == 2 && currentIndex != 2) {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => UserPage()));
      }
    },
  );
}

TabBar defaultTopBar(controller) {
  return TabBar(
    controller: controller,
    tabs: const [
      Tab(text: 'Details'),
      Tab(text: 'Steps'),
    ],
    indicatorColor: myBluNeutral,
  );
}

TextFormField _defaultShowTextFormField2(
    String label, String text, IconData icon,
    {TextEditingController? controller}) {
  return TextFormField(
    enabled: false,
    initialValue: text,
    decoration: InputDecoration(label: Text(label), icon: Icon(icon)),
    keyboardType: TextInputType.multiline,
    maxLines: null,
    controller: controller,
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

Widget defaultBadgeView(String name, String date, IconData icon) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
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
          Text(name, style: defaultSmallButtonTextStyle()),
          Text(date, style: defaultSmallerButtonTextStyle()),
        ],
      ),
    ),
  );
}

Text defaultText(String message) {
  return Text(
    message,
    maxLines: null,
  );
}

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

Text defaultErrorText(String message) {
  return Text(
    message,
  );
}

TextFormField defaultEditTextFormField(String label, IconData icon) {
  return TextFormField(
    decoration: InputDecoration(label: Text(label), icon: Icon(icon)),
    keyboardType: TextInputType.multiline,
    maxLines: null,
  );
}

TextFormField defaultEditTextFormField2(String label, IconData icon,
    {required void Function(String?) onChanged}) {
  return TextFormField(
    decoration: InputDecoration(label: Text(label), icon: Icon(icon)),
    keyboardType: TextInputType.multiline,
    maxLines: null,
    onChanged: onChanged,
  );
}

TextFormField defaultEditTextFormField2Num(String label, IconData icon,
    {required void Function(String?) onChanged}) {
  return TextFormField(
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
    borderRadius: defaultBorderRadius(),
    side: defaultBorderSide(),
  );
}

BorderRadius defaultBorderRadius() {
  return BorderRadius.circular(10.0);
}

BorderSide defaultBorderSide() {
  return BorderSide(color: myBluLightDark(), width: 1.5);
}

Widget defaultExerciseHistoryWidget(List<ExerciseHistory> exerciseHistory) {
  // TODO: Fix bug -> Doesn't sum the time if you do more exercises in the same day
  return SfCartesianChart(
    title: ChartTitle(
        text: 'Exercise History', textStyle: getChartDefaultTextStyle()),
    series: <ChartSeries<ExerciseHistory, String>>[
      ColumnSeries<ExerciseHistory, String>(
          dataSource: exerciseHistory,
          xValueMapper: (ExerciseHistory sales, _) =>
              getItalianDateFormat(sales.dateTime),
          yValueMapper: (ExerciseHistory sales, _) =>
              sales.exerciseDurationSeconds,
          name: 'Exercise History',
          color: myBluLightDark(),
          dataLabelSettings: DataLabelSettings(isVisible: false))
    ],
    primaryXAxis: CategoryAxis(
        name: "Date",
        isVisible: true,
        majorGridLines: MajorGridLines(width: 0)),
    primaryYAxis: CategoryAxis(
        name: "Seconds",
        isVisible: true,
        majorGridLines: MajorGridLines(width: 0)),
  );
}

Widget defaultLoadingScreen() {
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
