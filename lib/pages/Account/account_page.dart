import 'package:flutter/services.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../widgets/alert/alert_dialogo.dart';

import '../../util/icon_msg_back.dart';

import '../../models/creditDetail_model.dart';
import '../../models/dataUser_model.dart';
import '../../pages/Account/accountDetail_page.dart';
import '../../pages/Account/amortization_page.dart';
import '../../service/DataUser/dataUser_service.dart';
import '../../service/accountServices/creditDetail_service.dart';
import '../../widgets/pdfDocument/pdf_account_widget.dart';

import '../../util/colores.dart';
import 'package:flutter/material.dart';
import 'package:pdf/widgets.dart' as pw;

class AccountPage extends StatefulWidget {
  final pdf = pw.Document();

  @override
  _AccountPageState createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  double medidaReferenciaAlto;
  String cc;
  String name;
  String saldo;

  SetGetListCredit cred = new SetGetListCredit();
  Widget _expandedTitle(title, flex) {
    return Expanded(
        flex: flex,
        child: Center(
            child: Text(title,
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                    fontSize: letraTextoTamanno(medidaReferenciaAlto),
                    fontWeight: FontWeight.bold))));
  }

  Widget _cardTop() {
    return Card(
      elevation: 5,
      child: Padding(
        padding: EdgeInsets.only(
            top: paddingAll(medidaReferenciaAlto),
            bottom: paddingAll(medidaReferenciaAlto),
            right: paddingAll(medidaReferenciaAlto) + 5,
            left: paddingAll(medidaReferenciaAlto) + 5),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(
                  top: paddingAll(medidaReferenciaAlto) + 5,
                  bottom: paddingAll(medidaReferenciaAlto) + 5),
              child: Center(
                child: Text('DETALLE DE OBLIGACIONES',
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        fontSize: letraTextoTamanno(medidaReferenciaAlto),
                        fontWeight: FontWeight.bold)),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                _expandedTitle('Descripción', 2),
                _expandedTitle('Valor', 1),
                _expandedTitle('Pendiente', 1),
                SizedBox(
                  width: sizedBox(medidaReferenciaAlto) + 30,
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _expandedContainer(data, flex) {
    TextStyle es1 = TextStyle(
      fontSize: letraTextoTamanno(medidaReferenciaAlto),
    );
    return Expanded(
        flex: flex,
        child: Center(
            child: Text(
          data,
          overflow: TextOverflow.ellipsis,
          textAlign: TextAlign.center,
          style: es1,
        )));
  }

  Widget _container() {
    return Container(
        margin: EdgeInsets.only(
            top: paddingAll(medidaReferenciaAlto) + 5,
            bottom: paddingAll(medidaReferenciaAlto) + 5),
        child: FutureBuilder<CreditDetailList>(
            future: CreditDetailService().creditDetailQuery(context),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                cred.creditDetail = snapshot.data;
                return ListView.builder(
                    primary: true,
                    physics: new NeverScrollableScrollPhysics(),
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemCount: snapshot.data.creditsDetail.length,
                    itemBuilder: (BuildContext context, index) {
                      return Card(
                        color: index % 2 == 0 ? Colors.white : Colors.green[50],
                        child: ExpansionTile(
                          title: IntrinsicHeight(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                _expandedContainer(
                                    snapshot
                                        .data.creditsDetail[index].descripcion,
                                    2),
                                VerticalDivider(color: primaryColor),
                                _expandedContainer(
                                    snapshot.data.creditsDetail[index].valor,
                                    1),
                                VerticalDivider(color: primaryColor),
                                _expandedContainer(
                                    snapshot
                                        .data.creditsDetail[index].pendiente,
                                    1)
                              ],
                            ),
                          ),
                          children: [
                            Padding(
                              padding: EdgeInsets.only(
                                  right: paddingAll(medidaReferenciaAlto),
                                  left: paddingAll(medidaReferenciaAlto)),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Expanded(
                                    child: FlatButton(
                                      color: Colors.green[100],
                                      child: Text(
                                        'Detalle de cuenta',
                                        overflow: TextOverflow.ellipsis,
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            color: primaryColor,
                                            fontSize: letraTextoTamanno(
                                                medidaReferenciaAlto)),
                                      ),
                                      onPressed: () {
                                        Navigator.push(context,
                                            MaterialPageRoute(
                                                builder: (context) {
                                          var accountDetail = AccountDetailPage(
                                              creditDetail: snapshot
                                                  .data.creditsDetail[index]);
                                          return accountDetail;
                                        }));
                                      },
                                    ),
                                  ),
                                  SizedBox(
                                    width: sizedBox(medidaReferenciaAlto),
                                  ),
                                  Expanded(
                                    child: RaisedButton(
                                        child: Text(
                                          'Amortización de crédito',
                                          overflow: TextOverflow.ellipsis,
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: letraTextoTamanno(
                                                  medidaReferenciaAlto)),
                                        ),
                                        onPressed: () => Navigator.push(context,
                                                MaterialPageRoute(
                                                    builder: (context) {
                                              var amortization =
                                                  AmortizationPage(
                                                tipo: 1,
                                                nrocredito: snapshot
                                                    .data
                                                    .creditsDetail[index]
                                                    .nrocredio,
                                              );
                                              return amortization;
                                            }))),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    });
              } else if (snapshot.hasError) {
                return iconMsgBack(medidaReferenciaAlto, Icons.error,
                    'Ha ocurrido un error', 1);
              }
              return Center(child: iconCargando(medidaReferenciaAlto));
            }));
  }

  Widget _contenido() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [_cardTop(), _container()],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.blue, //or set color with: Color(0xFF0000FF)
    ));
    medidaReferenciaAlto = MediaQuery.of(context).size.height;
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: CustomScrollView(
            slivers: <Widget>[
              SliverPersistentHeader(
                pinned: true,
                floating: true,
                delegate: CustomSliverDelegate(
                    expandedHeight: heightCard(medidaReferenciaAlto),
                    user: 'widget.user',
                    medidaReferenciaAlto: medidaReferenciaAlto),
              ),
              SliverFillRemaining(child: _contenido())
            ],
          ),
        ),
        floatingActionButton: Padding(
          padding: EdgeInsets.only(
              bottom: (paddingAll(medidaReferenciaAlto) - 5).isNegative
                  ? 3
                  : (paddingAll(medidaReferenciaAlto) - 5)),
          child: FloatingActionButton(
              backgroundColor: primaryColor,
              child: Icon(Icons.file_download,
                  color: Colors.white,
                  size: tamannoIcono(medidaReferenciaAlto) - 2),
              onPressed: () async {
                var status = await Permission.storage.status;
                if (!status.isGranted) {
                  await Permission.storage.request();
                  cred.creditDetail == null
                      ? toastShow(context, 'Intenta nuevamente')
                      : PdfAccountWidget(
                              context: context,
                              creditList: cred.creditDetail,
                              medidaReferenciaAlto: medidaReferenciaAlto)
                          .pdfDownloadComplete();
                  if (status.isDenied) {
                    mostrarDialogoWidget(
                        0,
                        context,
                        'Aviso!',
                        'Parece que no puedo almacenar el documento en tu dispositivo, verifica los permisos de la app',
                        1,
                        MediaQuery.of(context).size.height);
                  }
                } else {
                  cred.creditDetail == null
                      ? toastShow(context, 'Intenta nuevamente')
                      : PdfAccountWidget(
                              context: context,
                              creditList: cred.creditDetail,
                              medidaReferenciaAlto: medidaReferenciaAlto)
                          .pdfDownloadComplete();
                }
              }),
        ),
      ),
    );
  }
}

