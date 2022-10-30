import 'dart:io';

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:news_app/Bloc/cubit.dart';

import 'Screens/wep_view.dart';

Widget buildArticleItem(model, context, index) => Container(
      color:
          NewsCubit.get(context).selectbusinessItem==index && NewsCubit.get(context).isDesktop ? Colors.grey[200] : null,
      child: InkWell(
        onTap: () {
          NewsCubit.get(context).selectBusinessItem(index);
          if(Platform.isAndroid){
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => WebViewScreen(model['url'])));
          }


        },
        child: Padding(
          //لازم ال model قبل ال context

          padding: const EdgeInsets.all(15),

          child: Row(
            children: [
              Container(
                height: 120,
                width: 120,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  image: DecorationImage(
                    image: NetworkImage('${model['urlToImage']}'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              Expanded(
                child: Container(
                  height: 120,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Text('${model['title']}',
                            style: Theme.of(context).textTheme.bodyText1,
                            maxLines: 4,
                            overflow: TextOverflow.ellipsis),
                      ),
                      Text(
                        '${model['publishedAt']}',
                        style: const TextStyle(color: Colors.grey),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );

Widget articleBuilder(list, {issearch = false}) => ConditionalBuilder(
      condition: list.length > 0,
      builder: (context) => ListView.separated(
          physics: const BouncingScrollPhysics(),
          itemBuilder: (context, index) =>
              buildArticleItem(list[index], context, index),
          separatorBuilder: (context, index) => Padding(
                padding: const EdgeInsets.all(15),
                child: Container(
                  color: Colors.blueGrey,
                  height: 1,
                ),
              ),
          itemCount: list.length),
      fallback: (context) => issearch
          ? Container()
          : const Center(child: CircularProgressIndicator()),
    );
