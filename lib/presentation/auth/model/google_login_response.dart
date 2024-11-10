class GoogleLoginResponse {
  String accessToken;
  String? idToken;
  String fullName;
  String email;

  GoogleLoginResponse({
    required this.accessToken,
    required this.idToken,
    required this.email,
    required this.fullName,
  });
}
