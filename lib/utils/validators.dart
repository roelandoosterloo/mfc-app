class Validators {
  static final RegExp _emailRegExp = RegExp(
    r'^[a-zA-Z0-9.!#$%&’*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+(?:\.[a-zA-Z0-9-]+)*$',
  );
  static final RegExp _passwordRegExp = RegExp(
    r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$',
  );

  static isNotEmpty(String value) {
    return value.isNotEmpty;
  }

  static isValidEmail(String email) {
    return _emailRegExp.hasMatch(email);
  }

  static isValidPassword(String password) {
    return _passwordRegExp.hasMatch(password);
  }

  static isNumberOfCharacters({
    double? lower,
    double? upper,
    required String value,
  }) {
    if (lower != null && value.length < lower) return false;
    if (upper != null && value.length > upper) return false;
    return true;
  }

  static isNumberInRange({
    double? lower,
    double? upper,
    required double value,
  }) {
    if (lower != null && value < lower) {
      return false;
    }
    if (upper != null && value > upper) {
      return false;
    }
    return true;
  }

  static isDateInRange({
    DateTime? lower,
    DateTime? upper,
    required DateTime value,
  }) {
    if (lower != null && value.isBefore(lower)) {
      return false;
    }
    if (upper != null && value.isAfter(upper)) {
      return false;
    }
    return true;
  }
}