class CustomSliverDelegate extends SliverPersistentHeaderDelegate {
  final double expandedHeight;
  final bool hideTitleWhenExpanded;
  final String user;
  final medidaReferenciaAlto;
  CustomSliverDelegate(
      {@required this.expandedHeight,
      this.hideTitleWhenExpanded = true,
      this.user,
      this.medidaReferenciaAlto});

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    final appBarSize = expandedHeight - shrinkOffset;
    //final cardTopPosition = expandedHeight / 5 - shrinkOffset;
    final proportion = 2 - (expandedHeight / appBarSize);
    final percent = proportion < 0 || proportion > 1 ? 0.0 : proportion;
    final percent2 = proportion < 0.2 || proportion > 1 ? 0.0 : proportion;

    return SizedBox(
      height: expandedHeight + expandedHeight / 2,
      child: Stack(
        children: [
          Opacity(
            opacity: percent2,
            child: Container(
              color: primaryColor,
              height: MediaQuery.of(context).size.width * 0.2,
            ),
          ),
          Positioned(
            left: 0.0,
            right: 0.0,
            top: paddingAll(medidaReferenciaAlto),
            bottom: 0.0,
            child: Opacity(
              opacity: percent,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 30 * percent),
                child: Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15)),
                  elevation: 20.0,
                  child: Stack(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage('assets/img/logoctav.png'))),
                      ),
                      Positioned.fill(
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: FutureBuilder<DataUserModel>(
                            future: DataUserService.dataUserQuery(context),
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                return SingleChildScrollView(
                                  child: Container(
                                    padding: EdgeInsets.all(
                                        paddingAll(medidaReferenciaAlto)),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: <Widget>[
                                        Center(
                                            child: Text(snapshot.data.user,
                                                overflow: TextOverflow.ellipsis,
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                    fontSize: letraTextoTamanno(
                                                            medidaReferenciaAlto) +
                                                        1,
                                                    fontFamily: 'berlin',
                                                    fontWeight:
                                                        FontWeight.bold))),
                                        SizedBox(
                                          height:
                                              sizedBox(medidaReferenciaAlto),
                                        ),
                                        Text(snapshot.data.cc,
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                              fontSize: letraTextoTamanno(
                                                  medidaReferenciaAlto),
                                            )),
                                        SizedBox(
                                          height:
                                              sizedBox(medidaReferenciaAlto) +
                                                  5,
                                        ),
                                        Row(
                                          children: <Widget>[
                                            Expanded(
                                                child: Center(
                                                    child: Text(
                                                        'Saldo Pendiente:',
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        style: TextStyle(
                                                            fontSize:
                                                                letraTextoTamanno(
                                                                    medidaReferenciaAlto),
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold)))),
                                            Expanded(
                                                child: Center(
                                                    child: Text(
                                                        snapshot
                                                            .data.totalValue,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        style: TextStyle(
                                                            fontSize:
                                                                letraTextoTamanno(
                                                                    medidaReferenciaAlto),
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold))))
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              } else if (snapshot.hasError) {
                                return Text(
                                    "Ha ocurrido un error"); //Text("${snapshot.error}");
                              }
                              return Center(child: Text('...'));
                            },
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  @override
  double get maxExtent => expandedHeight + expandedHeight / 2;

  @override
  double get minExtent => kToolbarHeight;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }
}

class SetGetListCredit {
  CreditDetailList _creditDetailList;
  // ignore: unnecessary_getters_setters
  CreditDetailList get creditDetail => _creditDetailList;

  // ignore: unnecessary_getters_setters
  set creditDetail(CreditDetailList val) {
    _creditDetailList = val;
  }
}
