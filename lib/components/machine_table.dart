import 'package:turing_machine/turing_machine.dart';
import 'package:flutter/material.dart';
import 'package:turing_add/components/table_cell.dart';

class MachineTable extends StatelessWidget {
  final Configuration configuration;
  final Iterable<MapEntry<StateSymbol, TableEntry>> table;
  const MachineTable(
    this.configuration,
    this.table, {
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var headerStyle = Theme.of(context)
        .textTheme
        .bodyText2
        .copyWith(fontWeight: FontWeight.w600);
    return Table(children: [
      TableRow(
        children: [
          TableCellText("q", style: headerStyle),
          TableCellText("E(z)", style: headerStyle),
          TableCellText("γ", style: headerStyle),
          TableCellText("δ", style: headerStyle),
        ],
      ),
      ...table.map((e) {
        return TableRow(
          decoration: BoxDecoration(
            color: configuration.stateSymbol == e.key
                ? configuration.isTerminal
                    ? Theme.of(context).accentColor.withOpacity(0.30)
                    : Theme.of(context).primaryColor.withOpacity(0.30)
                : Colors.transparent,
          ),
          children: [
            TableCellText(e.key.state),
            TableCellText("'${e.key.symbol}'"),
            TableCellText(e.value.instruction),
            TableCellText(e.value.nextState),
          ],
        );
      }).toList(),
    ]);
  }
}
