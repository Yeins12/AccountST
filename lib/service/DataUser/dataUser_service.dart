import 'dart:convert' as convert;
import 'dart:async';
import '../../models/dataUser_model.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

import '../login_service.dart';

class DataUserService {
  static Future<DataUserModel> dataUserQuery(context) async {
    DataUserModel dataUser;
    final provider = Provider.of<LoginService>(context, listen: false);
    String ruta = 'http://conres.com.co/wsestadocuenta/datos.php';
    try {
      var peticion = await http.post(ruta, body: {'usuario': provider.idusr});
      if (peticion.statusCode == 200) {
        var jsonResponse = convert.jsonDecode(peticion.body);

        dataUser = DataUserModel.fromJson(jsonResponse["contactos"]);

        return dataUser;
      }
    } catch (e) {
      return dataUser;
    }
    return dataUser;
  }
}
