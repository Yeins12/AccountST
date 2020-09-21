import 'package:avatar_glow/avatar_glow.dart';
import '../../util/colores.dart';
import '../../util/delated_animation.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'login_page.dart';

class LoginIntroPage extends StatefulWidget {
  LoginIntroPage({Key key}) : super(key: key);

  @override
  _LoginIntroPageState createState() => _LoginIntroPageState();
}

class _LoginIntroPageState extends State<LoginIntroPage>
    with SingleTickerProviderStateMixin {
  final int delayedAmount = 10;
  double _scale;
  AnimationController _controller;
  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 200),
      lowerBound: 0.0,
      upperBound: 0.1,
    )..addListener(() {
        setState(() {});
      });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double medidaReferenciaAlto = MediaQuery.of(context).size.height;
    final color = Colors.white;
    _scale = 1 - _controller.value;
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus &&
            currentFocus.focusedChild != null) {
          FocusManager.instance.primaryFocus.unfocus();
        }
      },
      child: Scaffold(
        backgroundColor: primaryColor,
        body: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                AvatarGlow(
                  endRadius: radiusExt(medidaReferenciaAlto),
                  duration: Duration(seconds: 2),
                  glowColor: Colors.white24,
                  repeat: true,
                  repeatPauseDuration: Duration(seconds: 2),
                  startDelay: Duration(seconds: 1),
                  child: Material(
                    elevation: 8.0,
                    shape: CircleBorder(),
                    child: CircleAvatar(
                      backgroundColor: primaryColor,
                      backgroundImage: AssetImage('assets/img/logocta1.png'),
                      radius: radius(medidaReferenciaAlto),
                    ),
                  ),
                ),
                DelayedAnimation(
                  child: Text(
                    'Bienvenido a',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: letraBarTamanno(medidaReferenciaAlto) + 10,
                        color: color),
                  ),
                  delay: delayedAmount + 1000,
                ),
                SizedBox(
                  height: topLoginIntro(medidaReferenciaAlto),
                ),
                DelayedAnimation(
                  child: Text(
                    "Tu Estado de Cuenta",
                    style: TextStyle(
                        fontSize: letraBarTamanno(medidaReferenciaAlto) + 5,
                        color: color),
                  ),
                  delay: delayedAmount + 1500,
                ),
                DelayedAnimation(
                  child: Text(
                    "Virtual",
                    style: TextStyle(
                        fontSize: letraBarTamanno(medidaReferenciaAlto) + 5,
                        color: color),
                  ),
                  delay: delayedAmount + 2000,
                ),
                SizedBox(
                  height: sizedBox(medidaReferenciaAlto) + 20,
                ),
                DelayedAnimation(
                  child: GestureDetector(
                    onTapDown: _onTapDown,
                    onTapUp: _onTapUp,
                    child: Transform.scale(
                      scale: _scale,
                      child: _animatedButtonUI,
                    ),
                  ),
                  delay: delayedAmount + 2500,
                ),
                SizedBox(
                  height: topLoginIntro(medidaReferenciaAlto),
                ),
                Align(
                  alignment: FractionalOffset.bottomCenter,
                  child: DelayedAnimation(
                    child: InkWell(
                      onTap: () => _launchURL(),
                      child: Text(
                        "Visita nuestra página web",
                        style: TextStyle(
                            fontSize:
                                letraTextoTamanno(medidaReferenciaAlto) + 2,
                            color: color),
                      ),
                    ),
                    delay: delayedAmount + 3000,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _launchURL() async {
    const url = 'http://estadodecuenta.conres.com.co/';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  Widget get _animatedButtonUI => GestureDetector(
        onTap: () {
          navigationPage();
        },
        child: Container(
          height: MediaQuery.of(context).size.height * 0.08,
          width: MediaQuery.of(context).size.width * 0.8,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100), color: Colors.white),
          child: Center(
            child: Text(
              'Iniciar Sesión',
              style: TextStyle(
                fontSize:
                    letraBarTamanno(MediaQuery.of(context).size.height) + 2,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
          ),
        ),
      );
  void _onTapDown(TapDownDetails details) {
    _controller.forward();
  }

  void _onTapUp(TapUpDetails details) {
    _controller.reverse();
  }

  void navigationPage() {
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      var detalleCuenta = LoginPage();
      return detalleCuenta;
    }));
  }
}
