import 'package:add_machine/add_machine.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'components/config_info.dart';
import 'components/github_button.dart';
import 'components/machine_table.dart';
import 'components/num_input.dart';
import 'components/tap_bar.dart';
import 'components/txt.dart';
import 'machine_cubit.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (c) => SumCubit(machine: AddMachine()),
      child: MaterialApp(
        title: 'Turing machine sum',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          textButtonTheme: TextButtonThemeData(style: ButtonStyle()),
          primarySwatch: Colors.deepOrange,
          elevatedButtonTheme: ElevatedButtonThemeData(
              style: ButtonStyle(
            minimumSize: MaterialStateProperty.all(Size(50, 50)),
          )),
          accentColor: Colors.green,
          scaffoldBackgroundColor: Colors.white,
          appBarTheme: AppBarTheme(),
          textTheme: TextTheme(
            headline1: TextStyle(
              fontSize: 42,
              color: Colors.black,
            ),
            bodyText2: TextStyle(
              fontSize: 18,
            ),
          ),
        ),
        home: HomePage(),
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  HomePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      // appBar: _header(context),
      body: Stack(
        children: [
          _mainContent(),
          _footer(context),
          _topBar(),
        ],
      ),
    );
  }

  Align _footer(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        color: Theme.of(context).primaryColor,
        alignment: Alignment.center,
        height: 50,
        child: GithubButton(),
      ),
    );
  }

  Align _topBar() {
    return Align(
      alignment: Alignment.topCenter,
      child: TapeBar(),
    );
  }

  Widget _mainContent() {
    return SingleChildScrollView(
      child: LayoutBuilder(
        builder: (context, constraints) {
          var wideScreen = constraints.maxWidth > 1200;
          return Container(
            alignment: Alignment.topCenter,
            padding: wideScreen
                ? EdgeInsets.symmetric(horizontal: 70, vertical: 40)
                : EdgeInsets.symmetric(horizontal: 30, vertical: 40),
            child: ConstrainedBox(
              constraints: BoxConstraints(maxWidth: 800),
              child: Column(
                children: [
                  const SizedBox(height: 80),
                  H1("Turing machine sum"),
                  const SizedBox(height: 10),
                  RichText(
                    text: TextSpan(
                      text:
                          "This is a turing machine simulator that computes the sum of two natural numbers. " +
                              "We can represent each natural number ",
                      style: DefaultTextStyle.of(context).style,
                      children: [
                        TextSpan(
                          text: "n",
                          style: TextStyle(fontStyle: FontStyle.italic),
                        ),
                        TextSpan(text: ' with a string of length '),
                        TextSpan(
                          text: "n+1 ",
                          style: TextStyle(fontStyle: FontStyle.italic),
                        ),
                        TextSpan(
                          text:
                              "formed by ocurrences of the symbol | (the vertical bar), so we would have that ",
                        ),
                        TextSpan(
                          text: "0 = |, 1 = ||, ",
                          style: TextStyle(fontStyle: FontStyle.italic),
                        ),
                        TextSpan(text: " and so on.\n\n"),
                        TextSpan(
                            text:
                                " If we put the TM defined by the table below "),
                        TextSpan(
                          text: "after several strings ",
                          style: TextStyle(
                              fontStyle: FontStyle.italic,
                              fontWeight: FontWeight.bold),
                        ),
                        TextSpan(
                            text:
                                " we can compute the sum of the numbers.\n\n"),
                        TextSpan(
                            text:
                                "Let's try it, enter two numbers in the following fields and press the "),
                        TextSpan(
                          text: "play button: \n",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                  _renderInput(context),
                  RichText(
                    text: TextSpan(
                      text: "\nNotice that the ",
                      style: DefaultTextStyle.of(context).style,
                      children: [
                        TextSpan(
                          text: "tape ",
                          style: TextStyle(fontStyle: FontStyle.italic),
                        ),
                        TextSpan(
                            text: "at the top has been filled with symbols! "),
                        TextSpan(text: "You can now watch the execution "),
                        TextSpan(
                          text: "step by step ",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        TextSpan(
                            text:
                                "using the buttons at the top, or you can alternatively "),
                        TextSpan(
                          text: "scroll the tape horizontally ",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        TextSpan(text: "to explare its content.\n\n"),
                        TextSpan(
                          text:
                              "You can also watch the state of the different ",
                        ),
                        TextSpan(
                          text: "configurations ",
                          style: TextStyle(fontStyle: FontStyle.italic),
                        ),
                        TextSpan(
                            text:
                                " by looking at the table at the bottom. Have fun! \n\n"),
                      ],
                    ),
                  ),
                  _renderMachineConfig(),
                  const SizedBox(height: 50),
                  H1("Table"),
                  _renderMachineTable(),
                  const SizedBox(height: 100),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _renderInput(BuildContext context) {
    var cubit = context.watch<SumCubit>();
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Txt("Input", size: 28),
        // const SizedBox(width: 10),
        NumInput(
          width: 40,
          hint: "a",
          value: cubit.a,
          onChanged: (i) => cubit.onAChanged(i),
        ),
        const SizedBox(width: 10),
        Material(
          child: Txt(
            "+",
            size: 28,
          ),
        ),
        const SizedBox(width: 10),
        NumInput(
          width: 40,
          hint: "b",
          value: cubit.b,
          onChanged: (i) => context.read<SumCubit>().onBChanged(i),
        ),
        const SizedBox(width: 20),
        _playButton(context),
      ],
    );
  }

  Widget _playButton(BuildContext context) {
    return ElevatedButton(
      child: Icon(Icons.play_arrow),
      onPressed: () {
        context.read<SumCubit>().startNew();
        FocusScope.of(context).unfocus();
      },
    );
  }

  Widget _renderMachineTable() {
    return BlocBuilder<SumCubit, SumState>(
      builder: (context, state) {
        var table = context.read<SumCubit>().table;
        if (state is SumRunning) {
          return MachineTable(state.configuration, table);
        }
        return MachineTable(Configuration.empty, table);
      },
    );
  }

  Widget _renderMachineConfig() {
    return BlocBuilder<SumCubit, SumState>(
      builder: (context, state) {
        if (state is SumRunning) {
          return ConfigInfo(configuration: state.configuration);
        }

        return ConfigInfo(configuration: Configuration.empty);
      },
    );
  }
}
