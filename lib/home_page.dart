import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final randomColorProvider = Provider<Color>((ref) {
  final random = math.Random();
  return Color.fromRGBO(
    random.nextInt(256),
    random.nextInt(256),
    random.nextInt(256),
    1.0,
  );
});

final colorProvider = StateProvider<Color>((ref) => Colors.black38);
final containerSizeProvider = StateProvider<double>((ref) => 20);
//final containerHeightProvider = StateProvider<double>((ref) => 0.0);
final isSwitchOnProvider = StateProvider<bool>((ref) => false);
final backgroundProvider =
    StateProvider<Color>((ref) => const Color.fromARGB(255, 2, 55, 81));
final appBarColorProvider =
    StateProvider<Color>((ref) => const Color.fromARGB(255, 1, 25, 46));

class MyHomePage extends ConsumerWidget {
  MyHomePage({Key? key}) : super(key: key);
  final GlobalKey _containerKey = GlobalKey();
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final screenHeight = MediaQuery.of(context).size.height;

    // final color = ref.watch(colorProvider);
    final containerSize = ref.watch(containerSizeProvider);
    final isSwitchOn = ref.watch(isSwitchOnProvider);
    final backgroundColor = ref.watch(backgroundProvider);
    final appbarColor = ref.watch(appBarColorProvider);
    final containerColorProvider = StateProvider<Color>((ref) {
      return ref.watch(randomColorProvider);
    });
    // var containerHeight = ref.watch(containerHeightProvider);
    void updateContainer() {
      ref.read(containerSizeProvider.state).state = containerSize + 10;
    }

    void decreaseContainer() {
      if (containerSize > 10) {
        ref.read(containerSizeProvider.state).state = containerSize - 10;
      }
      // ref.read(containerSizeProvider.state).state = containerSize - 10;
    }

    void resetContainer() {
      ref.read(containerSizeProvider.state).state = 20;
    }

    isValueTrue(bool newValue) {
      //
      if (newValue == true) {
        ref.read(isSwitchOnProvider.state).state = true;
        ref.read(appBarColorProvider.state).state = Colors.lightGreen;
        ref.read(backgroundProvider.state).state = Colors.white38;
      }

      if (newValue == false) {
        ref.read(isSwitchOnProvider.state).state = false;
        ref.read(appBarColorProvider.state).state =
            const Color.fromARGB(255, 1, 25, 46);
        ref.read(backgroundProvider.state).state = Colors.black54;
      }
    }
    //refuse fonctionner:
    // if (containerSize < 20) {
    //   resetContainer();
    // }

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        title: Text("screenheight:$screenHeight,containerSize:$containerSize"),
        centerTitle: true,
        backgroundColor: appbarColor,
        actions: [
          Switch(
              value: isSwitchOn,
              onChanged: (newValue) {
                isValueTrue(newValue);
              })
        ],
      ),
      body: Center(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(30.0),
              child: AnimatedContainer(
                key: _containerKey,
                duration: const Duration(milliseconds: 250),
                color: ref.watch(containerColorProvider),
                height: containerSize,
                width: containerSize,
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
            )
          ],
        ),
      ),
    );
  }
}
