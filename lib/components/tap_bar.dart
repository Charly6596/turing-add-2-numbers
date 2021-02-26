import 'package:turing_machine/turing_machine.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../machine_cubit.dart';
import 'tape_view.dart';

class TapeBar extends StatefulWidget {
  const TapeBar({
    Key key,
  }) : super(key: key);

  @override
  _TapeBarState createState() => _TapeBarState();
}

class _TapeBarState extends State<TapeBar> {
  PageController controller;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    var width = MediaQuery.of(context).size.width;
    var fraction = 50 / width;
    controller = PageController(
      viewportFraction: fraction,
      initialPage: (width / 100).ceil(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      key: widget.key,
      color: Colors.transparent,
      elevation: 0,
      child: BlocConsumer<SumCubit, SumState>(
        listener: (context, state) {
          if (state is InputError) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              backgroundColor: Colors.red,
              content: Text(
                "The input must be numeric and not empty",
                style: TextStyle(color: Colors.white),
              ),
            ));
          } else if (state is SumRunning && controller.hasClients) {
            controller.animateToPage(
              (state.configuration.tape.absoluteIndex + 40),
              duration: Duration(milliseconds: 200),
              curve: Curves.linear,
            );
          }
        },
        builder: (context, state) {
          if (state is SumRunning) {
            return _body(state.configuration);
          }
          return _body(Configuration.empty);
        },
      ),
    );
  }

  Column _body(Configuration configuration) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          color: Colors.white,
          child: TapeView(
            controller: controller,
            head: (MediaQuery.of(context).size.width / 2),
            tape: configuration.tape,
            offsetLeft: 40,
            offsetRight: 45,
          ),
        ),
        SizedBox(height: 15),
        _runningButtons(),
      ],
    );
  }

  Widget _runningButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _stopButton(),
        const SizedBox(width: 20),
        _previousButton(),
        const SizedBox(width: 20),
        _nextButton(),
      ],
    );
  }

  Widget _previousButton() {
    return Material(
      child: ElevatedButton(
        onPressed: context.read<SumCubit>().hasPrevious
            ? () {
                context.read<SumCubit>().previousStep();
              }
            : null,
        child: Icon(Icons.skip_previous),
      ),
    );
  }

  Widget _nextButton() {
    return Material(
      child: ElevatedButton(
        onPressed: context.read<SumCubit>().hasNext
            ? () {
                context.read<SumCubit>().nextStep();
              }
            : null,
        child: Icon(Icons.skip_next),
      ),
    );
  }

  Material _stopButton() {
    return Material(
      child: ElevatedButton(
        onPressed: () {
          context.read<SumCubit>().stop();
        },
        child: Icon(Icons.stop),
      ),
    );
  }
}
