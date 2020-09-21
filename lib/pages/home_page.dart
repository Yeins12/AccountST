import '.././widgets/alert/alert_dialogo.dart';

import '../service/menuService/credit_simulator_service.dart';

import '../util/colores.dart';
import 'menu_pages/credit_simulator_page.dart';

import '../pages/Account/account_page.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

class DrawerItem {
  String title;
  String titleLong;
  IconData icon;
  DrawerItem(this.title, this.titleLong, this.icon);
}

class HomePage extends StatefulWidget {
  final drawerItems = [
    DrawerItem("Mi Cuenta", 'Tu Estado de Cuenta', Icons.home),
    DrawerItem("Simulador", 'Simulador de Crédito', Icons.computer),
    DrawerItem("Noticias", 'Noticias', Icons.public),
    DrawerItem("Notificaciones", 'Notificaciones', Icons.notifications),
  ];

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedDrawerIndex = 0;

  _getDrawerItemWidget(int pos, medidaReferenciaAlto) {
    switch (pos) {
      case 0:
        return AccountPage();
      case 1:
        return CreditSimulatorPage();
      case 2:
        return Container(
          child: Center(
            child: ListTile(
                title: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                  child: CircleAvatar(
                    backgroundColor: Colors.orange,
                    child: Center(
                        child: Icon(Icons.pan_tool, color: Colors.white)),
                  ),
                ),
                SizedBox(height: sizedBox(medidaReferenciaAlto)),
                Center(
                    child: Text(
                  'Próximamente ...',
                  style: TextStyle(
                      color: Colors.orange,
                      fontSize: letraTextoTamanno(medidaReferenciaAlto)),
                )),
              ],
            )),
          ),
        );
      case 3:
        return Container(
          child: Center(
            child: ListTile(
                title: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                  child: CircleAvatar(
                    backgroundColor: Colors.orange,
                    child: Center(
                        child: Icon(Icons.pan_tool, color: Colors.white)),
                  ),
                ),
                SizedBox(height: sizedBox(medidaReferenciaAlto)),
                Center(
                    child: Text(
                  'Próximamente ...',
                  style: TextStyle(
                      color: Colors.orange,
                      fontSize: letraTextoTamanno(medidaReferenciaAlto)),
                )),
              ],
            )),
          ),
        );

      default:
        return Text("Error");
    }
  }

  _onSelectItem(int index) {
    setState(() => _selectedDrawerIndex = index);
    Navigator.of(context).pop(); // close the drawer
    if (Provider.of<CreditSimulatorService>(context, listen: false).getValor !=
        '\$ 0,00') {
      Provider.of<CreditSimulatorService>(context, listen: false).restar();
    }
  }

  @override
  Widget build(BuildContext context) {
    double medidaReferenciaAlto = MediaQuery.of(context).size.height;
    double medidaReferenciaAncho = MediaQuery.of(context).size.width;
    List<Widget> drawerOptions = [];
    for (var i = 0; i < widget.drawerItems.length; i++) {
      var d = widget.drawerItems[i];
      drawerOptions.add(ListTile(
          title: Card(
            color: i == _selectedDrawerIndex ? primaryColor : Colors.white,
            elevation: 5,
            child: buildMenuItem(
                medidaReferenciaAlto, _selectedDrawerIndex, d.icon, d.title,
                opacity: 1.0,
                color: i == _selectedDrawerIndex ? Colors.white : primaryColor),
          ),
          selected: i == _selectedDrawerIndex,
          onTap: () => WidgetsBinding.instance.addPostFrameCallback((_) {
                _onSelectItem(i);
              })));
    }
    return Scaffold(
      appBar: AppBar(
          brightness: Brightness.dark,
          iconTheme: IconThemeData(color: Colors.white),
          actions: [
            IconButton(
                color: Colors.white,
                icon: Icon(
                  Icons.exit_to_app,
                  size: tamannoIcono(medidaReferenciaAlto),
                ),
                onPressed: () =>
                    mostrarDialogoCerrar(context, medidaReferenciaAlto)),
          ],
          centerTitle: true,
          backgroundColor: primaryColor,
          elevation: 0.0,
          title: Text(
            widget.drawerItems[_selectedDrawerIndex].titleLong,
            style: TextStyle(
              fontSize: letraBarTamanno(medidaReferenciaAlto),
              color: Colors.white,
              fontFamily: 'berlin',
            ),
          )),
      drawer: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/img/logoctav.png'),
                alignment: Alignment.topCenter),
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(
                  radioMenu(medidaReferenciaAlto, medidaReferenciaAncho)),
              bottomRight: Radius.circular(
                  radioMenu(medidaReferenciaAlto, medidaReferenciaAncho)),
            )),
        width: menuSize(medidaReferenciaAlto),
        child: Center(
          child: ListView(
            shrinkWrap: true,
            children: <Widget>[
              FlatButton.icon(
                icon: Icon(
                  Icons.arrow_back,
                  color: primaryColor,
                ),
                onPressed: null,
                label: Text("Volver",
                    style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: letraTextoTamanno(medidaReferenciaAlto),
                        color: Colors.black)),
                color: Colors.black,
              ),
              Column(children: drawerOptions),
              Container(
                margin: EdgeInsets.only(right: 10, left: 10),
                padding: EdgeInsets.only(
                    top: paddingAll(medidaReferenciaAlto),
                    bottom: paddingAll(medidaReferenciaAlto)),
                child: GestureDetector(
                  onTap: () =>
                      mostrarDialogoCerrar(context, medidaReferenciaAlto),
                  child: Card(
                    color: Color.fromRGBO(35, 182, 116, 0.5),
                    child: Padding(
                      padding: EdgeInsets.all(paddingAll(medidaReferenciaAlto)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Icon(
                            Icons.exit_to_app,
                            color: Colors.white,
                          ),
                          SizedBox(
                            width: sizedBox(medidaReferenciaAlto),
                          ),
                          Text('Salir',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize:
                                      letraTextoTamanno(medidaReferenciaAlto))),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      body: _getDrawerItemWidget(_selectedDrawerIndex, medidaReferenciaAlto),
    );
  }

  Opacity buildMenuItem(
      medidaReferenciaAlto, int selected, IconData icon, String title,
      {double opacity = 0.3, Color color = Colors.black}) {
    return Opacity(
      opacity: opacity,
      child: Center(
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 20.0,
            ),
            Icon(
              icon,
              size: 35.0,
              color: color,
            ),
            SizedBox(
              height: 10.0,
            ),
            Text(title,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: letraTextoTamanno(medidaReferenciaAlto),
                    color: color)),
            SizedBox(
              height: 10.0,
            ),
          ],
        ),
      ),
    );
  }
}
