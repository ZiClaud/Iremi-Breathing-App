import 'package:flutter/material.dart';
import 'package:iremibreathingapp/utils/theme.dart';

TextFormField defaultShowTextFormField(
    String label, String text, IconData icon) {
  return TextFormField(
    enabled: false,
    initialValue: text,
    decoration: defaultInputDecoration(label, icon),
    keyboardType: TextInputType.multiline,
    maxLines: null,
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
    decoration: defaultInputDecoration(label, icon),
    keyboardType: TextInputType.multiline,
    maxLines: null,
  );
}

InputDecoration defaultInputDecoration(String label, IconData icon) {
  return InputDecoration(
    label: Text(label),
    prefixIcon: Icon(
      icon,
      color: myBluLightDark,
    ),
    border: InputBorder.none,
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
  return BorderSide(color: myBluLightDark, width: 1.5);
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

class defaultLoadingScreen2 extends StatefulWidget {
  @override
  _defaultLoadingScreen2State createState() => _defaultLoadingScreen2State();
}

class _defaultLoadingScreen2State extends State<defaultLoadingScreen2>
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
          child: Image(
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
