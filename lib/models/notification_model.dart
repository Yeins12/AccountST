import '../util/time_convert.dart';

class NotificationList {
  final List<NotificationModel> notificaModel;
  NotificationList({this.notificaModel});
  factory NotificationList.fromJson(List<dynamic> parsedJson) {
    List<NotificationModel> notificaModel = List<NotificationModel>();
    notificaModel =
        parsedJson.map((i) => NotificationModel.fromJson(i)).toList();
    return NotificationList(notificaModel: notificaModel);
  }
}

class NotificationModel {
  final String fecha;
  String hora;
  final String titulo;
  final String descripcion;
  NotificationModel({this.fecha, this.hora, this.titulo, this.descripcion});

  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    String f = (json['fecha'].split(' ')[0]).split('-');
    String h = json['fecha'].split(' ')[1];

    return NotificationModel(
        fecha: fechaConvert(f),
        hora: horaConvert(h),
        titulo: json['titulo'],
        descripcion: json['descripcion']);
  }
}
