import 'dart:convert';

class SubscriptionRequestParser {
  String getUpdatePurchaseBody(String expiry, int type) {
    Map<String, dynamic> requestMap = {
      "plan_status": true,
      "expiry_date": expiry.toString(),
      "plan_type": type,
    };

    return jsonEncode(requestMap);
  }

  String getUpdateExpiryReqBody(String expiry) {
    Map<String, dynamic> requestMap = {"expiry_date": expiry};

    return jsonEncode(requestMap);
  }
}
