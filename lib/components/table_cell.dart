import 'package:flutter/material.dart';

class TableCellText extends StatelessWidget {
  final Object text;
  final EdgeInsets padding;
  final TextStyle style;

  const TableCellText(
    this.text, {
    this.padding = const EdgeInsets.all(3),
    this.style,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      padding: padding,
      child: Text("$text", style: style),
    );
  }
}
