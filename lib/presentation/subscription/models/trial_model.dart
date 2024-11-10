class TrialModel {
  int trialLimit;
  bool isPlanActive;
  bool isFreeUser;

  TrialModel({
    required this.isPlanActive,
    required this.trialLimit,
    required this.isFreeUser,
  });

  @override
  String toString() {
    return "trialLimit $trialLimit, isPlanActive $isPlanActive, isFreeUser: $isFreeUser";
  }
}
