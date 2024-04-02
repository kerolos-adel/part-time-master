import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:part_time/cubit/explore/states.dart';

class ExploreCubit extends Cubit<ExploreStates>{
  ExploreCubit() : super(ExploreInitialState());

  static ExploreCubit get(context) => BlocProvider.of(context);

  var SearchController = TextEditingController();


}