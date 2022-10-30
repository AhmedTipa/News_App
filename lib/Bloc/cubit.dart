// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/Bloc/states.dart';

import '../DioandCache/cachehelper.dart';
import '../DioandCache/diohelper.dart';
import '../Screens/business.dart';
import '../Screens/science.dart';
import '../Screens/settings.dart';
import '../Screens/sport.dart';

class NewsCubit extends Cubit<NewsStates> {
  NewsCubit() : super(NewsInitialState());

  static NewsCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;

  void changeBtmNavBar(index) {
    currentIndex = index;

    emit(NewsChangeBtmNavBarState());
  }

  List<Widget> screens = const [
    Business(),
    Sports(),
    Science(),
    Settings(),
  ];

  List<dynamic> business = [];
  //List<bool> businessSelectItem = [];
  int selectbusinessItem=0;
  bool isDesktop=false;

  void getBusiness() {
    emit(NewsGetBusinessLoadingState());
    DioHelper.getData(url: 'v2/top-headlines', query: {
      'country': 'eg',
      'category': 'business',
      'apiKey': '6d8fea7e1af641778a968ada90da6ce3',
    }).then((value) {
      business = value.data['articles'];
      // business.forEach((element) {
      //   businessSelectItem.add(false);
      // });
      print(business[1]['title']);
      emit(NewsGetBusinessSuccessState());
    }).catchError((error) {
      print('$error');
      emit(NewsGetBusinessErrorState(error));
    });
  }

  void selectBusinessItem(index) {
    selectbusinessItem=index;
    // for (int i = 0; i < businessSelectItem.length; i++) {
    //   if (i == index) {
    //     businessSelectItem[i] = true;
    //   } else {
    //     businessSelectItem[i] = false;
    //   }
    //}
    emit(NewsSelectBusinessItemState());
  }

  void setDesktop(bool value){
    isDesktop=value;
    emit(NewsSetDesktopState());


  }

  List<dynamic> sports = [];

  void getSports() {
    DioHelper.getData(url: 'v2/top-headlines', query: {
      'country': 'eg',
      'category': 'sports',
      'apiKey': '6d8fea7e1af641778a968ada90da6ce3',
    }).then((value) {
      sports = value.data['articles'];
      print(sports[1]['title']);
      emit(NewsGetSportsSuccessState());
    }).catchError((error) {
      print('$error');
      emit(NewsGetSportsErrorState(error));
    });
  }

  List<dynamic> science = [];

  void getScience() {
    DioHelper.getData(url: 'v2/top-headlines', query: {
      'country': 'eg',
      'category': 'science',
      'apiKey': '6d8fea7e1af641778a968ada90da6ce3',
    }).then((value) {
      science = value.data['articles'];
      print(science[1]['title']);
      emit(NewsGetScienceSuccessState());
    }).catchError((error) {
      print('$error');
      emit(NewsGetScienceErrorState(error));
    });
  }

  List<dynamic> search = [];

  void getSearch(String value) {
    DioHelper.getData(
            url: 'v2/everything',
            query: {'q': value, 'apiKey': '6d8fea7e1af641778a968ada90da6ce3'})
        .then((value) {
      search = value.data['articles'];
      print(search[1]['title']);
      emit(NewsGetSearchSuccessState());
    }).catchError((error) {
      print('$error');
      emit(NewsGetSearchErrorState(error));
    });
  }

  bool isDark = true;

  void changeThemeMode({bool? fromShared}) {
    if (fromShared != null) {
      fromShared = isDark;
      emit(NewsChangeThemeModeState());
    } else {
      isDark = !isDark;
      CacheHelper.setBoolean(key: 'isDark', value: isDark).then((value) {
        emit(NewsChangeThemeModeState());
      }).catchError((error) {
        print(error);
      });
    }
  }
}
