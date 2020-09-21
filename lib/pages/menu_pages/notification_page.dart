import '../../util/icon_msg_back.dart';

import '../../util/colores.dart';
import 'package:flutter/material.dart';

class NotificationPage extends StatelessWidget {
  const NotificationPage({Key key}) : super(key: key);

  Widget _card(snapshot, index, context) {
    final medidaReferencia = MediaQuery.of(context).size.width;
    return Card(
        elevation: 3,
        child: ListTile(
          leading: CircleAvatar(
            radius: medidaReferencia >= 1000
                ? 40
                : medidaReferencia >= 600 ? 25 : 20,
            backgroundColor: primaryColor,
            backgroundImage: AssetImage('assets/img/logoverde.png'),
          ),
          title: snapshot[index].title,
          subtitle: snapshot[index].descripcion,
          trailing: snapshot[index].hora,
        ));
  }

  Widget _buildLista(context) {
    double medidaReferenciaAlto = MediaQuery.of(context).size.height;
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
                return _card(snapshot, index, context);
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
    return Scaffold(
      backgroundColor: Colors.white,
      body: _buildLista(context),
    );
  }
}
