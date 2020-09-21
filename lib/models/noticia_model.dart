import '../util/time_convert.dart';

class NoticiaModelList {
  final List<NoticiaModel> noticiaModel;
  NoticiaModelList({this.noticiaModel});
  factory NoticiaModelList.fromJson(List<dynamic> parsedJson) {
    List<NoticiaModel> noticiaModel = List<NoticiaModel>();
    noticiaModel = parsedJson.map((i) => NoticiaModel.fromJson(i)).toList();
    return NoticiaModelList(noticiaModel: noticiaModel);
  }
}

class NoticiaModel {
  final String fecha;
  final String hora;
  final String titulo;
  final String rutaimg;
  final String contenido;
  final String cita;
  NoticiaModel(
      {this.fecha,
      this.hora,
      this.titulo,
      this.rutaimg,
      this.contenido,
      this.cita});

  factory NoticiaModel.fromJson(Map<String, dynamic> json) {
    String f = (json['fecha'].split(' ')[0]).split('-');
    String h = json['fecha'].split(' ')[1];

    return NoticiaModel(
        fecha: fechaConvert(f),
        hora: horaConvert(h),
        titulo: json['titulo'],
        rutaimg: json['rutaimg'],
        contenido: json['contenido'],
        cita: json['cita']);
  }
}
