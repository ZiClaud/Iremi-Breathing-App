import 'package:flutter/cupertino.dart';

import '../utils/theme.dart';

/// Loading Screen
Widget defaultLogoWidget() {
  return const Center(
    child: Padding(
      padding: EdgeInsets.all(8.0),
      child: Image(
        image: AssetImage('assets/icon/icon.png'),
      ),
    ),
  );
}

Widget defaultLogoWidgetOutlined() {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: myInvisibleOrWhite(),
          width: 2.5,
        ),
      ),
      child: Image(
        image: AssetImage('assets/icon/icon.png'),
      ),
    ),
  );
}

/*
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
*/
