class UserModel {
  String email,
      fName,
      lName,
      password,
      confirmPassword,
      countryCode,
      countryName;

  UserModel({
    required this.confirmPassword,
    required this.fName,
    required this.lName,
    required this.email,
    required this.password,
    required this.countryCode,
    required this.countryName,
  });

  void update({
    String? fName,
    lName,
    email,
    password,
    confirmPassword,
    countryCode,
    countryName,
  }) {
    if (email != null) this.email = email;
    if (password != null) this.password = password;
    if (fName != null) this.fName = fName;
    if (lName != null) this.lName = lName;
    if (confirmPassword != null) this.confirmPassword = confirmPassword;
    if (countryCode != null) this.countryCode = countryCode;
    if (countryName != null) this.countryName = countryName;
  }

  factory UserModel.initialState() {
    return UserModel(
      confirmPassword: "",
      fName: "",
      lName: "",
      email: "",
      password: "",
      countryCode: "",
      countryName: "",
    );
  }
}
