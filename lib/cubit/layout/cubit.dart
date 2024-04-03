import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:part_time/cubit/layout/states.dart';
import 'package:part_time/ui/archived/archived_screen.dart';
import 'package:part_time/ui/explore/explore_client_screen.dart';
import 'package:part_time/ui/my_jobs/my_jobs_screen.dart';

class LayoutCubit extends Cubit<LayoutStates>{
  LayoutCubit(): super(LayoutInitialState());

  static LayoutCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;
  List<Widget>person_screens = [
    ExploreClientScreen(),
  ];
  List<Widget>company_screens = [
    const MyJobsScreen(),
    const ArchivedScreen(),
  ];
  void ChangeCurrentIndex(value){
    currentIndex = value;
    emit(LayoutChangeBNBIndexState());
  }
}