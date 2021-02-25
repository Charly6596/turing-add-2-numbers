import 'package:flutter/material.dart';
import 'package:infinite_tape/infinite_tape.dart';

import 'cell.dart';

class TapeView extends StatelessWidget {
  final ScrollController controller;
  final Tape tape;
  final int offsetLeft;
  final int offsetRight;
  final double head;

  const TapeView({
    Key key,
    @required this.controller,
    @required this.offsetLeft,
    @required this.offsetRight,
    @required this.tape,
    this.head,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          height: 50,
          child: PageView.builder(
            controller: controller,
            scrollDirection: Axis.horizontal,
            itemCount: tape.toList().length + offsetLeft + offsetRight,
            itemBuilder: (context, i) {
              var index = tape.absoluteToRelative(i - offsetLeft);
              var isSelected = tape.isHead(i - offsetLeft);
              return Cell(
                value: tape.readAt(index),
                selected: isSelected,
              );
            },
          ),
        ),
        Positioned(
          left: head - 31.5,
          top: -7.5,
          child: Column(
            children: [
              Container(
                height: 65,
                width: 65,
                decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor.withOpacity(0.3),
                    border: Border.all(
                      color: Theme.of(context).primaryColor,
                    )),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
