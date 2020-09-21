import '../../service/login_service.dart';
import 'package:get/get.dart';

import '../../util/alert_dialog_base.dart';
import 'package:toast/toast.dart';
import '../../util/colores.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

_volver1(context) {
  Navigator.of(context).pop();
}

_volver2(context) {
  Navigator.of(context).pop();
  Navigator.of(context).pop();
}

toastShow(context, texto) {
  Toast.show(texto, context,
      duration: Toast.LENGTH_LONG,
      gravity: Toast.BOTTOM,
      backgroundColor: primaryColor);
}

mostrarDialogoWidget(int tipo, context, String titulo, String pregunta, accion,
    medidaReferenciaAlto) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return PlatformAlertDialog(
        title: Text(titulo),
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              Text(
                pregunta,
                style: TextStyle(
                    fontSize: letraTextoTamanno(medidaReferenciaAlto)),
              ),
            ],
          ),
        ),
        actions: <Widget>[
          tipo == 1
              ? PlatformDialogAction(
                  child: Text('Cancelar'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                )
              : SizedBox(),
          PlatformDialogAction(
            child: Text('Aceptar'),
            actionType: ActionType.Preferred,
            onPressed: () {
              //mostarDialogo una
              accion == 1 ? _volver1(context) : _volver2(context);
            },
          ),
        ],
      );
    },
  );
}

mostrarDialogoCerrar(BuildContext context, medidaReferenciaAlto) {
  showDialog<void>(
    context: context,
    builder: (BuildContext context) {
      return PlatformAlertDialog(
        title: Text('Cerrar sesión'),
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              Text('¿Desea cerrar sesión?',
                  style: TextStyle(
                      fontSize: letraTextoTamanno(medidaReferenciaAlto))),
            ],
          ),
        ),
        actions: <Widget>[
          PlatformDialogAction(
            child: Text('Cancelar'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          PlatformDialogAction(
            child: Text('Aceptar'),
            actionType: ActionType.Preferred,
            onPressed: () {
              Navigator.of(context).pop();
              Provider.of<LoginService>(context, listen: false).logout();
            },
          ),
        ],
      );
    },
  );
}

widgetDialogo(message, tipo) {
  return PlatformAlertDialog(
    title: Text(tipo == 0
        ? message['notification']['title']
        : message['data']['title']),
    content: SingleChildScrollView(
      child: ListBody(
        children: <Widget>[
          // Text('Señor(a): '+message['data']['usuario']),
          Text(tipo == 0
              ? message['notification']['body']
              : message['data']['body']),
          // Text('Remitente: '+message['data']['origen']),
        ],
      ),
    ),
    actions: <Widget>[
      PlatformDialogAction(
        child: Text('Cancelar'),
        onPressed: () {
          Get.back();
        },
      ),
      PlatformDialogAction(
        child: Text('Aceptar'),
        actionType: ActionType.Preferred,
        onPressed: () {
          Get.back();
        },
      ),
    ],
  );
}

widgetDialogoNo(destino) {
  return PlatformAlertDialog(
    title: Text('Nueva Notificación'),
    content: SingleChildScrollView(
      child: ListBody(
        children: <Widget>[
          // Text('Señor(a): '+message['data']['usuario']),
          Text('Ha recibido una notificación en su usuario de ' +
              destino +
              ', inicie sesión para la visualización.'),
          // Text('Remitente: '+message['data']['origen']),
        ],
      ),
    ),
    actions: <Widget>[
      PlatformDialogAction(
        child: Text('Cancelar'),
        onPressed: () {
          Get.back();
        },
      ),
      PlatformDialogAction(
        child: Text('Aceptar'),
        actionType: ActionType.Preferred,
        onPressed: () {
          Get.back();
        },
      ),
    ],
  );
}
