import 'package:flutter/cupertino.dart';
import 'package:simple_connectivity/simple_connectivity.dart';
import '../../widgets/alert/alert_dialogo.dart';

import '../../models/noticia_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class NoticiaService {
  static Future<NoticiaModelList> noticiaQuery(context) async {
    double medidaReferenciaAlto = MediaQuery.of(context).size.height;
    NoticiaModelList noticiaList;
    String ruta = 'http://conres.com.co/wsestadocuenta/noticia.php';
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      mostrarDialogoWidget(
          0,
          context,
          'Aviso!',
          'Verifica tu conexión a internet',
          1,
          MediaQuery.of(context).size.height);
      NoticiaModelList noticiaList;
      return noticiaList;
    } else {
      try {
        var peticion = await http.post(ruta, body: {});
        if (peticion.statusCode == 200) {
          var jsonResponse = convert.jsonDecode(peticion.body);
          noticiaList = NoticiaModelList.fromJson(jsonResponse['noticia']);
          return noticiaList;
        }
      } catch (e) {
        if(e.toString().contains('SocketException')){
        //IndicadorProgreso.hide();
        mostrarDialogoWidget(
          0,
          context,
          'Aviso!',
          'Verifica tu conexión a internet',
          1,
          medidaReferenciaAlto);
      }
        return noticiaList;
      }
    }

    return noticiaList;
  }
}
