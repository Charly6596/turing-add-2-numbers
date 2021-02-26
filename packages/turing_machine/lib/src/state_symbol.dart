class StateSymbol {
  final String symbol;
  final int state;

  const StateSymbol(this.state, this.symbol);

  @override
  bool operator ==(Object other) {
    if (other is StateSymbol) {
      return other.symbol == symbol && other.state == state;
    }
    return false;
  }

  @override
  int get hashCode {
    return symbol.hashCode + state.hashCode;
  }
}
