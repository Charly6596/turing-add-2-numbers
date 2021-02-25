import 'package:flutter/material.dart';

class NumInput extends StatefulWidget {
  final double width;
  final String hint;
  final int value;
  final Function(int) onChanged;
  final TextEditingController controller;

  NumInput({
    Key key,
    this.width,
    this.value,
    @required this.onChanged,
    @required this.hint,
  })  : controller =
            TextEditingController(text: value != null ? value.toString() : ""),
        super(key: key);

  @override
  _NumInputState createState() => _NumInputState();
}

class _NumInputState extends State<NumInput> {
  @override
  void dispose() {
    super.dispose();
    widget.controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width,
      child: TextField(
        onChanged: (s) {
          var n = int.tryParse(s);
          if (n != null && widget.onChanged != null) {
            widget.onChanged(n);
          } else if (s.isNotEmpty) {
            widget.controller.clear();
          }
        },
        controller: widget.controller,
        textAlign: TextAlign.center,
        textAlignVertical: TextAlignVertical.center,
        keyboardType: TextInputType.number,
        style: TextStyle(
          fontSize: 28,
        ),
        decoration: InputDecoration(
          contentPadding: EdgeInsets.zero,
          filled: true,
          hintText: widget.hint,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(12)),
          ),
        ),
      ),
    );
  }
}
