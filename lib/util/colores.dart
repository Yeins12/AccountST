import 'package:flutter/material.dart';
import 'flutter_colors.dart';

//ldpi
int xpequenna = 360;
//mdpi
int pequenna = 430;
//tvdpi
int mediana = 480;
//hdpi
int larga = 600;
//xhdpi
int xlarga = 719; //revisar para menor a 630
//xxhdpi
int xxlarga = 839;
//xxxhdpi
int xxxlarga = 959;
int xxxxlarga = 1025;
int xxxxxlarga =
    1279; //1366 agregar padding a detalle separacion de lista, botón de calcular y amortización
int xxxxxxlarga = 1439;
int xxxxxxxlarga = 1599;
int xxxxxxxxlarga = 1919;

Color circuloColor = FlutterColor("#032f55");
Color primaryColor = FlutterColor("#23b674");
Color colorVerdeClaro = FlutterColor("#63e6ab");
Color colorVerdeCard = FlutterColor("#8cb9a5");
Color colorVerdeLogin = FlutterColor("#1bb25b");
Color colorCajaTexto = FlutterColor("#96e098");
Color iconoVerde = FlutterColor("#12470e");
//top
radioMenu(medidaReferenciaAlto, medidaReferenciaAncho) {
  double medida = medidaReferenciaAlto <= xpequenna
      ? 5
      : medidaReferenciaAlto < pequenna
          ? 10
          : //probado
          medidaReferenciaAlto < mediana
              ? 30
              : //---probado 592
              medidaReferenciaAlto <= larga
                  ? 30
                  : //probado
                  medidaReferenciaAlto <= xlarga
                      ? 50
                      : //probado
                      medidaReferenciaAlto <= xxlarga
                          ? 50
                          : medidaReferenciaAlto <= xxxlarga
                              ? medidaReferenciaAncho <= pequenna ? 50 : 50
                              : //probado
                              medidaReferenciaAlto <= xxxxlarga
                                  ? 50
                                  : medidaReferenciaAlto <= xxxxxlarga
                                      ? 50
                                      : medidaReferenciaAlto <= xxxxxxlarga
                                          ? 50
                                          : 50;

  return medida;
}

tileSize(medidaReferenciaAlto, medidaReferenciaAncho) {
  double medida = medidaReferenciaAlto <= xpequenna
      ? letraBarTamanno(medidaReferenciaAlto) + 10
      : medidaReferenciaAlto < pequenna
          ? letraBarTamanno(medidaReferenciaAlto) + 11
          : //probado
          medidaReferenciaAlto < mediana
              ? letraBarTamanno(medidaReferenciaAlto) + 14
              : //---probado 592
              medidaReferenciaAlto <= larga
                  ? letraBarTamanno(medidaReferenciaAlto) + 18
                  : //probado
                  medidaReferenciaAlto <= xlarga
                      ? letraBarTamanno(medidaReferenciaAlto) + 20
                      : //probado
                      medidaReferenciaAlto <= xxlarga
                          ? letraBarTamanno(medidaReferenciaAlto) + 22
                          : medidaReferenciaAlto <= xxxlarga
                              ? medidaReferenciaAncho <= pequenna
                                  ? letraBarTamanno(medidaReferenciaAlto) + 15
                                  : letraBarTamanno(medidaReferenciaAlto) + 24
                              : //probado
                              medidaReferenciaAlto <= xxxxlarga
                                  ? letraBarTamanno(medidaReferenciaAlto) + 26
                                  : medidaReferenciaAlto <= xxxxxlarga
                                      ? letraBarTamanno(medidaReferenciaAlto) +
                                          32
                                      : medidaReferenciaAlto <= xxxxxxlarga
                                          ? letraBarTamanno(
                                                  medidaReferenciaAlto) +
                                              36
                                          : letraBarTamanno(
                                                  medidaReferenciaAlto) +
                                              18;
  return medida;
}

menuSize(medidaReferenciaAlto) {
  double medida = medidaReferenciaAlto <= xpequenna
      ? 180
      : medidaReferenciaAlto < pequenna
          ? 180
          : //probado
          medidaReferenciaAlto < mediana
              ? 180
              : //---probado 592
              medidaReferenciaAlto <= larga
                  ? 180
                  : //probado
                  medidaReferenciaAlto <= xlarga
                      ? 180
                      : //probado
                      medidaReferenciaAlto <= xxlarga
                          ? 180
                          : medidaReferenciaAlto <= xxxlarga
                              ? 200
                              : //probado
                              medidaReferenciaAlto <= xxxxlarga
                                  ? 250
                                  : medidaReferenciaAlto <= xxxxxlarga
                                      ? 250
                                      : medidaReferenciaAlto <= xxxxxxlarga
                                          ? 250
                                          : 180;
  return medida;
}

