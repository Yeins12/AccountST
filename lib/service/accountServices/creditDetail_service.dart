import 'dart:async';
import 'package:flutter/material.dart';
import 'package:simple_connectivity/simple_connectivity.dart';
import '../../widgets/alert/alert_dialogo.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import '../../models/creditDetail_model.dart';
import '../login_service.dart';
import 'dart:convert' as convert;

class CreditDetailService {
  Future<CreditDetailList> creditDetailQuery(context) async {
    double medidaReferenciaAlto = MediaQuery.of(context).size.height;
    CreditDetailList creditDetailFinal;
    final provider = Provider.of<LoginService>(context, listen: false);
    String ruta = 'http://conres.com.co/wsestadocuenta/credpndntes.php';
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      mostrarDialogoWidget(0, context, 'Aviso!',
          'Verifica tu conexión a internet', 1, medidaReferenciaAlto);
      CreditDetailList creditDetailFinal;
      return creditDetailFinal;
    } else {
      try {
        var peticion = await http.post(ruta, body: {'usuario': provider.idusr});
        if (peticion.statusCode == 200) {
          var jsonResponse = convert.jsonDecode(peticion.body);
          creditDetailFinal =
              CreditDetailList.fromJson(jsonResponse['dtllecrdto']);
          return creditDetailFinal;
        }
      } catch (e){
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
        return creditDetailFinal;
      } 
    }

    return creditDetailFinal;
  }
}
