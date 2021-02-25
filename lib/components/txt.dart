import 'package:flutter/material.dart';

class H1 extends StatelessWidget {
  final String text;

  const H1(this.text, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: Theme.of(context).textTheme.headline1,
    );
  }
}

class Txt extends StatelessWidget {
  final String content;
  final double size;
  const Txt(
    this.content, {
    Key key,
    this.size,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      content,
      style: TextStyle(fontSize: size),
    );
  }
}
