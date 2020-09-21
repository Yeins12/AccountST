horaConvert(time) {
  var hour = (time.split(':'))[0];
  var min = (time.split(':'))[1];
  var part = int.parse(hour) > 12 ? 'pm' : 'am';

  min = (min + '').length == 1 ? '0$min' : min;
  hour = int.parse(hour) > 12 ? int.parse(hour) - 12 : hour;
  hour = (hour.toString() + '').length == 1
      ? '0${hour.toString()}'
      : hour.toString();

  return ('$hour:$min $part');
}

fechaConvert(fecha) {
  var arF1 = fecha.split('-');
  List meses = [
    "Ene",
    "Feb",
    "Mar",
    "Abr",
    "May",
    "Jun",
    "Jul",
    "Ago",
    "Sep",
    "Oct",
    "Nov",
    "Dic"
  ];
  var date1 =
      new DateTime(int.parse(arF1[0]), int.parse(arF1[1]), int.parse(arF1[2]));
  var fCompleta;
  if (date1.weekday == 0) {
    fCompleta = date1.day.toString() +
        " " +
        meses[date1.month - 1] +
        " (" +
        date1.year.toString() +
        ")";
  } else {
    fCompleta = date1.day.toString() +
        " " +
        meses[date1.month - 1] +
        " (" +
        date1.year.toString() +
        ")";
  }
  return fCompleta;
}

exponentialConvert() {}
