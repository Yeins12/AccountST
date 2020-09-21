import 'dart:io';

import '../../pages/Account/amortization_page.dart';
import '../../service/menuService/credit_simulator_service.dart';
import '../../util/colores.dart';
import '../../util/textField_format_util.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class CreditSimulatorPage extends StatefulWidget {
  @override
  _CreditSimulatorPageState createState() => _CreditSimulatorPageState();
}

class _CreditSimulatorPageState extends State<CreditSimulatorPage> {
  Map<String, dynamic> _creditData = {
    'valor': '',
    'interes': '',
    'plazo': '',
    'fecha': '',
  };
  @override
  void dispose() {
    // Limpia el controlador cuando el widget se elimine del árbol de widgets
    valorController.dispose();
    interesController.dispose();
    plazoController.dispose();
    fechaController.dispose();
    cuotaController.dispose();
    super.dispose();
  }

  bool _clear = false;

  TabController controller;

  TextEditingController valorController = new TextEditingController();

  TextEditingController interesController = new TextEditingController();

  TextEditingController plazoController = new TextEditingController();

  TextEditingController fechaController = new TextEditingController();

  TextEditingController cuotaController = new TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey();

  var newFormat = DateFormat("yyyy-MM-dd");

  Future<Null> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(1901, 1),
        lastDate: DateTime(2100));
    if (picked != null && picked != DateTime.now())
      fechaController.value =
          TextEditingValue(text: newFormat.format(picked).toString());
  }

  _iosDate(context) {
    return showModalBottomSheet(
        context: context,
        builder: (BuildContext builder) {
          return Container(
              height: MediaQuery.of(context).copyWith().size.height / 3,
              child: CupertinoDatePicker(
                initialDateTime: DateTime.now(),
                onDateTimeChanged: (DateTime newdate) {
                  fechaController.value = TextEditingValue(
                      text: newFormat.format(newdate).toString());
                },
                use24hFormat: true,
                minimumYear: 2010,
                maximumYear: 2100,
                minuteInterval: 1,
                mode: CupertinoDatePickerMode.date,
              ));
        });
  }

  void _calculationprocess(context) {
    Provider.of<CreditSimulatorService>(context, listen: false)
        .calculationProcess(
            context,
            double.parse((_creditData['valor'])
                .substring(0, _creditData['valor'].indexOf('.'))
                .replaceAll(",", "")
                .replaceAll(".", "")
                .replaceAll("\$", "")),
            double.parse(_creditData['interes']),
            int.parse(_creditData['plazo']),
            DateTime.parse(_creditData['fecha']));
  }

  Widget _button(medida, context) {
    return RaisedButton(
      onPressed: () {
        if (!_clear) {
          if (!_formKey.currentState.validate()) {
            return;
          } else {
            _formKey.currentState.save();
            _calculationprocess(context);
            setState(() {
              _clear = true;
            });
          }
        } else {
          valorController.clear();
          interesController.clear();
          plazoController.clear();
          fechaController.clear();
          cuotaController.clear();
          Provider.of<CreditSimulatorService>(context, listen: false).restar();
          setState(() {
            _clear = false;
          });
        }
      },
      color: Colors.orange[200],
      textColor: Colors.white,
      child: Padding(
        padding: EdgeInsets.all(paddingAll(medida)),
        child: Text(
          _clear ? 'Limpiar' : 'Calcular',
          style: TextStyle(fontSize: letraTextoTamanno(medida)),
        ),
      ),
    );
  }

  Widget _button2(medida, context) {
    return Row(
      children: [
        Expanded(
          child: RaisedButton(
            onPressed: () =>
                Navigator.push(context, MaterialPageRoute(builder: (context) {
              var amortization = AmortizationPage(tipo: 0);
              return amortization;
            })),
            color: primaryColor,
            textColor: Colors.white,
            child: Padding(
              padding: EdgeInsets.all(paddingAll(medida)),
              child: Text('+  Ver amortización',
                  style: TextStyle(fontSize: letraTextoTamanno(medida))),
            ),
          ),
        ),
      ],
    );
  }

  Widget _pago(medida, context) {
    var provider = Provider.of<CreditSimulatorService>(context).getValor;
    return Container(
      color: primaryColor,
      padding: EdgeInsets.all(paddingAll(medida)),
      child: TextField(
        inputFormatters: [
          WhitelistingTextInputFormatter.digitsOnly,
          CurrencyInputFormatter(context)
        ],
        style:
            TextStyle(color: Colors.white, fontSize: letraTextoTamanno(medida)),
        enabled: false,
        textAlign: TextAlign.center,
        controller: cuotaController..text = '$provider',
        decoration: InputDecoration(
            suffixStyle: TextStyle(color: Colors.white),
            border: InputBorder.none,
            labelText: 'Pago:',
            filled: true,
            labelStyle: TextStyle(
                color: Colors.white, fontSize: letraTextoTamanno(medida))),
      ),
    );
  }

  Widget _textForm(
    medida,
    context,
    text,
    campo,
    controller,
    type,
    initial,
  ) {
    return Container(
      padding: EdgeInsets.all(8.0),
      decoration: BoxDecoration(
          border: Border(bottom: BorderSide(color: Colors.green[100]))),
      child: TextFormField(
        style: TextStyle(fontSize: letraTextoTamanno(medida)),
        keyboardType: type == 0 ? TextInputType.datetime : TextInputType.number,
        inputFormatters: type == 1
            ? [
                WhitelistingTextInputFormatter.digitsOnly,
                CurrencyInputFormatter(
                  context,
                )
              ]
            : type == 3 ? [WhitelistingTextInputFormatter.digitsOnly] : [],
        textAlign: TextAlign.right,
        validator: (value) {
          if (value.isEmpty ||
              (type == 2 && value.contains(',')) ||
              (type != 0 &&
                  double.parse(type == 1
                          ? value
                              .replaceAll(",", "")
                              .replaceAll(".", "")
                              .replaceAll("\$", "")
                          : value) <=
                      0)) {
            return "$text invalido";
          }
          return null;
        },
        onSaved: (valor) {
          _creditData[campo] = valor;
        },
        controller: type == 0
            ? (_creditData[campo] == ''
                ? (controller..text = initial)
                : controller)
            : controller,
        decoration: InputDecoration(
            hintStyle: TextStyle(
                color: Colors.black, fontSize: letraTextoTamanno(medida)),
            hintText: type != 0 ? initial : '',
            suffixText: type == 2 ? '%' : type == 3 ? 'Meses' : '',
            border: InputBorder.none,
            labelText: text,
            filled: true,
            labelStyle: TextStyle(
                color: primaryColor, fontSize: letraTextoTamanno(medida))),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    double medida = MediaQuery.of(context).size.height;
    return Scaffold(
        backgroundColor: Colors.white,
        body: GestureDetector(
          onTap: () {
            FocusScope.of(context).requestFocus(FocusNode());
          },
          child: SingleChildScrollView(
            child: Column(
              children: [
                Stack(
                  children: [
                    Container(
                      color: primaryColor,
                      height: MediaQuery.of(context).size.width * 0.2,
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          bottom: medida * 0.06,
                          top: medida * 0.02,
                          right: medida * 0.05,
                          left: medida * 0.05),
                      child: Card(
                          elevation: 15.0,
                          child: Container(
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    image:
                                        AssetImage('assets/img/logoctav.png'))),
                            child: Align(
                              alignment: Alignment.topCenter,
                              child: Form(
                                key: _formKey,
                                child: SingleChildScrollView(
                                  child: Column(
                                    children: [
                                      _textForm(
                                          medida,
                                          context,
                                          'Valor del crédito:',
                                          'valor',
                                          valorController,
                                          1,
                                          '\$ 0.00'),
                                      _textForm(
                                          medida,
                                          context,
                                          'Tasa de interés:',
                                          'interes',
                                          interesController,
                                          2,
                                          '0 '),
                                      _textForm(medida, context, 'Plazo:',
                                          'plazo', plazoController, 3, '0'),
                                      GestureDetector(
                                        onTap: () => Platform.isAndroid
                                            ? _selectDate(context)
                                            : _iosDate(context),
                                        child: AbsorbPointer(
                                          child: _textForm(
                                              medida,
                                              context,
                                              'Fecha:',
                                              'fecha',
                                              fechaController,
                                              0,
                                              newFormat
                                                  .format(DateTime.now())
                                                  .toString()),
                                        ),
                                      ),
                                      _pago(medida, context),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          )),
                    ),
                  ],
                ),
                _button(medida, context),
                _clear ? _button2(medida, context) : SizedBox()
              ],
            ),
          ),
        ));
  }
}
