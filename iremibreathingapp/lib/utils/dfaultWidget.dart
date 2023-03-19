import 'package:flutter/material.dart';
import 'package:iremibreathingapp/utils/theme.dart';

AppBar defaultAppBar(String title) {
  return AppBar(
    title: Text(title),
    backgroundColor: myBluLight,
  );
}

class BallAnimation extends StatefulWidget {
  @override
  _BallAnimationState createState() => _BallAnimationState();
}

class _BallAnimationState extends State<BallAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(vsync: this, duration: Duration(seconds: 2));
    _animation = Tween<double>(begin: 0, end: 1).animate(_controller)
      ..addListener(() {
        setState(() {});
      })
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          _controller.reverse();
        } else if (status == AnimationStatus.dismissed) {
          _controller.forward();
        }
      });
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double ballSize = MediaQuery.of(context).size.width / 3;
    return Scaffold(
      body: Center(
        child: Stack(
          alignment: Alignment.center,
          children: [
            Container(
              width: ballSize,
              height: ballSize,
              decoration: BoxDecoration(
                color: myBluDark,
                shape: BoxShape.circle,
              ),
            ),
            Container(
              width: ballSize * _animation.value,
              height: ballSize * _animation.value,
              decoration: BoxDecoration(
                color: myBlu,
                shape: BoxShape.circle,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