creditSize(medidaReferenciaAlto) {
  double medida = medidaReferenciaAlto <= xpequenna
      ? medidaReferenciaAlto * 0.8
      : medidaReferenciaAlto < pequenna
          ? medidaReferenciaAlto * 0.9 //426
          : //probado
          medidaReferenciaAlto < mediana
              ? medidaReferenciaAlto * 0.8
              : //---probado 592
              medidaReferenciaAlto <= larga
                  ? medidaReferenciaAlto * 0.8
                  : //probado
                  medidaReferenciaAlto <= xlarga
                      ? medidaReferenciaAlto * 0.7
                      : //probado
                      medidaReferenciaAlto <= xxlarga
                          ? medidaReferenciaAlto * 0.6
                          : medidaReferenciaAlto <= xxxlarga
                              ? medidaReferenciaAlto * 0.6
                              : //probado
                              medidaReferenciaAlto <= xxxxlarga
                                  ? medidaReferenciaAlto * 0.6
                                  : medidaReferenciaAlto <= xxxxxlarga
                                      ? medidaReferenciaAlto * 0.5
                                      : medidaReferenciaAlto <= xxxxxxlarga
                                          ? medidaReferenciaAlto * 0.5
                                          : medidaReferenciaAlto * 0.8;
  return medida;
}

paddingTop(medidaReferenciaAlto) {
  double medida = medidaReferenciaAlto <= xpequenna
      ? paddingAll(medidaReferenciaAlto) * 6
      : medidaReferenciaAlto < pequenna
          ? paddingAll(medidaReferenciaAlto) * 6
          : //probado
          medidaReferenciaAlto < mediana
              ? paddingAll(medidaReferenciaAlto) * 7
              : //---probado 592
              medidaReferenciaAlto <= larga
                  ? paddingAll(medidaReferenciaAlto) * 8
                  : //probado
                  medidaReferenciaAlto <= xlarga
                      ? paddingAll(medidaReferenciaAlto) * 9
                      : //probado
                      medidaReferenciaAlto <= xxlarga
                          ? paddingAll(medidaReferenciaAlto) * 9
                          : medidaReferenciaAlto <= xxxlarga
                              ? paddingAll(medidaReferenciaAlto) * 9
                              : //probado
                              medidaReferenciaAlto <= xxxxlarga
                                  ? paddingAll(medidaReferenciaAlto) * 9
                                  : medidaReferenciaAlto <= xxxxxlarga
                                      ? paddingAll(medidaReferenciaAlto) * 9
                                      : medidaReferenciaAlto <= xxxxxxlarga
                                          ? paddingAll(medidaReferenciaAlto) * 9
                                          : paddingAll(medidaReferenciaAlto) *
                                              8;
  return medida;
}

radiusExt(medidaReferenciaAlto) {
  double medida = medidaReferenciaAlto <= xpequenna
      ? 30
      : medidaReferenciaAlto < pequenna
          ? 40
          : //probado
          medidaReferenciaAlto < mediana
              ? 50
              : //---probado 592
              medidaReferenciaAlto <= larga
                  ? 60
                  : //probado
                  medidaReferenciaAlto <= xlarga
                      ? 70
                      : //probado
                      medidaReferenciaAlto <= xxlarga
                          ? 80
                          : medidaReferenciaAlto <= xxxlarga
                              ? 110
                              : //probado
                              medidaReferenciaAlto <= xxxxlarga
                                  ? 120
                                  : medidaReferenciaAlto <= xxxxxlarga
                                      ? 130
                                      : medidaReferenciaAlto <= xxxxxxlarga
                                          ? 180
                                          : 90;
  return medida;
}

