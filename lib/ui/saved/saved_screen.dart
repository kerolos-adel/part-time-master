import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:part_time/constants/values/values.dart';
import 'package:part_time/cubit/explore/cubit.dart';
import 'package:part_time/cubit/explore/states.dart';
import 'package:part_time/shared/components/components.dart';
import 'package:part_time/shared/styles/colors.dart';

class SavedScreen extends StatefulWidget {
  const SavedScreen({super.key});

  @override
  State<SavedScreen> createState() => _SavedScreenState();
}

class _SavedScreenState extends State<SavedScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ExploreCubit, ExploreStates>(
        builder: (context, state){
          return Scaffold(
              backgroundColor: AppColors.backGround,
              body: Padding(
                padding: const EdgeInsets.all(12),
                child: ListView.separated(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder: (context, index){
                      if(jobs[index].isSaved == true) {
                        return ExploreJobsItemBuilder(jobs[index]);
                      }
                      return Container();
                    },
                    separatorBuilder: (context, index) => const SizedBox(height: 10,),
                    itemCount: jobs.length
                ),
              )
          );
        }
    );
  }
}
