abstract class BooleanUtls {
  static bool fromInt(dynamic value) {

    if (value == 0 || value == '0') {
      return false;
    } else if (value == 1 || value == '1') {
      return true;
    }

    return false;
  }
}