import 'package:flutter/material.dart';
import 'package:quiz/util/router_path.dart';

import '../model/question.dart';
import '../screen/dashboard.dart';
import '../screen/quiz_finish_screen.dart';
import '../screen/quiz_screen.dart';
import '../screen/splash_screen.dart';

class Routerr {
  static Route<dynamic>? generateRouter(RouteSettings settings) {
    switch (settings.name) {
      case SplashScreen:
        return MaterialPageRoute(
          builder: (BuildContext context) => SplashPage(),
        );
      case DashBoardScreen:
        return MaterialPageRoute(
          builder: (BuildContext context) => DashboardPage(),
        );
      case QuizScreen:
        Map<String, dynamic>? arguments = settings.arguments as Map<String, dynamic>?;
        if (arguments != null) {
          List<Question> difficult = arguments['difficult'] as List<Question>;
          List<Question> listQuestion = arguments['listQuestion'] as List<Question>;
          int id = arguments['id'] as int;

          return MaterialPageRoute(
            builder: (_) => QuizPage(
              difficult: difficult as String,
              listQuestion: listQuestion,
              id: id,key: UniqueKey()
            ),
          );
        }
        break;
      case QuizFinishScreen:
        String? title = settings.arguments as String?;
        if (title != null) {
          return MaterialPageRoute(
            builder: (_) => QuizFinishPage(
              title: title,
              answer: const {},
              listQuestion: [],
            ),
          );
        }
        break;
    }

    return null;
  }
}
