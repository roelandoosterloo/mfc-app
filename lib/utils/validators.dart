class Validators {
  static final RegExp _emailRegExp = RegExp(r'.*'
      //r'^[a-zA-Z0-9.!#$%&’*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+(?:\.[a-zA-Z0-9-]+)*$',
      );
  static final RegExp _passwordRegExp = RegExp(r'.*'
      // r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{6,}$',
      );

  static isValidEmail(String email) {
    return _emailRegExp.hasMatch(email);
  }

  static isValidPassword(String password) {
    return _passwordRegExp.hasMatch(password);
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
}
