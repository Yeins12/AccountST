import '.././util/colores.dart';
import 'package:flutter/material.dart';

//width: MediaQuery.of(context).size.height * 0.3, fit: BoxFit.fill
class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double medidaReferenciaAlto = MediaQuery.of(context).size.height;
    return Scaffold(
        backgroundColor: primaryColor,
        body: Center(
            child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                backgroundColor: primaryColor,
                backgroundImage: AssetImage('assets/img/logocta1.png'),
                radius: radius(medidaReferenciaAlto),
              ),
              SizedBox(
                height: sizedBox(medidaReferenciaAlto) + 10,
              ),
              Text(
                'Cargando...',
                style: TextStyle(
                  fontSize: letraBarTamanno(medidaReferenciaAlto) + 5,
                  color: Colors.white,
                  fontFamily: 'berlin',
                ),
              )
            ],
          ),
        )));
  }
}
