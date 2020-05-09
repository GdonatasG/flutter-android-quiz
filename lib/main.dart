import 'package:flutter/material.dart';
import 'package:quizzler/QuizBrain.dart';

void main() => runApp(Quizzler());

class Quizzler extends StatelessWidget {
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

class QuizPage extends StatefulWidget {
  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  List<Icon> listOfUserAnswers = new List();
  QuizBrain quizBrain = QuizBrain();

  void checkAnswer(bool userChoice) {
    // This function checks answer of the question
    // Adds an Icon into user answers
    // Increases current number of the question

    setState(() {
      if (quizBrain.getCurrentQuestionAnswer() == userChoice) {
        quizBrain.answeredRight();
        listOfUserAnswers.add(Icon(
          Icons.done,
          color: Colors.green,
        ));
      } else {
        listOfUserAnswers.add(Icon(
          Icons.close,
          color: Colors.red,
        ));
      }
      if (quizBrain.moreQuestionsLeft()) {
        quizBrain.goToNextQuestion();
      } else {
        showQuizOverDialog(context);
      }
    });
  }

  void clearQuizCache() {
    setState(() {
      listOfUserAnswers = [];
      quizBrain.clearQuiz();
    });
  }

  showQuizOverDialog(BuildContext context) {
    // set up the buttons
    Widget closeBtn = FlatButton(
      child: Text("OK"),
      onPressed: () {
        // closing dialog
        Navigator.of(context).pop();
        // clearing Quiz
        clearQuizCache();
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Quizzler!"),
      content: Text(
          "Over! ${quizBrain.getRightAnswers()} out of ${quizBrain.getNumberOfTotalQuestions()} right answers."),
      actions: [
        closeBtn,
      ],
    );

    // show the dialog
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
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
                quizBrain.getCurrentQuestionTitle(),
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
            child: FlatButton(
              textColor: Colors.white,
              color: Colors.green,
              child: Text(
                'True',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                ),
              ),
              onPressed: () {
                //The user picked true.
                checkAnswer(true);
              },
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(15.0),
            child: FlatButton(
              color: Colors.red,
              child: Text(
                'False',
                style: TextStyle(
                  fontSize: 20.0,
                  color: Colors.white,
                ),
              ),
              onPressed: () {
                checkAnswer(false);
              },
            ),
          ),
        ),
        Row(
          children: listOfUserAnswers,
        ),
      ],
    );
  }
}

/*
question1: 'You can lead a cow down stairs but not up stairs.', false,
question2: 'Approximately one quarter of human bones are in the feet.', true,
question3: 'A slug\'s blood is green.', true,
*/
