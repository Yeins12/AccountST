import 'dart:math';
import '../../models/amortization_model.dart';
import '../../util/time_convert.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';

class CreditSimulatorService with ChangeNotifier {
  @override
  void dispose() {
    super.dispose();
  }

  String _val = '\$ 0,00';
  List<AmortizationModel> _listado = [];
  String get getValor {
    return _val;
  }

  List<AmortizationModel> get getLista {
    return _listado;
  }

  restar() {
    _val = '\$ 0,00';
    _listado = [];
    notifyListeners();
  }

  calculationProcess(
      context, double valor, double interes, int plazo, DateTime fecha) {
    List<AmortizationModel> listado = [];
    var newFormat = DateFormat("yyyy-MM-dd");
    double cuota;
    double intrs;
    double pendiente;
    double intcuota;
    double capital;

    final formatter = NumberFormat.simpleCurrency(locale: 'en');

    intrs = interes / 100;
    interes = pow(1 + intrs, (-1) * plazo);

    cuota = (valor * intrs) / (1 - interes);
    pendiente = valor;
    fecha ?? newFormat.format(DateTime.now());
    _val = formatter.format(cuota).toString() + ' al mes';
    for (int i = 1; i <= plazo; i++) {
      DateTime fechaCuota = DateTime(fecha.year, fecha.month + i, fecha.day);
      intcuota = pendiente * intrs;
      capital = cuota - intcuota;
      pendiente = pendiente - capital;
      AmortizationModel amortizationSimulator = AmortizationModel(
          nrocta: i.toString(),
          fchaprog: fechaConvert(newFormat.format(fechaCuota).toString()),
          vlorcta: formatter.format(cuota),
          cptal: formatter.format(capital),
          intres: formatter.format(intcuota),
          pndntertotal: formatter.format(pendiente));
      listado.add(amortizationSimulator);
    }
    _listado = listado;
    notifyListeners();
    return listado;
  }
}
