import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:part_time/cubit/job/states.dart';

class JobCubit extends Cubit<JobStates>{

  JobCubit() : super(JobInitialState());

  static JobCubit get(context) => BlocProvider.of(context);

  void PostJob(){


    emit(PostJobState());
  }
}