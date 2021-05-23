import 'dart:js' as js;
import 'package:flutter/material.dart';

import '../github_icons_icons.dart';

class GithubButton extends StatelessWidget {
  final String link;
  const GithubButton({
    this.link,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton.icon(
      style: ButtonStyle(
        foregroundColor: MaterialStateProperty.resolveWith(
          (states) {
            const Set<MaterialState> interactiveStates = <MaterialState>{
              MaterialState.pressed,
              MaterialState.hovered,
              MaterialState.focused,
            };

            if (states.any(interactiveStates.contains)) {
              return Colors.black;
            }

            return Colors.white;
          },
        ),
      ),
      onPressed: () {
        js.context.callMethod(
            'open', ['https://github.com/Charly6596/turing-add-2-numbers']);
      },
      label: Text("Github"),
      icon: Icon(GithubIcons.mark_github),
    );
  }
}
