class FieldOption {
  final String text;
  final String value;
  final String arabicText;

  const FieldOption({
    required this.text,
    required this.value,
    required this.arabicText,
  });

  factory FieldOption.fromJson(Map<String, dynamic> json) {
    return FieldOption(
      text: json['text'],
      value: json['value'],
      arabicText: json['arabicText'].toString(),
    );
  }
}
