class StringUtils {
  static bool checkStringIsEmptyOrNull(String? text) {
    if (text == null) {
      return true;
    }
    if (text.trim().isEmpty) {
      return true;
    }
    return false;
  }
}
