import 'package:enstaller/ui/screen/detail_screen.dart';
import 'package:enstaller/ui/screen/survey.dart';
import 'package:enstaller/ui/screen/update_status_screen.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch(settings.name){

      case DetailScreen.routeName:
        return PageTransition(
          child: DetailScreen(arguments: settings.arguments,),
          type: PageTransitionType.fade,
          settings: settings,

        );
        break;

      case UpdateStatusScreen.routeName:
        return PageTransition(
          child: UpdateStatusScreen(),
          type: PageTransitionType.fade,
          settings: settings,

        );
        break;
      case SurveyScreen.routeName:
        return PageTransition(
          child: SurveyScreen(arguments: settings.arguments,),
          type: PageTransitionType.fade,
          settings: settings,

        );
        break;


    }
    return null;
  }
}