import 'package:turing_machine/turing_machine.dart';
import 'package:flutter/material.dart';

class ConfigInfo extends StatelessWidget {
  final Configuration configuration;

  const ConfigInfo({Key key, this.configuration}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text("Configuration: ", style: Theme.of(context).textTheme.headline5),
        Text("Current index (z): ${configuration.index}"),
        Text("state (q): ${configuration.state}"),
        Text("Current symbol E(z): '${configuration.tape.read()}'"),
        Text("Last action: ${configuration.instruction}"),
        SizedBox(height: 10),
      ],
    );
  }
}
