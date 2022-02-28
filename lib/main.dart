import 'package:dio/dio.dart';
import 'package:ecommmerce/cache/cachehelper.dart';
import 'package:ecommmerce/componts/applocal.dart';
import 'package:ecommmerce/componts/constant.dart';
import 'package:ecommmerce/cubit/cubit.dart';
import 'package:ecommmerce/cubit/status.dart';

import 'package:ecommmerce/network/remote.dart';
import 'package:ecommmerce/pages/home.dart';
import 'package:ecommmerce/pages/login.dart';
import 'package:ecommmerce/pages/slidpage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  DioHelper.inti();
  CachHelper.inti();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.orange,
      ),
      home: SildPage(),
      localizationsDelegates: [
        AppLocale.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate
      ],
      supportedLocales: [Locale("en", ""), Locale("ar", "")],
      localeResolutionCallback: (currentlang, supportlang) {
        if (currentlang != null) {
          for (Locale local in supportlang) {
            if (local.languageCode == currentlang.languageCode)
              return currentlang;
          }
        } else
          return supportlang.first;
      },
    );
  }
}
