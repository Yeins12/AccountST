import 'package:connectivity/connectivity.dart';
import 'package:flutter/cupertino.dart';
import '../../widgets/alert/alert_dialogo.dart';

import '../../models/notification_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class NotificationService {
  static Future<NotificationList> noticiaQuery(context) async {
    NotificationList notificaList;
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
      NotificationList notificaList;
      return notificaList;
    } else {
      try {
        var peticion = await http.post(ruta, body: {});
        if (peticion.statusCode == 200) {
          var jsonResponse = convert.jsonDecode(peticion.body);
          notificaList = NotificationList.fromJson(jsonResponse['notifica']);
          return notificaList;
        }
      } catch (e) {
        return notificaList;
      }
    }

    return notificaList;
  }
}
