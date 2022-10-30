import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_builder/responsive_builder.dart';


import '../Bloc/cubit.dart';
import '../Bloc/states.dart';
import '../components.dart';

class Business extends StatelessWidget {
  const Business({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit,NewsStates>(
    listener: (context,state){},
    builder: (context,state)
    {
      var listBusiness=NewsCubit.get(context).business;
      return ScreenTypeLayout(
        mobile: Builder(
          builder: (context) {
            NewsCubit.get(context).setDesktop(false);
            return articleBuilder(listBusiness);
          }
        ),
        desktop: Builder(
          builder: (context) {
            NewsCubit.get(context).setDesktop(true);
            return Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                    child: articleBuilder(listBusiness)
                ),
                if(listBusiness.length>0)
                Expanded(
                    child:  Container(
                      height: double.infinity,
                      color: Colors.grey[200],
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Text(
                            '${listBusiness[NewsCubit.get(context).selectbusinessItem]['description']}',
                        ),
                      ),
                    ),
                ),
              ],

            );
          }
        ),
        breakpoints: const ScreenBreakpoints(
           desktop: 600,
                tablet: 900,
          watch: 100,
        ),
      );
    },
    );
  }
}
