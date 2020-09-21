import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class CurrencyInputFormatter extends TextInputFormatter {
  final context;

  CurrencyInputFormatter(this.context);
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    if (newValue.selection.baseOffset == 0) {
      return newValue;
    }

    double value = double.parse(newValue.text);
    //Locale locale = Localizations.localeOf(context);
    //print(locale.toString());
    final formatter = NumberFormat.simpleCurrency(locale: 'en');

    String newText = formatter.format(value / 100);

    return newValue.copyWith(
        text: newText,
        selection: new TextSelection.collapsed(offset: newText.length));
  }
}

class PercentageInputFormatter extends TextInputFormatter {
  final context;
  final type;
  PercentageInputFormatter(this.context, this.type);

  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    if (newValue.selection.baseOffset == 0) {
      return newValue;
    }

    String newText = newValue.text;

    return newValue.copyWith(
        text: type == 2 ? "$newText %" : "$newText Meses",
        selection: new TextSelection.collapsed(offset: newText.length));
  }
}
