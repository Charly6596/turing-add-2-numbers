import 'package:flutter/material.dart';

class Cell extends StatelessWidget {
  const Cell({
    Key key,
    @required this.value,
    this.selected = false,
  }) : super(key: key);

  final String value;
  final bool selected;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: 50,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        border: Border(
          left: BorderSide(
            color: Theme.of(context).primaryColor,
            width: 2,
          ),
          top: BorderSide(
            color: Theme.of(context).primaryColor,
            width: 2,
          ),
          bottom: BorderSide(
            color: Theme.of(context).primaryColor,
            width: 2,
          ),
        ),
      ),
      child: Text(
        value,
        style: Theme.of(context).textTheme.headline6,
      ),
    );
  }
}