radius(medidaReferenciaAlto) {
  double medida = medidaReferenciaAlto <= xpequenna
      ? 30
      : medidaReferenciaAlto < pequenna
          ? 20
          : //probado
          medidaReferenciaAlto < mediana
              ? 30
              : //---probado 592
              medidaReferenciaAlto <= larga
                  ? 40
                  : //probado
                  medidaReferenciaAlto <= xlarga
                      ? 50
                      : //probado
                      medidaReferenciaAlto <= xxlarga
                          ? 50
                          : medidaReferenciaAlto <= xxxlarga
                              ? 70
                              : //probado
                              medidaReferenciaAlto <= xxxxlarga
                                  ? 70
                                  : medidaReferenciaAlto <= xxxxxlarga
                                      ? 70
                                      : medidaReferenciaAlto <= xxxxxxlarga
                                          ? 100
                                          : 50;
  return medida;
}

topLoginIntro(medidaReferenciaAlto) {
  double medida = medidaReferenciaAlto <= xpequenna
      ? medidaReferenciaAlto * 0.08
      : medidaReferenciaAlto < pequenna
          ? medidaReferenciaAlto * 0.09
          : //probado
          medidaReferenciaAlto < mediana
              ? medidaReferenciaAlto * 0.10
              : //---probado 592
              medidaReferenciaAlto <= larga
                  ? medidaReferenciaAlto * 0.12
                  : //probado
                  medidaReferenciaAlto <= xlarga
                      ? medidaReferenciaAlto * 0.12
                      : //probado
                      medidaReferenciaAlto <= xxlarga
                          ? medidaReferenciaAlto * 0.14
                          : medidaReferenciaAlto <= xxxlarga
                              ? medidaReferenciaAlto * 0.14
                              : //probado
                              medidaReferenciaAlto <= xxxxlarga
                                  ? medidaReferenciaAlto * 0.14
                                  : medidaReferenciaAlto <= xxxxxlarga
                                      ? medidaReferenciaAlto * 0.14
                                      : medidaReferenciaAlto <= xxxxxxlarga
                                          ? medidaReferenciaAlto * 0.12
                                          : 0.15;
  return medida;
}

//Icono Login
iconLogin(medidaReferenciaAlto, medidaReferenciaAncho) {
  double medida = medidaReferenciaAlto < xpequenna
      ? medidaReferenciaAlto * 0.3
      : medidaReferenciaAlto < pequenna
          ? medidaReferenciaAlto * 0.33
          : //probado
          medidaReferenciaAlto < mediana
              ? medidaReferenciaAlto * 0.33
              : //--probadao
              medidaReferenciaAlto <= larga
                  ? medidaReferenciaAlto * 0.33
                  : //probado
                  medidaReferenciaAlto <= xlarga
                      ? medidaReferenciaAlto * 0.33
                      : //probado
                      medidaReferenciaAlto <= xxlarga
                          ? medidaReferenciaAlto * 0.33
                          : medidaReferenciaAlto <= xxxlarga
                              ? medidaReferenciaAlto * 0.33
                              : //probado
                              medidaReferenciaAlto <= xxxxlarga
                                  ? medidaReferenciaAlto * 0.33
                                  : medidaReferenciaAlto <= xxxxxlarga
                                      ? medidaReferenciaAlto * 0.33
                                      : medidaReferenciaAlto <= xxxxxxlarga
                                          ? medidaReferenciaAlto * 0.33
                                          : 50;

  return medida;
}

paddingAll(medidaReferenciaAlto) {
  double medida = medidaReferenciaAlto < xpequenna
      ? 3
      : medidaReferenciaAlto < pequenna
          ? 5
          : medidaReferenciaAlto < mediana
              ? 5
              : medidaReferenciaAlto <= larga
                  ? 6
                  : medidaReferenciaAlto <= xlarga
                      ? 7
                      : medidaReferenciaAlto <= xxlarga
                          ? 8
                          : medidaReferenciaAlto <= xxxlarga
                              ? 10
                              : medidaReferenciaAlto <= xxxxlarga
                                  ? 12
                                  : medidaReferenciaAlto <= xxxxxlarga
                                      ? 13
                                      : //establecido
                                      medidaReferenciaAlto <= xxxxxxlarga
                                          ? 15
                                          : 15;

  return medida;
}

