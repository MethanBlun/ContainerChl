import 'dart:math' as math;
import 'package:flutter/material.dart';

class MyHomepage extends StatefulWidget {
  const MyHomepage({super.key});

  @override
  State<MyHomepage> createState() => _MyHomepageState();
}

class _MyHomepageState extends State<MyHomepage> {
  double size = 20;
  double containerHeight = 0.0;
  bool isSwitchOn = false;
  //0bool isSwitchOff = true;
  Color backgroundColor = const Color.fromARGB(255, 2, 55, 81);
  Color containerRestcolor = const Color.fromARGB(255, 235, 238, 241);
  Color appbarColor = const Color.fromARGB(255, 1, 25, 46);
  Color rndColors = const Color.fromARGB(255, 235, 238, 241);

  late Size screenSize;
  late double screenWidth;
  late double screenHeight;

  @override
  void initState() {
    super.initState();
  }

  void resetContainer() {
    setState(() {
      size = 10;
      //rndColors = Colors.black;
      rndColors = containerRestcolor;
    });
  }

  void updateContainer() {
    setState(() {
      size = size + 28;
      rndColors = Color((math.Random().nextDouble() * 0xFFFFFF).toInt())
          .withOpacity(1.0);
    });
  }

  void decreaseContainer() {
    setState(() {
      size = size - 8;
      rndColors = Color((math.Random().nextDouble() * 0xFFFFFF).toInt())
          .withOpacity(1.0);
    });
  }

  final GlobalKey _containerKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    RenderBox? containerRenderBox =
        _containerKey.currentContext?.findRenderObject() as RenderBox?;
    if (containerRenderBox != null) {
      //    double containerWidth = containerRenderBox.size.width;
      containerHeight = containerRenderBox.size.height;
    } else {
      //rien a ameliorer
      Null;
    }

    // Accédez au contexte ici et obtenez la taille de l'écran.
    screenSize = MediaQuery.of(context).size;
    screenWidth = screenSize.width;
    screenHeight = screenSize.height;
    var screenHeightNdiaxass = screenHeight - 160;
    if (containerHeight >= screenHeightNdiaxass) {
      resetContainer();
    }
    if (containerHeight < 10) {
      resetContainer();
    }

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        title:
            Text("screenheight:$screenHeight,containerheight:$containerHeight"),
        centerTitle: true,
        backgroundColor: appbarColor,
        actions: [
          Switch(
              value: isSwitchOn,
              onChanged: (newValue) {
                setState(() {
                  isSwitchOn = newValue;
                  if (newValue == true) {
                    appbarColor = const Color.fromARGB(255, 1, 25, 46);
                    containerRestcolor =
                        const Color.fromARGB(255, 235, 238, 241);
                    backgroundColor = const Color.fromARGB(255, 2, 55, 81);
                    rndColors = const Color.fromARGB(255, 235, 238, 241);
                  }
                  if (newValue == false) {
                    appbarColor = Colors.white24;
                    backgroundColor = const Color.fromRGBO(236, 240, 241, 11);
                    containerRestcolor = const Color.fromARGB(174, 0, 0, 0);
                  }
                });
              }),
        ],
      ),
      body: Center(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(30.0),
              child: AnimatedContainer(
                key: _containerKey,
                height: size,
                width: size,
                color: rndColors,
                duration: const Duration(milliseconds: 200),
              ),
            ),
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton.icon(
                  onPressed: updateContainer,
                  icon: const Icon(Icons.add),
                  label: const Text('add'),
                ),
                ElevatedButton.icon(
                  onPressed: decreaseContainer,
                  icon: const Icon(Icons.remove),
                  label: const Text('minus'),
                ),
                const SizedBox(
                  width: 100,
                ),
                ElevatedButton.icon(
                  onPressed: resetContainer,
                  icon: const Icon(Icons.refresh),
                  label: const Text('reset'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
