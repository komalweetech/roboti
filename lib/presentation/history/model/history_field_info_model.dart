class FieldInfo {
  final String id;
  final String input;

  const FieldInfo({
    required this.id,
    required this.input,
  });

  factory FieldInfo.fromJson(dynamic json) {
    return FieldInfo(
      id: json['field_id'],
      input: json['user_input'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "field_id": id,
      "user_input": input,
    };
  }

  @override
  String toString() {
    return "id; $id, input: $input";
  }
}
