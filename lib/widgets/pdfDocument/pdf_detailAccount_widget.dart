import 'dart:convert';
import 'dart:io';

import 'package:ext_storage/ext_storage.dart';

import '../../util/colores.dart';
import '../../widgets/alert/alert_dialogo.dart';
import '../../widgets/alert/indicador_progress.dart';
import '../../widgets/pdfDocument/pwfWidgetUtil.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import '../../models/creditDetail_model.dart';
import 'package:flutter/services.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

class PdfDetailAccountWidget {
  final context;
  final CreditDetailModel creditDetail;
  final medidaReferenciaAlto;
  PdfDetailAccountWidget(
      {this.context, this.creditDetail, this.medidaReferenciaAlto});
  final pdf = pw.Document();
  void initState() {
    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    final android = AndroidInitializationSettings('app_icon');
    final iOS = IOSInitializationSettings();
    final initSettings = InitializationSettings(android, iOS);

    flutterLocalNotificationsPlugin.initialize(initSettings,
        onSelectNotification: _onSelectNotification);
  }

  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
  Future<void> _onSelectNotification(String json) async {
    final obj = jsonDecode(json);

    if (obj['isSuccess']) {
      OpenFile.open(obj['filePath']);
    } else {
      mostrarDialogoWidget(
          0,
          context,
          'Error!',
          'Ha ocurrido un error en la descarga, vuelve a intentarlo',
          1,
          MediaQuery.of(context).size.height);
    }
  }

  Future<void> _showNotification(Map<String, dynamic> downloadStatus) async {
    final android = AndroidNotificationDetails(
        'channel id', 'channel name', 'channel description',
        priority: Priority.High, importance: Importance.Max);
    final iOS = IOSNotificationDetails();
    final platform = NotificationDetails(android, iOS);
    final json = jsonEncode(downloadStatus);
    final isSuccess = downloadStatus['isSuccess'];
    String ruta =
        downloadStatus['ruta'] == 0 ? 'Descargas' : downloadStatus['filePath'];
    String folder = ruta.replaceAll(
        'Credito${creditDetail.nrocredio}' + downloadStatus['name'] + '.pdf',
        '');
    if (isSuccess) {
      await flutterLocalNotificationsPlugin.show(
          0, // notification id
          'Guardado',
          'Tu detalle de cuenta ya está disponible!',
          platform,
          payload: json);

      mostrarDialogoWidget(
          0,
          context,
          'Aviso!',
          'Tu archivo ha sido guardado en: \n\n $folder',
          1,
          MediaQuery.of(context).size.height);
    } else {
      mostrarDialogoWidget(
          0,
          context,
          'Error!',
          'Ha ocurrido un error en la descarga, vuelve a intentarlo',
          1,
          MediaQuery.of(context).size.height);
    }
  }

  _contentTop(medidaReferenciaAlto, color, title, st1, data, st2) {
    return pw.Expanded(
        child: pw.Column(
      mainAxisAlignment: pw.MainAxisAlignment.spaceEvenly,
      children: [
        pw.Text(
          title,
          style: st1,
          textAlign: pw.TextAlign.center,
        ),
        pw.Text(
          data,
          style: st2,
          textAlign: pw.TextAlign.center,
        )
      ],
    ));
  }

