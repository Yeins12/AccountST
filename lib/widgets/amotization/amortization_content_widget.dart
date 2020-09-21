import '../../util/colores.dart';
import 'package:flutter/material.dart';

Widget listViewContent(
    medidaReferenciaAlto, medidaReferenciaAncho, snapshot, tipo) {
  TextStyle es1 = TextStyle(
    fontSize: letraTextoTamanno(medidaReferenciaAlto),
  );
  TextStyle es2 = TextStyle(
      fontSize: letraTextoTamanno(medidaReferenciaAlto),
      color: Colors.orange,
      fontWeight: FontWeight.bold);
  _listTile(title, data, icon) {
    return Padding(
      padding: EdgeInsets.only(left: medidaReferenciaAncho <= xlarga ? 50 : 70),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                icon,
                color: Colors.orange,
                size: tamannoIcono(medidaReferenciaAlto),
              ),
              SizedBox(
                width: sizedBox(medidaReferenciaAlto),
              ),
              Text(title, style: es2),
            ],
          ),
          SizedBox(
            height: 5,
          ),
          Row(
            children: [
              Icon(
                icon,
                color: Colors.green[50],
              ),
              SizedBox(
                width: sizedBox(medidaReferenciaAlto),
              ),
              Text(data, style: es1),
            ],
          ),
          Divider()
        ],
      ),
    );
  }

  Widget _content(medidaReferenciaAlto, datos, index) {
    return Card(
      child: ExpansionTile(
        backgroundColor: Colors.white,
        title: Container(
          padding: EdgeInsets.fromLTRB(
              paddingAll(medidaReferenciaAlto),
              paddingAll(medidaReferenciaAlto) + 5,
              paddingAll(medidaReferenciaAlto),
              paddingAll(medidaReferenciaAlto) + 5),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              stops: [
                0.05,
                0.05,
              ],
              colors: [
                Colors.green[100],
                Colors.white,
              ],
            ),
            borderRadius: BorderRadius.all(
              Radius.circular(5.0),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(datos[index].nrocta,
                  style: TextStyle(
                      color: primaryColor,
                      fontSize: letraTextoTamanno(medidaReferenciaAlto))),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Fecha Programada: ${datos[index].fchaprog}",
                    style: es1,
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    "Total Pendiente: ${datos[index].pndntertotal}",
                    style: es1,
                  ),
                ],
              )
            ],
          ),
        ),
        children: [
          Padding(
              padding: EdgeInsets.only(
                  right: paddingAll(medidaReferenciaAlto),
                  left: paddingAll(medidaReferenciaAlto) + 5,
                  bottom: paddingAll(medidaReferenciaAlto)),
              child: Card(
                  elevation: 10,
                  color: Colors.green[50],
                  child: Column(
                    children: [
                      _listTile('Interes: ', '\$ ${datos[index].intres}',
                          Icons.show_chart),
                      _listTile('Capital: ', '\$ ${datos[index].cptal}',
                          Icons.attach_money),
                      //_listTile('Seguro: ', datos[index].seguro, Icons.assignment_ind),
                      _listTile('Valor Cuota: ', '\$ ${datos[index].vlorcta}',
                          Icons.money_off)
                    ],
                  ))),
        ],
      ),
    );
  }

  var datos = snapshot;
  return ListView.builder(
    primary: true,
    scrollDirection: Axis.vertical,
    shrinkWrap: true,
    itemCount: datos.length,
    itemBuilder: (BuildContext context, index) {
      return _content(medidaReferenciaAlto, datos, index);
    },
  );
}