letraTextoTamanno(medidaReferenciaAlto) {
  double medida = medidaReferenciaAlto < xpequenna
      ? 12
      : //probado
      medidaReferenciaAlto < pequenna
          ? 12
          : //probado
          medidaReferenciaAlto < mediana
              ? 12
              : medidaReferenciaAlto < 540
                  ? 12
                  : //probado
                  medidaReferenciaAlto <= larga
                      ? 13
                      : //--
                      medidaReferenciaAlto <= xlarga
                          ? 13
                          : //Probado 640
                          medidaReferenciaAlto <= xxlarga
                              ? 15
                              : medidaReferenciaAlto <= xxxlarga
                                  ? 17
                                  : //establecido
                                  medidaReferenciaAlto <= xxxxlarga
                                      ? 19
                                      : medidaReferenciaAlto <= xxxxxlarga
                                          ? 22
                                          : medidaReferenciaAlto <= xxxxxxlarga
                                              ? 25
                                              : 20;

  return medida;
}

tamannoIcono(medidaReferenciaAlto) {
  double medida = medidaReferenciaAlto < xpequenna
      ? 19
      : medidaReferenciaAlto < pequenna
          ? 20
          : //probado
          medidaReferenciaAlto < mediana
              ? 20
              : medidaReferenciaAlto <= larga
                  ? 20
                  : medidaReferenciaAlto <= xlarga
                      ? 20
                      : //probado 640
                      medidaReferenciaAlto <= xxlarga
                          ? 22
                          : medidaReferenciaAlto <= xxxlarga
                              ? 27
                              : //probadp 913
                              medidaReferenciaAlto <= xxxxlarga
                                  ? 27
                                  : medidaReferenciaAlto <= xxxxxlarga
                                      ? 30
                                      : medidaReferenciaAlto <= xxxxxxlarga
                                          ? 32
                                          : 27;

  return medida;
}

sizedBox(medidaReferenciaAlto) {
  double medida = medidaReferenciaAlto < xpequenna
      ? 5
      : //probado 320 hor
      medidaReferenciaAlto < pequenna
          ? 7
          : medidaReferenciaAlto < mediana
              ? 7
              : medidaReferenciaAlto <= larga
                  ? 7
                  : medidaReferenciaAlto <= xlarga
                      ? 7
                      : //probado 640 v
                      medidaReferenciaAlto <= xxlarga
                          ? 8
                          : medidaReferenciaAlto <= xxxlarga
                              ? 8
                              : medidaReferenciaAlto <= xxxxlarga
                                  ? 20
                                  : medidaReferenciaAlto <= xxxxxlarga
                                      ? 25
                                      : medidaReferenciaAlto <= xxxxxxlarga
                                          ? 30
                                          : 35;

  return medida;
}

creditContent(medidaReferenciaAlto) {
  double medida = medidaReferenciaAlto < xpequenna
      ? 5
      : //probado 320 hor
      medidaReferenciaAlto < pequenna
          ? medidaReferenciaAlto * .40
          : medidaReferenciaAlto < mediana
              ? medidaReferenciaAlto * .40
              : medidaReferenciaAlto <= larga
                  ? medidaReferenciaAlto * .85
                  : medidaReferenciaAlto <= xlarga
                      ? medidaReferenciaAlto * .40
                      : //probado 640 v
                      medidaReferenciaAlto <= xxlarga
                          ? medidaReferenciaAlto * .40
                          : medidaReferenciaAlto <= xxxlarga
                              ? medidaReferenciaAlto * .35
                              : medidaReferenciaAlto <= xxxxlarga
                                  ? medidaReferenciaAlto * .35
                                  : medidaReferenciaAlto <= xxxxxlarga
                                      ? medidaReferenciaAlto * .35
                                      : medidaReferenciaAlto <= xxxxxxlarga
                                          ? medidaReferenciaAlto * .35
                                          : medidaReferenciaAlto * .35;

  return medida;
}

topContent(medidaReferenciaAlto) {
  double medida = medidaReferenciaAlto < xpequenna
      ? 5
      : //probado 320 hor
      medidaReferenciaAlto < pequenna
          ? medidaReferenciaAlto * .42
          : medidaReferenciaAlto < mediana
              ? medidaReferenciaAlto * .40
              : medidaReferenciaAlto <= larga
                  ? medidaReferenciaAlto * .35 //588
                  : medidaReferenciaAlto <= xlarga
                      ? medidaReferenciaAlto * .30
                      : //por defecto 30
                      medidaReferenciaAlto <= xxlarga
                          ? medidaReferenciaAlto * .30
                          : medidaReferenciaAlto <= xxxlarga
                              ? medidaReferenciaAlto * .28
                              : medidaReferenciaAlto <= xxxxlarga
                                  ? medidaReferenciaAlto * .32
                                  : medidaReferenciaAlto <= xxxxxlarga
                                      ? medidaReferenciaAlto * .35
                                      : medidaReferenciaAlto <= xxxxxxlarga
                                          ? medidaReferenciaAlto * .35
                                          : medidaReferenciaAlto * .25;

  return medida;
}

