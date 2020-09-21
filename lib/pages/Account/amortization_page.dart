import 'dart:io';

import '../../service/menuService/credit_simulator_service.dart';
import '../../util/icon_msg_back.dart';
import 'package:provider/provider.dart';

import '../../widgets/amotization/amortization_content_widget.dart';

import '../../models/amortization_model.dart';
import '../../service/accountServices/amortization_service.dart';

import '../../util/colores.dart';
import 'package:flutter/material.dart';

class AmortizationPage extends StatelessWidget {
  final tipo;
  final String nrocredito;
  const AmortizationPage({Key key, this.nrocredito, this.tipo})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    double medidaReferenciaAlto = MediaQuery.of(context).size.height;
    double medidaReferenciaAncho = MediaQuery.of(context).size.width;
    List<AmortizationModel> providerList =
        Provider.of<CreditSimulatorService>(context).getLista;
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          brightness: Brightness.dark,
          title: Text('Amortización',
              style: TextStyle(
                fontFamily: 'berlin',
                color: Colors.white,
                fontSize: letraBarTamanno(medidaReferenciaAlto),
              )),
          leading: IconButton(
            icon: Icon(
              Platform.isAndroid ? Icons.arrow_back : Icons.arrow_back_ios,
              color: Colors.white,
              size: tamannoIcono(medidaReferenciaAlto),
            ),
            onPressed: () => Navigator.of(context).pop(true),
          ),
        ),
        body: tipo == 0
            ? listViewContent(
                medidaReferenciaAlto, medidaReferenciaAncho, providerList, tipo)
            : FutureBuilder<AmortizationList>(
                future:
                    AmortizationService.amortizationQuery(context, nrocredito),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return listViewContent(
                        medidaReferenciaAlto,
                        medidaReferenciaAncho,
                        snapshot.data.amortizationList,
                        1);
                  } else if (snapshot.hasError) {
                    return iconMsgBack(medidaReferenciaAlto, Icons.error,
                        'Ha ocurrido un error', 1);
                  }
                  return Center(child: iconCargando(medidaReferenciaAlto));
                }));
  }
}
