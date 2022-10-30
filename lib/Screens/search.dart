import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/components.dart';

import '../Bloc/cubit.dart';
import '../Bloc/states.dart';


class Search extends StatelessWidget {
  var searchController = TextEditingController();

  Search({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit, NewsStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var listSearch = NewsCubit.get(context).search;
        return Scaffold(
          appBar: AppBar(),
          body: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(20),
                child: TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Search',
                    prefixIcon: Icon(Icons.search),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey),
                    ),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'please search';
                    }
                    return null;
                  },
                  keyboardType: TextInputType.text,
                  controller: searchController,
                  onChanged: ( value) {
                    NewsCubit.get(context).getSearch(value);
                  },
                ),
              ),
              Expanded(
                child: articleBuilder(listSearch, issearch: true),
              ),
            ],
          ),
        );
      },
    );
  }
}
