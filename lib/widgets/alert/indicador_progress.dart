import 'package:flutter/material.dart';
import 'dart:async';

class IndicadorProgreso extends PopupRoute {
  /*
  * Show message.
  * */
  static Future<void> showMessage(BuildContext context, String message) async {
    try {
      if (_currentHud != null) {
        _currentHud.navigator.pop();
      }
      IndicadorProgreso hud = IndicadorProgreso();
      hud.message = message;
      _currentHud = hud;
      Navigator.push(context, hud);
      Future.delayed(hud.delayed).then((val) {
        _currentHud.navigator.pop();
        _currentHud = null;
      });
    } catch (e) {
      _currentHud = null;
    }
  }

  /*
  * show an hud.
  * when you want to do anything, you can call this show.
  * for example： begin network request
  * */
  static Future<void> show(BuildContext context) async {
    try {
      if (_currentHud != null) {
        _currentHud.navigator.pop();
      }
      IndicadorProgreso hud = IndicadorProgreso();
      _currentHud = hud;
      Navigator.push(context, hud);
    } catch (e) {
      _currentHud = null;
    }
  }

  /*
  * hide hud
  * when you complete something,you can call this hide to hide hud.
  * */
  static Future<void> hide() async {
    try {
      _currentHud.navigator.pop();
      _currentHud = null;
    } catch (e) {
      _currentHud = null;
    }
  }

// hud show this message, default null. when you set ,it will show message hud, not progress hud.
  String message;
  Color progressColor = Colors.orange;
  Color progressBackgroundColor = Colors.transparent;
  Color coverColor = Color.fromRGBO(0, 0, 0, 0.4);
  Duration delayed = Duration(milliseconds: 2000);
  TextStyle loadingTextStyle = TextStyle(
      fontSize: 15.0,
      color: Colors.white,
      fontWeight: FontWeight.bold,
      decoration: TextDecoration.none);
  TextStyle messageTextStyle = TextStyle(
      fontSize: 14.0,
      color: Colors.black87,
      fontWeight: FontWeight.w500,
      decoration: TextDecoration.none);

  String loadingMessage = 'Cargando ...';

  static IndicadorProgreso _currentHud;

  @override
  Color get barrierColor => null;

  @override
  String get barrierLabel => null;

  @override
  Duration get transitionDuration => kThemeAnimationDuration;

  @override
  bool get barrierDismissible => true;

  @override
  Widget buildPage(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation) {
    return Container(
      color: Color.fromRGBO(0, 0, 0, 0.4),
      child: Center(
        child: _getProgress(),
      ),
    );
  }

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
    return super
        .buildTransitions(context, animation, secondaryAnimation, child);
  }

  Widget _getProgress() {
    if (message == null) {
      return Container(
        width: 120.0,
        height: 120.0,
        decoration: new BoxDecoration(
            color: Colors.white,
            borderRadius: new BorderRadius.all(new Radius.circular(20))),
        child: Center(
            child: Image.asset(
          'assets/img/logo.gif',
          height: 100,
          width: 100,
        )),
      );
    } else {
      return Container(
        margin: EdgeInsets.all(20),
        padding: EdgeInsets.all(20),
        decoration: new BoxDecoration(
            color: Colors.white,
            borderRadius: new BorderRadius.all(new Radius.circular(10))),
        child: Text(
          message,
          style: messageTextStyle,
        ),
      );
    }
  }
}
