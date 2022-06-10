import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

import 'config/app.dart';
import 'config/bloc/bloc_observer.dart';
import 'injection_container.dart' as di;

Future<void> main() async => runZonedGuarded(
      () async {
        WidgetsFlutterBinding.ensureInitialized();
        await di.init();

        BlocOverrides.runZoned(() => runApp(const MyApp()),
            blocObserver: AppBlocObserver());
      },
      (error, StackTrace stackTrace) {
        log('Error: $error');
        log('StackTrace: $stackTrace');
      },
    );

