abstract class BooleanUtls {
  static bool fromInt(dynamic value) {
    if(value !is int?) {
      return false;
    } else if(value == 0) {
      return false;
    } else if(value == 1) {
      return true;
    }
    throw ArgumentError.value(value);
  }
}