heightContent(medidaReferenciaAlto) {
  double medida = medidaReferenciaAlto < xpequenna
      ? 60
      : //probado 320 hor
      medidaReferenciaAlto < pequenna
          ? medidaReferenciaAlto * .50
          : medidaReferenciaAlto < mediana
              ? medidaReferenciaAlto * .50
              : medidaReferenciaAlto <= larga
                  ? medidaReferenciaAlto * .40
                  : medidaReferenciaAlto <= xlarga
                      ? medidaReferenciaAlto * .38
                      : //probado 640 v
                      medidaReferenciaAlto <= xxlarga
                          ? medidaReferenciaAlto * .35
                          : medidaReferenciaAlto <= xxxlarga
                              ? medidaReferenciaAlto * .35
                              : medidaReferenciaAlto <= xxxxlarga
                                  ? medidaReferenciaAlto * .35
                                  : medidaReferenciaAlto <= xxxxxlarga
                                      ? medidaReferenciaAlto * .35
                                      : medidaReferenciaAlto <= xxxxxxlarga
                                          ? medidaReferenciaAlto * .35
                                          : medidaReferenciaAlto * .35;

  return medida;
}

heightCard(medidaReferenciaAlto) {
  double medida = medidaReferenciaAlto < xpequenna
      ? 80
      : //probado 320 hor
      medidaReferenciaAlto < pequenna
          ? 70
          : medidaReferenciaAlto < mediana
              ? 80
              : medidaReferenciaAlto <= larga
                  ? 80
                  : medidaReferenciaAlto <= xlarga
                      ? 80
                      : //probado 640 v
                      medidaReferenciaAlto <= xxlarga
                          ? 80
                          : medidaReferenciaAlto <= xxxlarga //probado en 887
                              ? 120
                              : medidaReferenciaAlto <= xxxxlarga
                                  ? 125
                                  : medidaReferenciaAlto <= xxxxxlarga
                                      ? 150
                                      : medidaReferenciaAlto <= xxxxxxlarga
                                          ? 180
                                          : 80;

  return medida;
}

letraBarTamanno(medidaReferenciaAlto) {
  double medida = medidaReferenciaAlto < xpequenna
      ? 18
      : medidaReferenciaAlto < pequenna
          ? 18
          : medidaReferenciaAlto < mediana
              ? 18
              : medidaReferenciaAlto <= larga
                  ? 19
                  : //probado
                  medidaReferenciaAlto <= xlarga
                      ? 19
                      : //probado
                      medidaReferenciaAlto <= xxlarga
                          ? 20
                          : medidaReferenciaAlto <= xxxlarga
                              ? 21
                              : //probadp 913
                              medidaReferenciaAlto <= xxxxlarga
                                  ? 21
                                  : medidaReferenciaAlto <= xxxxxlarga
                                      ? 21
                                      : medidaReferenciaAlto <= xxxxxxlarga
                                          ? 30
                                          : 20;

  return medida;
}

tamannoIconoBack(medidaReferenciaAlto) {
  double medida = medidaReferenciaAlto >= 1000
      ? 150
      : medidaReferenciaAlto >= 600
          ? 140
          : medidaReferenciaAlto >= 400 ? 130 : 110;

  return medida;
}

tammannoIconoCargando(medidaReferenciaAlto) {
  double medida = medidaReferenciaAlto < xpequenna
      ? 60
      : medidaReferenciaAlto < pequenna
          ? 60
          : //Probada
          medidaReferenciaAlto < mediana
              ? 60
              : medidaReferenciaAlto <= larga
                  ? 80
                  : //probada
                  medidaReferenciaAlto <= xlarga
                      ? 80
                      : //probada 065 640
                      medidaReferenciaAlto <= xxlarga
                          ? 90
                          : medidaReferenciaAlto <= xxxlarga
                              ? 100
                              : //probado en 913
                              medidaReferenciaAlto <= xxxxlarga
                                  ? 150
                                  : medidaReferenciaAlto <= xxxxxlarga
                                      ? 150
                                      : //probada
                                      medidaReferenciaAlto <= xxxxxxlarga
                                          ? 150
                                          : 90;

  return medida;
}
