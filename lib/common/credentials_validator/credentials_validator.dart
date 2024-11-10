class CredentialsValidator {
  bool validateEmail(String email) {
    RegExp emailRegex = RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9-]+\.[a-zA-Z]+",
    );

    if (emailRegex.hasMatch(email)) {
      return true;
    }

    return false;
  }

  bool validatePassword(String password) {
    return password.length >= 8;
  }
}