  _writeOnPdf(_logo) async {
    List<List> salidas = new List();
    salidas.add(<String>[
      'Nro Cuota',
      'Fecha',
      'Valor Cuota',
      'Capital',
      'Interés',
      'Mora',
      'Seguro',
      'Total Pago',
      'Nro recibo'
    ]);
    //salidas.add(creditDetail.detCuenta);
    final pw.PageTheme pageTheme = await myPageTheme(PdfPageFormat.a4);
    creditDetail.detCuenta.forEach((element) {
      List<String> recind = <String>[
        element.cuota,
        element.fecha,
        element.valor,
        element.capital,
        element.intereses,
        element.mora,
        element.seguro,
        element.total,
        element.recibo
      ];
      salidas.add(recind);
    });
    pdf.addPage(pw.MultiPage(
        pageTheme: pageTheme,
        build: (pw.Context context) {
          double medida = medidaReferenciaAlto >= xxxlarga
              ? 8
              : sizedBox(medidaReferenciaAlto);
          pw.TextStyle st1 = pw.TextStyle(
              fontSize: medidaReferenciaAlto >= xxxlarga
                  ? 10
                  : letraTextoTamanno(medidaReferenciaAlto) - 2,
              color: PdfColor.fromHex('#ffffff'));
          pw.TextStyle st2 = pw.TextStyle(
              color: PdfColor.fromHex('#ffffff'),
              fontSize: medidaReferenciaAlto >= xxxlarga
                  ? 12
                  : letraTextoTamanno(medidaReferenciaAlto),
              fontWeight: pw.FontWeight.bold);

          return <pw.Widget>[
            pw.Container(
              alignment: pw.Alignment.center,
              padding: const pw.EdgeInsets.only(bottom: 10),
              height: 50,
              child: _logo != null ? pw.Image(_logo) : pw.PdfLogo(),
            ),
            pw.Header(
                level: 0,
                child: pw.Center(
                    child: pw.Text("TU ESTADO DE CUENTA",
                        style: pw.TextStyle(
                            color: PdfColor.fromHex('#23b674'),
                            fontWeight: pw.FontWeight.bold,
                            fontSize: 20)))),
            pw.Container(
                margin: pw.EdgeInsets.all(paddingAll(medidaReferenciaAlto)),
                decoration: pw.BoxDecoration(
                  borderRadius: 2,
                  color: PdfColor.fromHex('#23b674'),
                ),
                padding: pw.EdgeInsets.all(paddingAll(medidaReferenciaAlto)),
                alignment: pw.Alignment.centerLeft,
                child: pw.Column(children: [
                  pw.Row(children: [
                    _contentTop(medidaReferenciaAlto, Colors.green[100],
                        'No. Crédito', st1, creditDetail.nrocredio, st2),
                    pw.VerticalDivider(color: PdfColor.fromHex('#ffffff')),
                    _contentTop(medidaReferenciaAlto, Colors.green[100],
                        'Fecha de inicio', st1, creditDetail.fechainicio, st2),
                  ]),
                  pw.Divider(
                      height: medida, color: PdfColor.fromHex('#ffffff')),
                  pw.Row(children: [
                    _contentTop(medidaReferenciaAlto, Colors.green[100],
                        'Valor', st1, creditDetail.valor, st2),
                    pw.VerticalDivider(color: PdfColor.fromHex('#ffffff')),
                    _contentTop(medidaReferenciaAlto, Colors.green[100],
                        'Pendiente', st1, creditDetail.pendiente, st2),
                  ]),
                  pw.Divider(
                      height: medida, color: PdfColor.fromHex('#ffffff')),
                  pw.Padding(
                    padding: pw.EdgeInsets.all(medida),
                    child: pw.Center(
                      child: pw.Column(
                        mainAxisAlignment: pw.MainAxisAlignment.center,
                        children: [
                          pw.Text('Descripción', style: st1),
                          pw.Text(creditDetail.descripcion,
                              style: pw.TextStyle(
                                  fontSize: medidaReferenciaAlto >= xxlarga
                                      ? 14
                                      : letraTextoTamanno(
                                              medidaReferenciaAlto) +
                                          2,
                                  fontWeight: pw.FontWeight.bold,
                                  color: PdfColor.fromHex('#ffffff'))),
                        ],
                      ),
                    ),
                  ),
                  pw.Divider(
                      height: medida, color: PdfColor.fromHex('#ffffff')),
                  pw.Row(
                    children: [
                      _contentTop(medidaReferenciaAlto, Colors.green[100],
                          'Cuotas', st1, creditDetail.cuotas, st2),
                      pw.VerticalDivider(color: PdfColor.fromHex('#ffffff')),
                      _contentTop(medidaReferenciaAlto, Colors.green[100],
                          'Pendientes', st1, creditDetail.cpendientes, st2),
                      pw.VerticalDivider(color: PdfColor.fromHex('#ffffff')),
                      _contentTop(medidaReferenciaAlto, Colors.green[100],
                          'Interés', st1, creditDetail.interes, st2),
                    ],
                  ),
                ])),
            pw.SizedBox(height: medida),
            pw.Header(
                level: 0,
                child: pw.Center(
                    child: pw.Text("Detalle de Pagos",
                        style: pw.TextStyle(
                            color: PdfColor.fromHex('#23b674'),
                            fontWeight: pw.FontWeight.bold,
                            fontSize: 15)))),
            pw.Table.fromTextArray(
                context: context,
                data: salidas,
                border: null,
                cellAlignment: pw.Alignment.centerLeft,
                headerDecoration: pw.BoxDecoration(
                  borderRadius: 2,
                  color: PdfColor.fromHex('#23b674'),
                ),
                headerHeight: 25,
                cellHeight: 30,
                headerStyle: pw.TextStyle(
                  color: PdfColor.fromHex('#FFFFFF'),
                  fontSize: 10,
                  fontWeight: pw.FontWeight.bold,
                ),
                cellStyle: pw.TextStyle(
                    color: PdfColor.fromHex('#000000'), fontSize: 8),
                rowDecoration: pw.BoxDecoration(
                    border: pw.BoxBorder(
                  bottom: true,
                  color: PdfColor.fromHex('#000000'),
                ))),
          ];
        }));
  }

  Future _savePdf(context) async {
    IndicadorProgreso.show(context);
    Map<String, dynamic> result = {
      'isSuccess': false,
      'filePath': null,
      'ruta': null,
      'name': null,
      'error': null,
    };
    try {
      var now = DateTime.now().toString();
      String name = now.replaceAll(' ', '');
      name = now.replaceAll(':', '');
      name = name.replaceAll('.', '');
      name = name.replaceAll('-', '');
      name = name.replaceAll(' ', '');
      String path;
      result['name'] = name;
      if (Platform.isAndroid) {
        path = await ExtStorage.getExternalStoragePublicDirectory(
            ExtStorage.DIRECTORY_DOWNLOADS);
      } else {
        Directory directory = await getApplicationDocumentsDirectory();
        path = directory.path;
      }
      result['ruta'] = 0;
      File file = File('$path/Credito${creditDetail.nrocredio}$name.pdf');

      try {
        file.writeAsBytesSync(pdf.save());
      } catch (e) {
        Directory downloadsDirectory = await getExternalStorageDirectory();
        path = downloadsDirectory.path;
        result['ruta'] = 1;
        File file = File('$path/Credito${creditDetail.nrocredio}$name.pdf');
        file.writeAsBytesSync(pdf.save());
      }

      result['isSuccess'] = true;
      result['filePath'] = '$path/Credito${creditDetail.nrocredio}$name.pdf';
    } catch (e) {
      result['error'] = e.toString();
    } finally {
      IndicadorProgreso.hide();
      await _showNotification(result);
    }
  }

  pdfDownloadDetail() async {
    initState();
    PdfImage _logo;
    _logo = PdfImage.file(
      pdf.document,
      bytes: (await rootBundle.load('assets/img/logoverde.png'))
          .buffer
          .asUint8List(),
    );
    _writeOnPdf(_logo);
    await _savePdf(context);
  }
}
