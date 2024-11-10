extension NameExtensions on String {
  String capitalizeFirst() {
    if (isEmpty) {
      return this;
    } else if (length == 1) {
      return toUpperCase();
    }
    return this[0].toUpperCase() + substring(1);
  }

  String subStringIfExist(int len) {
    if (length > len) {
      return "${substring(0, len)}...";
    }
    return this;
  }
}
