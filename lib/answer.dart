import 'package:cevapla/main.dart';
import 'package:cevapla/result.dart';
import 'package:flutter/material.dart';
import 'package:circular_countdown_timer/circular_countdown_timer.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: AnswerPage(),
    );
  }
}

class AnswerPage extends StatefulWidget {
  @override
  _AnswerPageState createState() => _AnswerPageState();
}

class _AnswerPageState extends State<AnswerPage> {
  CountDownController _controller = CountDownController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(0, 0, 32, 0.8),
      appBar: null,
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/bg.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: CircularCountDownTimer(
            width: MediaQuery.of(context).size.width / 2,
            height: MediaQuery.of(context).size.height / 2,
            duration: 5,
            fillColor: Colors.grey[800],
            color: Colors.white,
            controller: _controller,
            //timer arka plan
            strokeWidth: 5.0,
            strokeCap: StrokeCap.round,
            isTimerTextShown: true,
            isReverse: false,
            onComplete: () {
              var resultAnswer = new ResultAnswer();
              var answer = resultAnswer.getRandomAnswer();
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  // return object of type Dialog
                  return AlertDialog(
                    title: new Text("cevap'La bot:"),
                    content: new Text(answer),
                    actions: <Widget>[
                      // usually buttons at the bottom of the dialog
                      // ignore: deprecated_member_use
                      new FlatButton(
                        child: new Text("tekrar"),
                        textColor: Colors.white,
                        color: Colors.grey[800],
                        shape: RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(18.0),
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => HomePage()),
                          );
                        },
                      ),
                    ],
                  );
                },
              );
            },
            textStyle: TextStyle(fontSize: 50.0, color: Colors.grey[600]),
          ),
        ),
      ),
    );
  }
}
