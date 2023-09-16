import 'package:flutter/material.dart' hide BoxDecoration, BoxShadow;
import 'package:flutter_inset_box_shadow/flutter_inset_box_shadow.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Neumorphic App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.white),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Neumorphic App'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin {
  double turns = 0.0;
  bool isClicked = false;
  late AnimationController _controller;
  var customBlackColor = const Color(0xFF2D2D2D);
  var customWhiteColor = const Color(0xFFE0E0E0);

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double blur = isClicked ? 5 : 30;
    Offset distance = isClicked ? Offset(10, 10) : Offset(28, 28);

    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(widget.title),
      ),
      body: Center(
          child: Container(
        margin: EdgeInsets.only(bottom: 90),
        child: AnimatedRotation(
          curve: Curves.easeOutExpo,
          duration: const Duration(seconds: 1),
          turns: turns,
          child: GestureDetector(
            onTap: () {
              if (isClicked) {
                setState(() => turns -= .25);
                _controller.reverse();
              } else {
                setState(() => turns += .25);
                _controller.forward();
              }
              isClicked = !isClicked;
            },
            child: AnimatedContainer(
              duration: const Duration(seconds: 1),
              curve: Curves.easeOutExpo,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25),
                color: customWhiteColor,
                boxShadow: [
                  BoxShadow(
                    inset: isClicked,
                    blurRadius: blur,
                    color: Colors.grey,
                    offset: (isClicked)
                        ? const Offset(10, -10)
                        : const Offset(28, 28),
                  ),
                  BoxShadow(
                    inset: isClicked,
                    blurRadius: blur,
                    offset: (isClicked)
                        ? const Offset(-10, 10)
                        : const Offset(-28, -28),
                    color: isClicked ? Color(0xffffff) : Colors.white,
                  ),
                ],
              ),
              child: SizedBox(
                width: 200,
                height: 200,
                child: Center(
                  child: AnimatedIcon(
                    icon: AnimatedIcons.menu_close,
                    progress: _controller,
                    color: customBlackColor,
                    size: 100,
                  ),
                ),
              ),
            ),
          ),
        ),
      )),
    );
  }
}
