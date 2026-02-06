class Earnings {
  String riderId;
  double totalEarnings;
  double todayEarnings;

  Earnings({
    required this.riderId,
    required this.totalEarnings,
    required this.todayEarnings,
  });

  factory Earnings.fromMap(Map data) {
    return Earnings(
      riderId: data["riderId"],
      totalEarnings: double.parse(data["totalEarnings"].toString()),
      todayEarnings: double.parse(data["todayEarnings"].toString()),
    );
  }
}
