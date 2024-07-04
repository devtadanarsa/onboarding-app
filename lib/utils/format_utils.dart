bool isNumeric(String str) {
  try {
    int.parse(str);
    return true;
  } on FormatException {
    return false;
  }
}
