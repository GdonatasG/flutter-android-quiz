import 'Question.dart';

class QuizBrain {
  int _questionNumber = 0;
  int _rightAnswers = 0;

  List<Question> _listOfQuestions = [
    Question(
        question: 'You can lead a cow down stairs but not up stairs',
        answer: false),
    Question(
        question: 'Approximately one quarter of human bones are in the feet',
        answer: true),
    Question(question: 'A slug\'s blood is green', answer: true),
  ];

  void clearQuiz() {
    _questionNumber = 0;
    _rightAnswers = 0;
  }

  int getQuestionNumber() {
    return _questionNumber;
  }

  int getRightAnswers() {
    return _rightAnswers;
  }

  void answeredRight() {
    _rightAnswers++;
  }

  bool moreQuestionsLeft() {
    if (_questionNumber + 1 < _listOfQuestions.length) {
      return true;
    } else
      return false;
  }

  void goToNextQuestion() {
    _questionNumber++;
  }

  int getNumberOfTotalQuestions() {
    return _listOfQuestions.length;
  }

  String getCurrentQuestionTitle() {
    return _listOfQuestions[_questionNumber].question;
  }

  bool getCurrentQuestionAnswer() {
    return _listOfQuestions[_questionNumber].answer;
  }
}
