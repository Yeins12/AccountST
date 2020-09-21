import 'package:intl/intl.dart';

class DataUserModel {
  final String user;
  final String cc;
  final String totalValue;

  DataUserModel({this.user, this.cc, this.totalValue});
  factory DataUserModel.fromJson(Map<String, dynamic> json) {
    final formatter = NumberFormat.simpleCurrency(locale: 'en');
    return DataUserModel(
      user: json['nmbres'],
      cc: json['cdla'],
      totalValue: formatter.format(double.parse(json['sldo'])),
    );
  }
}
