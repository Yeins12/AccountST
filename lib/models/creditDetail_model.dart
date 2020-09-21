import 'package:intl/intl.dart';

import '../util/time_convert.dart';

class CreditDetailList {
  final List<CreditDetailModel> creditsDetail;
  CreditDetailList({this.creditsDetail});

  factory CreditDetailList.fromJson(List<dynamic> parsedJson) {
    List<CreditDetailModel> creditsDetail = List<CreditDetailModel>();
    creditsDetail =
        parsedJson.map((i) => CreditDetailModel.fromJson(i)).toList();
    return CreditDetailList(creditsDetail: creditsDetail);
  }
}

class CreditDetailModel {
  final String nrocredio;
  final String fechainicio;
  final String valor;
  final String pendiente;
  final String descripcion;
  final String cuotas;
  final String cpendientes;
  final String interes;
  final List<DetailModel> detCuenta;

  CreditDetailModel(
      {this.nrocredio,
      this.fechainicio,
      this.valor,
      this.pendiente,
      this.descripcion,
      this.cuotas,
      this.cpendientes,
      this.interes,
      this.detCuenta});

  factory CreditDetailModel.fromJson(Map<String, dynamic> json) {
    final formatter = NumberFormat.simpleCurrency(locale: 'en');
    var list = json['detalle'] as List;
    List<DetailModel> detailList =
        list.map((i) => DetailModel.fromJson(i)).toList();

    return new CreditDetailModel(
        nrocredio: json["nrocrdto"],
        fechainicio: fechaConvert(json["fechainicio"]),
        valor: formatter.format(double.parse(json["valor"])),
        pendiente: formatter.format(double.parse(json["pendiente"])),
        descripcion: json["descripcion"],
        cuotas: json["cuotas"],
        cpendientes: json["cpendientes"],
        interes: json["interes"],
        detCuenta: detailList);
  }
}

//DETAIL
class DetailModel {
  final String recibo;
  final String cuota;
  final String fecha;
  final String valor;
  final String capital;
  final String intereses;
  final String mora;
  final String seguro;
  final String total;

  DetailModel({
    this.recibo,
    this.cuota,
    this.fecha,
    this.valor,
    this.capital,
    this.intereses,
    this.mora,
    this.seguro,
    this.total,
  });
  factory DetailModel.fromJson(Map<String, dynamic> parsedJson) {
    final formatter = NumberFormat.simpleCurrency(locale: 'en');
    return DetailModel(
      recibo: parsedJson["recibo"],
      cuota: parsedJson['cuota'],
      fecha: fechaConvert(parsedJson['fecha']),
      valor: formatter.format(double.parse(parsedJson["valor"])),
      capital: formatter.format(double.parse(parsedJson["capital"])),
      intereses: formatter.format(double.parse(parsedJson["intereses"])),
      mora: formatter.format(double.parse(parsedJson["mora"])),
      seguro: formatter.format(double.parse(parsedJson["seguro"])),
      total: formatter.format(double.parse(parsedJson["total"])),
    );
  }
}
