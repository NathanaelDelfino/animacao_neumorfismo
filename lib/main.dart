//Um estudo sobre como fazer objetos neumorficos em flutter
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
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
    return Scaffold(
      backgroundColor: customWhiteColor,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(widget.title),
      ),
      body: Center(
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
                  blurRadius: 30,
                  color: Colors.grey,
                  offset: (isClicked)
                      ? const Offset(20, -20)
                      : const Offset(20, 20),
                ),
                BoxShadow(
                  blurRadius: 30,
                  offset: (isClicked)
                      ? const Offset(-20, 20)
                      : const Offset(-20, -20),
                  color: Colors.white,
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
      )),
    );
  }
}
