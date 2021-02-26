import 'package:turing_machine/turing_machine.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

class SumCubit extends Cubit<SumState> {
  final SumMachine _machine;
  SumCubit({@required SumMachine machine})
      : _machine = machine,
        super(SumInitial());

  int a;
  int b;

  bool get hasNext => _machine.hasNext;
  bool get hasPrevious => _machine.hasPrevious;

  onAChanged(int i) {
    a = i;
  }

  onBChanged(int i) {
    b = i;
  }

  Iterable<MapEntry<StateSymbol, TableEntry>> get table =>
      _machine.table.entries;

  void startNew() {
    if (a == null || b == null) {
      emit(InputError());
      return;
    }

    _machine.initialize(a, b);
    emit(SumRunning(configuration: _machine.initialConfiguration));
  }

  void nextStep() {
    var s = state;
    if (s is SumRunning) {
      emit(SumRunning(configuration: _machine.next()));
    }
  }

  void previousStep() {
    var s = state;
    if (s is SumRunning) {
      emit(SumRunning(configuration: _machine.previous()));
    }
  }

  void stop() {
    _machine.reset();
    a = null;
    b = null;
    emit(SumInitial());
  }
}

abstract class SumState extends Equatable {
  const SumState();
}

class InputError extends SumState {
  const InputError();

  @override
  List<Object> get props => [];
}

class SumInitial extends SumState {
  const SumInitial();
  @override
  List<Object> get props => [];
}

class SumRunning extends SumState {
  final Configuration configuration;
  const SumRunning({this.configuration});

  @override
  List<Object> get props => [configuration];
}
