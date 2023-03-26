import 'package:flutter/material.dart';
import 'package:iremibreathingapp/utils/theme.dart';

double defaultCircleSize() {
//  return getMinWindowSize(context) * 2 / 3;
  return 200;
}

TabBar defaultTopBar(controller){
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
    String label, String text, IconData icon, {TextEditingController? controller}) {
  return TextFormField(
    enabled: false,
    initialValue: text,
    decoration: InputDecoration(label: Text(label), icon: Icon(icon)),
    keyboardType: TextInputType.multiline,
    maxLines: null,
    controller: controller,
  );
}

InputDecorator defaultInputDecorator(String label, String text, IconData icon){
  return InputDecorator(
    decoration: InputDecoration(
      labelText: label,
      icon: Icon(icon),
    ),
    child: Text(text),
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
    style: TextStyle(color: myButtonTextColor),
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

Scaffold defaultLoadingScreen() {
  return const Scaffold(
    body: Center(
      child: Image(
        image: AssetImage('assets/icon/icon.png'),
      ),
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
