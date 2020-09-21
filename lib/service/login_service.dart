import 'dart:convert' as convert;
import 'dart:async';
import '.././widgets/alert/alert_dialogo.dart';

import '../widgets/alert/indicador_progress.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class LoginService with ChangeNotifier {
  String _clave;
  String _idusr;

  bool get isLogin {
    return _idusr != null;
  }

  String get idusr {
    return _idusr;
  }

  Future authenticate(String idusr, String clave, context) async {
    double medidaReferenciaAlto = MediaQuery.of(context).size.height;
    IndicadorProgreso.show(context);
    String ruta = 'http://conres.com.co/wsestadocuenta/login.php';
    try {
      _idusr = idusr.trim();
      _clave = clave.trim();
      var peticion =
          await http.post(ruta, body: {'usuario': _idusr, 'clave': _clave});
      if (peticion.statusCode == 200) {
        var valor = convert.jsonDecode(peticion.body);
        //print(object)
        if (valor == 1) {
          final pref = await SharedPreferences.getInstance();
          final userData =
              convert.jsonEncode({'idusr': _idusr, 'clave': _clave});
          pref.setString('userData', userData);
          notifyListeners();
          Navigator.of(context).pop();
          IndicadorProgreso.hide();
        } else if (valor == 0) {
          IndicadorProgreso.hide();
          mostrarDialogoWidget(0, context, 'Aviso!', 'Credenciales invalidas',
              1, medidaReferenciaAlto);
        } else if (valor == 2) {
          IndicadorProgreso.hide();
          mostrarDialogoWidget(
              0,
              context,
              'Aviso!',
              'Error inesperado, inténtelo  nuevamente',
              1,
              medidaReferenciaAlto);
        } else {
          IndicadorProgreso.hide();
          mostrarDialogoWidget(
              0,
              context,
              'Aviso!',
              'Error inesperado, inténtelo  nuevamente',
              1,
              medidaReferenciaAlto);
        }
      } else {
        IndicadorProgreso.hide();
        mostrarDialogoWidget(0, context, 'Aviso!',
            'Error inesperado, inténtelo  nuevamente', 1, medidaReferenciaAlto);
      }
    } catch (e) {
      IndicadorProgreso.hide();
      mostrarDialogoWidget(0, context, 'Aviso!',
          'Error inesperado, inténtelo  nuevamente', 1, medidaReferenciaAlto);
    }
  }

  Future<bool> tryAutoLogin() async {
    final pref = await SharedPreferences.getInstance();
    if (!pref.containsKey('userData')) {
      return false;
    }
    final extractedUserData =
        convert.jsonDecode(pref.getString('userData')) as Map<String, Object>;
    _idusr = extractedUserData['idusr'];
    notifyListeners();
    return true;
  }

  void logout() async {
    _idusr = null;
    notifyListeners();
    final pref = await SharedPreferences.getInstance();
    // prefs.remove('userData');
    pref.clear();
  }
}
