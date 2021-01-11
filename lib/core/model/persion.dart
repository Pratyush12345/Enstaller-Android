class PaymentList {
  PaymentList(this.payments);

  List<Payment> payments;

  Map<String, dynamic> toJson() => <String, dynamic>{
    'payment_slips': payments,
  };
}

class Payment {
  Payment({this.name, this.personalId});

  String name;
  String personalId;

  Map<String, dynamic> toJson() => <String, dynamic>{
    'personal_id': personalId,
    'name': name,
  };
}