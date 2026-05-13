import 'package:flutter/material.dart';
// import 'package:quizzler_flutter/question.dart';
import 'question_bank.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

void main() => runApp(Quizzler());

class Quizzler extends StatelessWidget {

  //PolyMorphism is this:
  //we inherits some things from a class but tha catch is:
  //we modifying those things, and first we start with the @override method
  //for example the build methode bellow we are modifying it with our own things
  //but still using the core function we integrated from their parent class "StatelessWidget"

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.grey.shade900,
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.0),
            child: QuizPage(),
          ),
        ),
      ),
    );
  }
}

//Inheritance is basically were we copy things from a different class
// and we do that by using "extends"
//and this called Inheritance
class QuizPage extends StatefulWidget {
  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {

  List <Icon> scoreKeeper = [];
  int nextQ = 0;
  questionBankList q = questionBankList();

  void checkAnsweer(bool userPickAnswer) {
    bool correctAnswer = q.getQuestionAnswer(nextQ);
    if (correctAnswer == userPickAnswer) {
      scoreKeeper.add(Icon(Icons.check, color: Colors.green,),);
      nextQ++;
    } else {
      scoreKeeper.add(Icon(Icons.close, color: Colors.red,),);
      nextQ++;
    }
  }

  void reStart() {
    if (nextQ == 11) {
      Alert(context: context, title: "Finish!", desc: "Click to Restart").show();
      nextQ = 0;
      scoreKeeper.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Expanded(
          flex: 5,
          child: Padding(
            padding: EdgeInsets.all(10.0),
            child: Center(
              child: Text(
                q.getQuestionText(nextQ),
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 25.0,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(15.0),
            child: TextButton(
              style: TextButton.styleFrom(backgroundColor: Colors.green),
                onPressed: () {
                  setState( () {
                    checkAnsweer(true);
                    reStart();
                  }
                  );
                },
                child: Text('True',
                style: TextStyle(color: Colors.white, fontSize: 20.0),
                ),
              ),
            ),
          ),

        Expanded(
          child: Padding(
            padding: EdgeInsets.all(15.0),
            child: TextButton(
              style: TextButton.styleFrom(backgroundColor: Colors.red),
              child: Text(
                'False',
                style: TextStyle(
                  fontSize: 20.0,
                  color: Colors.white,
                ),
              ),
              onPressed: () {
                setState( () {
                  checkAnsweer(false);
                  reStart();
                 }
                );
              },
            ),
          ),
        ),
        Row(
          children:
            scoreKeeper,
        )
      ],
    );
  }
}

/*
question1: 'You can lead a cow down stairs but not up stairs.', false,
question2: 'Approximately one quarter of human bones are in the feet.', true,
question3: 'A slug\'s blood is green.', true,
*/
