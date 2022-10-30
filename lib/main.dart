import 'dart:io';

import 'package:desktop_window/desktop_window.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


import 'Bloc/bloc_observer.dart';
import 'Bloc/cubit.dart';
import 'Bloc/states.dart';
import 'DioandCache/cachehelper.dart';
import 'DioandCache/diohelper.dart';
import 'news_app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); //الداله دي علشان ال main بتاخد async بتنفذ ال await وبعد كده بترن عادي
// if (Platform.isWindows) {
//   await DesktopWindow.setMinWindowSize(const Size(350, 650));
// }
  await CacheHelper.init();
  var isDark = CacheHelper.getBoolean(key: 'isDark');
  print(isDark);
  runApp(MyApp(isDark: isDark,));
  DioHelper.init();
   Bloc.observer= MyBlocObserver();

}

class MyApp extends StatelessWidget {
  final bool? isDark;

  MyApp({this.isDark});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => NewsCubit()
        ..getBusiness()
        ..getSports()
        ..getScience()
        ..changeThemeMode(
          fromShared: isDark,
        ),
      child: BlocConsumer<NewsCubit, NewsStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return MaterialApp(
            home: const NewsApp(),
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              appBarTheme: const AppBarTheme(
                backgroundColor: Colors.white,
                elevation: 0,
                iconTheme: IconThemeData(
                  color: Colors.black,
                ),
                titleTextStyle: TextStyle(
                  color: Colors.black,
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
                systemOverlayStyle: SystemUiOverlayStyle(
                  statusBarColor: Colors.white,
                  statusBarIconBrightness: Brightness.dark,
                ),
              ),
              scaffoldBackgroundColor: Colors.white, //لازم scaffold معاها
              bottomNavigationBarTheme: const BottomNavigationBarThemeData(
                  elevation: 20,
                  backgroundColor: Colors.white,
                  selectedItemColor: Colors.black,
                  unselectedItemColor: Colors.grey),
              textTheme: const TextTheme(
                bodyText1: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                ),
              ),
            ),
            darkTheme: ThemeData(
              appBarTheme: const AppBarTheme(
                backgroundColor: Colors.black12,
                elevation: 0,
                iconTheme: IconThemeData(
                  color: Colors.white,
                ),
                titleTextStyle: TextStyle(
                  color: Colors.white,
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
                systemOverlayStyle: SystemUiOverlayStyle(
                  statusBarColor: Colors.black12,
                  statusBarIconBrightness: Brightness.light,
                ),
              ),
              scaffoldBackgroundColor: Colors.grey.shade900,
              //لازم scaffold معاها
              bottomNavigationBarTheme: const BottomNavigationBarThemeData(
                  elevation: 20,
                  backgroundColor: Colors.black12,
                  selectedItemColor: Colors.blue,
                  unselectedItemColor: Colors.white),
              textTheme: const TextTheme(
                bodyText1: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                ),
              ),
            ),
            themeMode: NewsCubit.get(context).isDark
                ? ThemeMode.light
                : ThemeMode.dark,
          );
        },
      ),
    );
  }
}
