import 'package:equatable/equatable.dart';

class Coupon extends Equatable {
  final String id;
  final String code;
  final double value;

  const Coupon({
    required this.id,
    required this.code,
    required this.value,
  });

  /*Voucher copyWith({
    String? id,
    String? code,
    double? value,
  }) {
    return Voucher(
      id: id ?? this.id,
      code: code ?? this.code,
      value: value ?? this.value,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'code': code,
      'value': value,
    };
  }

  factory Voucher.fromSnapshot(DocumentSnapshot snap) {
    return Voucher(
      id: snap.id,
      code: snap['code'],
      value: snap['value'].toDouble(),
    );
  }*/

  //String toJson() => json.encode(toMap());

  //@override
  //bool get stringify => true;

  @override
  List<Object> get props => [id, code, value];

  static List<Coupon> coupons = [
    Coupon(id: '1', code: 'ส่วนลดค่าชาร์จ 80฿', value: 80),
    Coupon(id: '2', code: 'ส่วนลดค่าชาร์จ 15฿', value: 15.0),
    Coupon(id: '3', code: 'ส่วนลดค่าชาร์จ 50฿', value: 50.0),
  ];
}
