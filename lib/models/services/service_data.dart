class Services {
  final String serviceName;
  final String description;
  final int amount;
  final int status;
  final DateTime dateTime;

  const Services(
      {required this.serviceName,
      required this.description,
      required this.amount,
      required this.dateTime, 
      required this.status});

  Services copy({
    String? serviceName,
    String? description,
    int? amount,
    int? status,
    DateTime? dateTime,
  }) =>
      Services(
        serviceName: serviceName ?? this.serviceName,
        description: description ?? this.description,
        amount: amount ?? this.amount, 
        status: status ?? this.status,
        dateTime: dateTime ?? this.dateTime,
      );

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Services &&
          runtimeType == other.runtimeType &&
          serviceName == other.serviceName &&
          description == other.description &&
          amount == other.amount &&
          status == other.status &&
          dateTime == other.dateTime;

  @override
  int get hashCode =>
      serviceName.hashCode ^
      description.hashCode ^
      amount.hashCode ^
      status.hashCode ^
      dateTime.hashCode;
}
