extension EmailValidator on String {
  bool isValidEmail() {
    const p =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    final regExp = RegExp(p);

    return regExp.hasMatch(this);
  }
}

extension PasswordValidator on String {
  bool isValidPassword() {
    if (length > 6) {
      return true;
    }
    else 
    {
      return false;
    }
  }
}
