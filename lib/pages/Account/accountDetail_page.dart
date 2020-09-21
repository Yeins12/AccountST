import 'dart:io';

import '../../models/creditDetail_model.dart';
import '../../util/colores.dart';
import '../../widgets/pdfDocument/pdf_detailAccount_widget.dart';
import 'package:flutter/material.dart';

class AccountDetailPage extends StatelessWidget {
  final CreditDetailModel creditDetail;
  const AccountDetailPage({@required this.creditDetail, key}) : super(key: key);

  Widget _contentTop(medidaReferenciaAlto, icon, color, title, st1, data, st2) {
    return Expanded(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Icon(
            icon,
            color: color,
            size: tamannoIcono(medidaReferenciaAlto),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                title,
                overflow: TextOverflow.ellipsis,
                style: st1,
                textAlign: TextAlign.center,
              ),
              Text(
                data,
                overflow: TextOverflow.ellipsis,
                style: st2,
                textAlign: TextAlign.center,
              )
            ],
          )
        ],
      ),
    );
  }

  Widget _top(medidaReferenciaAlto) {
    TextStyle st1 = TextStyle(
        fontSize: letraTextoTamanno(medidaReferenciaAlto) - 2,
        color: Colors.white);
    TextStyle st2 = TextStyle(
        color: Colors.white,
        fontSize: letraTextoTamanno(medidaReferenciaAlto),
        fontWeight: FontWeight.bold);
    TextStyle st3 = TextStyle(
        color: Colors.white,
        fontSize: letraTextoTamanno(medidaReferenciaAlto),
        fontWeight: FontWeight.bold);
    return Padding(
      padding: EdgeInsets.all(paddingAll(medidaReferenciaAlto)),
      child: Card(
        elevation: 15,
        color: primaryColor,
        child: Padding(
          padding: EdgeInsets.all(paddingAll(medidaReferenciaAlto) + 5),
          child: Column(
            children: [
              SizedBox(height: sizedBox(medidaReferenciaAlto)),
              IntrinsicHeight(
                child: Row(
                  children: [
                    _contentTop(
                        medidaReferenciaAlto,
                        Icons.nature,
                        Colors.green[100],
                        'No. Crédito',
                        st1,
                        creditDetail.nrocredio,
                        st2),
                    VerticalDivider(color: Colors.white),
                    _contentTop(
                        medidaReferenciaAlto,
                        Icons.calendar_today,
                        Colors.green[100],
                        'Fecha de inicio',
                        st1,
                        creditDetail.fechainicio,
                        st2),
                  ],
                ),
              ),
              Divider(
                height: sizedBox(medidaReferenciaAlto) + 5,
                color: Colors.white,
              ),
              IntrinsicHeight(
                child: Row(
                  children: [
                    _contentTop(
                        medidaReferenciaAlto,
                        Icons.attach_money,
                        Colors.green[100],
                        'Valor',
                        st1,
                        creditDetail.valor,
                        st2),
                    VerticalDivider(color: Colors.white),
                    _contentTop(
                        medidaReferenciaAlto,
                        Icons.money_off,
                        Colors.green[100],
                        'Pendiente',
                        st1,
                        creditDetail.pendiente,
                        st3),
                  ],
                ),
              ),
              Divider(
                height: sizedBox(medidaReferenciaAlto) + 5,
                color: Colors.white,
              ),
              Padding(
                padding: EdgeInsets.all(paddingAll(medidaReferenciaAlto)),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text('Descripción', style: st1),
                      Text(creditDetail.descripcion,
                          style: TextStyle(
                              fontSize:
                                  letraTextoTamanno(medidaReferenciaAlto) + 2,
                              fontWeight: FontWeight.bold,
                              color: Colors.white)),
                    ],
                  ),
                ),
              ),
              Divider(
                height: sizedBox(medidaReferenciaAlto) + 5,
                color: Colors.white,
              ),
              IntrinsicHeight(
                child: Row(
                  children: [
                    _contentTop(
                        medidaReferenciaAlto,
                        Icons.event_available,
                        Colors.green[100],
                        'Cuotas',
                        st1,
                        creditDetail.cuotas,
                        st2),
                    VerticalDivider(color: Colors.white),
                    _contentTop(
                        medidaReferenciaAlto,
                        Icons.event_busy,
                        Colors.green[100],
                        'Pendientes',
                        st1,
                        creditDetail.cpendientes,
                        st3),
                    VerticalDivider(color: Colors.white),
                    _contentTop(
                        medidaReferenciaAlto,
                        Icons.show_chart,
                        Colors.green[100],
                        'Interés',
                        st1,
                        '${creditDetail.interes} %',
                        st3),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _content(medidaReferenciaAlto, index) {
    TextStyle es1 = TextStyle(
      fontSize: letraTextoTamanno(medidaReferenciaAlto),
    );
    _listTile(title, data) {
      return Expanded(
        child: ListTile(
          title: Center(
              child: Text(title,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: letraTextoTamanno(medidaReferenciaAlto),
                      color: Colors.orange,
                      fontWeight: FontWeight.bold))),
          subtitle: Center(
              child: Text(data,
                  style: TextStyle(
                      fontSize: letraTextoTamanno(medidaReferenciaAlto)))),
        ),
      );
    }

    return Padding(
      padding: EdgeInsets.only(
          bottom: medidaReferenciaAlto > xxxxlarga
              ? paddingAll(medidaReferenciaAlto)
              : 0),
      child: ExpansionTile(
        backgroundColor: Colors.white,
        leading: CircleAvatar(
          radius: tamannoIcono(medidaReferenciaAlto) + 5,
          backgroundColor: primaryColor,
          child: Center(
              child: Text(
            creditDetail.detCuenta[index].cuota,
            style: TextStyle(
                color: Colors.white,
                fontSize: letraTextoTamanno(medidaReferenciaAlto)),
          )),
        ),
        title: Text(
          "Fecha: ${creditDetail.detCuenta[index].fecha}",
          style: es1,
        ),
        subtitle: Text(
          "Recibo: ${creditDetail.detCuenta[index].recibo}",
          style: es1,
        ),
        children: [
          Padding(
            padding: EdgeInsets.only(
                right: paddingAll(medidaReferenciaAlto),
                left: paddingAll(medidaReferenciaAlto),
                bottom: paddingAll(medidaReferenciaAlto)),
            child: Card(
              elevation: 10,
              color: Colors.green[50],
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      _listTile(
                          'Valor Cuota: ', creditDetail.detCuenta[index].valor),
                      _listTile(
                          'Capital: ', creditDetail.detCuenta[index].capital),
                    ],
                  ),
                  Divider(
                    color: primaryColor,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _listTile('Intereses: ',
                          creditDetail.detCuenta[index].intereses),
                      _listTile('Mora: ', creditDetail.detCuenta[index].mora),
                    ],
                  ),
                  Divider(
                    color: primaryColor,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _listTile(
                          'Seguro: ', creditDetail.detCuenta[index].seguro),
                      _listTile(
                          'Total Pago: ', creditDetail.detCuenta[index].total),
                    ],
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    double medidaReferenciaAlto = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        brightness: Brightness.dark,
        title: Text('Detalle de cuenta',
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
        actions: [
          IconButton(
              icon: Icon(
                Icons.file_download,
                color: Colors.white,
                size: tamannoIcono(medidaReferenciaAlto),
              ),
              onPressed: () => PdfDetailAccountWidget(
                      context: context,
                      creditDetail: creditDetail,
                      medidaReferenciaAlto: medidaReferenciaAlto)
                  .pdfDownloadDetail())
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _top(medidaReferenciaAlto),
            SizedBox(
              height: sizedBox(medidaReferenciaAlto) + 5,
            ),
            Card(
              color: Colors.white,
              elevation: 5,
              child: Padding(
                padding: EdgeInsets.all(paddingAll(medidaReferenciaAlto)),
                child: Center(
                    child: Text('DETALLE DE PAGOS',
                        style: TextStyle(
                            fontSize: letraTextoTamanno(medidaReferenciaAlto),
                            fontWeight: FontWeight.bold))),
              ),
            ),
            Container(
                alignment: Alignment.topCenter,
                padding: EdgeInsets.only(
                    top: paddingAll(medidaReferenciaAlto),
                    right: paddingAll(medidaReferenciaAlto),
                    left: paddingAll(medidaReferenciaAlto)),
                child: ListView.builder(
                  physics: new NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: creditDetail.detCuenta.length,
                  itemBuilder: (BuildContext context, index) {
                    return _content(medidaReferenciaAlto, index);
                  },
                ))
          ],
        ),
      ),
    );
  }
}
