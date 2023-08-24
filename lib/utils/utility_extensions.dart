extension CapitalizeExtension on String {
  /// Returns the string with the first character capitalized.
  String capitalize() {
    if (isEmpty) return this;
    return this[0].toUpperCase() + substring(1);
  }
}
