import 'package:flutter/material.dart';

class ItemBird extends StatelessWidget {
  final double positionY;
  final double positionX;
  final int type;

  const ItemBird(
      {Key? key,
      required this.positionY,
      required this.positionX,
      required this.type})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 0),
      alignment: Alignment(positionX, positionY),
      child: Container(
          color: Colors.green,
          width: 70,
          height: 200,
          alignment: Alignment.center,
          child: Text(
            type.toString(),
            style: const TextStyle(color: Colors.white),
          )),
    );
  }
}
