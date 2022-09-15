import 'dart:async';

import 'package:flutter/material.dart';

import 'item_bird.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  static double birdY = 0;
  double birdInitial = birdY;
  double height = 0;
  double time = 0;
  bool isStart = true;

  double barriersOne = 1;
  double barriersTwo = 2;
  double barriersThree = 3;

  double sumWidthOne = 1;
  double sumWidthTwo = 2;
  double sumWidthThree = 3;

  int count = 0;

  bool isCheckOne = true;
  bool isCheckTwo = false;
  bool isCheckThree = false;

  jump() {
    time = 0;
    birdInitial = birdY;
    setState(() {});
  }

  start() {
    isStart = true;
    Timer.periodic(const Duration(milliseconds: 20), (timer) {
      time += 0.05;
      height = -4.9 * time * time + 2.8 * time;
      birdY = birdInitial - height;
      barriersOne -= 0.02;
      barriersTwo -= 0.02;
      barriersThree -= 0.02;

      if (isCheckOne && barriersOne < 0) {
        count++;
        isCheckOne = false;
        isCheckTwo = true;
      }

      if (isCheckTwo && barriersTwo < 0) {
        count++;
        isCheckTwo = false;
        isCheckThree = true;
      }

      if (isCheckThree && barriersThree < 0) {
        count++;
        isCheckOne = true;
        isCheckThree = false;
      }

      if (barriersOne < -1.4 && barriersThree < 1) {
        barriersOne = barriersThree + 1;
      }
      if (barriersTwo < -1.4 && barriersOne < 1) {
        barriersTwo = barriersOne + 1;
      }
      if (barriersThree < -1.4 && barriersTwo < 1) {
        barriersThree = barriersTwo + 1;
      }

      if (birdY > 1) {
        // timer.cancel();
        birdY = 1;
        isStart = false;
      }

      setState(() {});
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    start();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () => isStart ? start() : jump(),
        child: Column(
          children: [
            Expanded(
              flex: 3,
              child: Stack(
                children: [
                  AnimatedContainer(
                    color: Colors.blue,
                    alignment: Alignment(0, birdY),
                    duration: const Duration(milliseconds: 0),
                    child: Container(
                      width: 50,
                      height: 50,
                      color: Colors.yellow,
                    ),
                  ),
                  ItemBird(positionX: barriersOne, positionY: 1, type: 1),
                  ItemBird(positionX: barriersOne, positionY: -1, type: 1),
                  ItemBird(positionX: barriersTwo, positionY: 1, type: 2),
                  ItemBird(positionX: barriersTwo, positionY: -1, type: 2),
                  ItemBird(positionX: barriersThree, positionY: 1, type: 3),
                  ItemBird(positionX: barriersThree, positionY: -1, type: 3),
                ],
              ),
            ),
            Expanded(
              flex: 1,
              child: Container(
                color: Colors.brown,
                alignment: Alignment.center,
                child: Text(
                  count.toString(),
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 30,
                      fontWeight: FontWeight.w700),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
