import '../../../util/colores.dart';
import '../../../util/icon_msg_back.dart';
import 'package:flutter/material.dart';

class NoticiasPage extends StatelessWidget {
  Widget _card(snapshot, index, medidaReferenciaAlto) {
    return GestureDetector(
      child: Card(
        color: primaryColor,
        semanticContainer: true,
        elevation: 3,
        clipBehavior: Clip.antiAliasWithSaveLayer,
        child: Row(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Container(
                    color: Colors.white,
                    child: Image.network(
                      snapshot.data[index].ruta,
                      width: medidaReferenciaAlto >= 1000
                          ? 240
                          : medidaReferenciaAlto >= 600 ? 160 : 120,
                      height: medidaReferenciaAlto >= 1000
                          ? 200
                          : medidaReferenciaAlto >= 600 ? 150 : 100,
                    )),
              ],
            ),
            Expanded(
              flex: 6,
              child: Container(
                alignment: Alignment.center,
                color: primaryColor,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      snapshot.data[index].titulo,
                      style: TextStyle(
                          fontSize: letraTextoTamanno(medidaReferenciaAlto),
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                    SizedBox(
                      height: sizedBox(medidaReferenciaAlto),
                    ),
                    Text(
                      snapshot.data[index].fecha,
                      style: TextStyle(
                          fontSize: letraTextoTamanno(medidaReferenciaAlto),
                          color: Colors.grey),
                    ),
                    SizedBox(
                      height: (paddingAll(medidaReferenciaAlto) - 5).isNegative
                          ? 3
                          : (paddingAll(medidaReferenciaAlto) - 5),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildLista(medidaReferenciaAlto) {
    return FutureBuilder(
        future: null,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              primary: true,
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemCount: snapshot.data.length,
              itemBuilder: (BuildContext context, index) {
                return _card(snapshot, index, medidaReferenciaAlto);
              },
            );
          } else if (snapshot.hasError) {
            return iconMsgBack(
                medidaReferenciaAlto, Icons.error, 'Ha ocurrido un error', 1);
          }
          return Center(child: iconCargando(medidaReferenciaAlto));
        });
  }

  @override
  Widget build(BuildContext context) {
    double medidaReferenciaAlto = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,
      body: _buildLista(medidaReferenciaAlto),
    );
  }
}
