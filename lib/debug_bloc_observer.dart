import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/foundation.dart' as Foundation;

class DebugBlocObserver extends BlocObserver {
  @override
  void onEvent(Bloc bloc, Object? event) {
    if (Foundation.kDebugMode) {
      print(event);
    }
    super.onEvent(bloc, event);
  }

  @override
  void onChange(BlocBase bloc, Change change) {
    if (Foundation.kDebugMode) {
      print(change);
    }
    super.onChange(bloc, change);
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    if (Foundation.kDebugMode) {
      print(transition);
    }
    super.onTransition(bloc, transition);
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    if (Foundation.kDebugMode) {
      print('$error, $stackTrace');
    } else {
      // todo show error or send to crashlytics
    }
    super.onError(bloc, error, stackTrace);
  }
}
