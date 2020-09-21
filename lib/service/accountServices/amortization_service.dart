import 'package:connectivity/connectivity.dart';
import 'package:flutter/cupertino.dart';
import '../../widgets/alert/alert_dialogo.dart';

import '../../models/amortization_model.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import '../login_service.dart';
import 'dart:convert' as convert;

class AmortizationService {
  static Future<AmortizationList> amortizationQuery(context, nrocredito) async {
    AmortizationList amortizationCredit;
    final provider = Provider.of<LoginService>(context, listen: false);
    String ruta = 'http://conres.com.co/wsestadocuenta/amortiza.php';
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      mostrarDialogoWidget(
          0,
          context,
          'Aviso!',
          'Verifica tu conexión a internet',
          1,
          MediaQuery.of(context).size.height);
      AmortizationList amortizationCredit;
      return amortizationCredit;
    } else {
      try {
        var peticion = await http
            .post(ruta, body: {'usuario': provider.idusr, 'crdto': nrocredito});
        if (peticion.statusCode == 200) {
          var jsonResponse = convert.jsonDecode(peticion.body);
          amortizationCredit =
              AmortizationList.fromJson(jsonResponse['contactos']);
          return amortizationCredit;
        }
      } catch (e) {
        return amortizationCredit;
      }
    }

    return amortizationCredit;
  }
}
