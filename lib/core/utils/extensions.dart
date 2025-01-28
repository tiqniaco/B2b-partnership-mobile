import 'dart:ui';

extension StringExtension on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${substring(1)}";
  }
}

extension ToHex on Color {
  String toHex({bool leadingHashSign = true}) {
    return '#${this.value.toRadixString(16).padLeft(8, '0').toUpperCase()}';
  }
}
