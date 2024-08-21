import 'dart:async';

import 'package:fast_type/app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:talker_bloc_logger/talker_bloc_logger.dart';
import 'package:talker_flutter/talker_flutter.dart';

void main() {
  runZonedGuarded(() {
    final talker = TalkerFlutter.init();
    GetIt.I.registerSingleton<Talker>(talker);
    Bloc.observer = TalkerBlocObserver(talker: talker);
    runApp(const App());
  }, (error, stack) => GetIt.I<Talker>().handle(error, stack));
}
