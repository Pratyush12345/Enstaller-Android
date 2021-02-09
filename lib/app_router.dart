import 'package:enstaller/ui/screen/detail_screen.dart';
import 'package:enstaller/ui/screen/survey.dart';
import 'package:enstaller/ui/screen/update_status_screen.dart';
import 'package:enstaller/ui/util/onchangeyesnoprovider.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case DetailScreen.routeName:
        return PageTransition(
          child: DetailScreen(
            arguments: settings.arguments,
          ),
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
          child: ChangeNotifierProvider(
              create: (ctx) => OnChangeYesNo(),
              child: SurveyScreen(
                arguments: settings.arguments,
              )),
          type: PageTransitionType.fade,
          settings: settings,
        );
        break;
    }
    return null;
  }
}
