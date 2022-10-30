import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'Bloc/cubit.dart';
import 'Bloc/states.dart';
import 'Screens/search.dart';


class NewsApp extends StatelessWidget {
  const NewsApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit, NewsStates>(
      listener: (BuildContext context, state) {},
      builder: (BuildContext context, state) {
        NewsCubit cubit = NewsCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: const Text('News App'),
            actions: [
              IconButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(
                    builder: (context)=>Search(),
                  ));
                },
                icon: const Icon(Icons.search),
              ),
              IconButton(
                onPressed: () {
                  cubit.changeThemeMode();
                },
                icon: const Icon(Icons.brightness_4_sharp),
              ),
            ],
          ),
          body: cubit.screens[cubit.currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: cubit.currentIndex,
            onTap: (index) {
              cubit.changeBtmNavBar(index);
            },
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.business),
                label: 'Business',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.sports),
                label: 'Sports',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.science),
                label: 'Science',
              ),
            ],
          ),
        );
      },
    );
  }
}
