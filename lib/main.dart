import 'package:cevapla/Animations/FadeAnimation.dart';
import 'package:cevapla/answer.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

void main() =>
    runApp(MaterialApp(debugShowCheckedModeBanner: false, home: HomePage()));

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  AnimationController _scaleController;
  AnimationController _scale2Controller;
  AnimationController _widthController;
  AnimationController _positionController;

  Animation<double> _scaleAnimation;
  Animation<double> _scale2Animation;
  Animation<double> _widthAnimation;
  Animation<double> _positionAnimation;

  bool hideIcon = false;

  @override
  void initState() {
    // implement initState
    super.initState();

    _scaleController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 300));

    _scaleAnimation =
        Tween<double>(begin: 1.0, end: 0.8).animate(_scaleController)
          ..addStatusListener((status) {
            if (status == AnimationStatus.completed) {
              _widthController.forward();
            }
          });

    _widthController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 600));

    _widthAnimation =
        Tween<double>(begin: 80.0, end: 300.0).animate(_widthController)
          ..addStatusListener((status) {
            if (status == AnimationStatus.completed) {
              _positionController.forward();
            }
          });

    _positionController = AnimationController(
        vsync: this, duration: Duration(milliseconds: 1000));

    _positionAnimation =
        Tween<double>(begin: 0.0, end: 215.0).animate(_positionController)
          ..addStatusListener((status) {
            if (status == AnimationStatus.completed) {
              setState(() {
                hideIcon = true;
              });
              _scale2Controller.forward();
            }
          });

    _scale2Controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 300));

    _scale2Animation =
        Tween<double>(begin: 1.0, end: 32.0).animate(_scale2Controller)
          ..addStatusListener((status) {
            if (status == AnimationStatus.completed) {
              Navigator.push(
                  context,
                  PageTransition(
                      type: PageTransitionType.fade, child: AnswerPage()));
            }
          });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(0, 0, 32, 0.8),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/bg.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        width: double.infinity,
        child: Stack(
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  FadeAnimation(
                      1,
                      Align(
                          alignment: Alignment.center,
                          child: Text(
                            "Ho??geldin !",
                            style: TextStyle(color: Colors.white, fontSize: 40),
                          ))),
                  SizedBox(
                    height: 23,
                  ),
                  FadeAnimation(
                      1.3,
                      Text(
                        "cevap'La ile t??m sorular??n??z??n cevab??n?? bulabilirsiniz.",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.white.withOpacity(.8),
                            height: 1.2,
                            fontSize: 18),
                      )),
                  SizedBox(
                    height: 20,
                  ),
                  Center(
                    child: new Container(
                      child: SizedBox(
                        width: 200.0,
                        height: 40.0,
                        // ignore: deprecated_member_use
                        child: RaisedButton(
                          color: Colors.grey[800],
                          child: Text(
                            "Nas??l Kullan??l??r?",
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                // return object of type Dialog
                                return AlertDialog(
                                  title: new Text("cevap'La nas??l kullan??l??r?"),
                                  content: new Text(
                                      "??zerinde ??ok d??????n??p bir t??rl?? karar veremedi??in ??eyler mi var? Baz?? sorular??n??n yan??tlar??n?? bulmakta zorlan??yor musun?\n\n O zaman, ba??lang???? ekran??nda soraca????n soruyu d??????n ya da sesli olarak s??yle. \n\nHaz??r oldu??unda ekrandaki butona t??klayarak s??reyi ba??lat. \n\nSordu??un soruya 5 saniye boyunca yo??unla??. \n \nVeee cevap kar????n??zda...\n \n??rnek soru bi??imi: 'Bug??n al????veri??e gitmeli miyim?'"),
                                  actions: <Widget>[
                                    // usually buttons at the bottom of the dialog
                                    // ignore: deprecated_member_use
                                    new FlatButton(
                                      child: new Text("anlad??m"),
                                      textColor: Colors.white,
                                      color: Colors.grey[800],
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            new BorderRadius.circular(18.0),
                                      ),
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                    ),
                                  ],
                                );
                              },
                            );
                          },
                          shape: new RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(30.0),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 250,
                  ),
                  FadeAnimation(
                      1.6,
                      AnimatedBuilder(
                        animation: _scaleController,
                        builder: (context, child) => Transform.scale(
                            scale: _scaleAnimation.value,
                            child: Center(
                              child: AnimatedBuilder(
                                animation: _widthController,
                                builder: (context, child) => Container(
                                  width: _widthAnimation.value,
                                  height: 80,
                                  padding: EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(50),
                                      color: Colors.grey.withOpacity(.3)),
                                  child: InkWell(
                                    onTap: () {
                                      _scaleController.forward();
                                    },
                                    child: Stack(children: <Widget>[
                                      AnimatedBuilder(
                                        animation: _positionController,
                                        builder: (context, child) => Positioned(
                                          left: _positionAnimation.value,
                                          child: AnimatedBuilder(
                                            animation: _scale2Controller,
                                            builder: (context, child) =>
                                                Transform.scale(
                                                    scale:
                                                        _scale2Animation.value,
                                                    child: Container(
                                                      width: 60,
                                                      height: 60,
                                                      decoration: BoxDecoration(
                                                        shape: BoxShape.circle,
                                                      ),
                                                      child: hideIcon == false
                                                          ? Icon(
                                                              Icons
                                                                  .fingerprint_rounded,
                                                              color:
                                                                  Colors.white,
                                                            )
                                                          : Container(),
                                                    )),
                                          ),
                                        ),
                                      ),
                                    ]),
                                  ),
                                ),
                              ),
                            )),
                      )),
                  SizedBox(
                    height: 60,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
