class SubscriptionModel {
  final String name;
  final String value;
  final String discount;

  SubscriptionModel({
    required this.discount,
    required this.name,
    required this.value,
  });

  factory SubscriptionModel.fromJson(Map<String, dynamic> json) {
    return SubscriptionModel(
      discount: json['discount'],
      name: json['name'],
      value: json['value'],
    );
  }
}
