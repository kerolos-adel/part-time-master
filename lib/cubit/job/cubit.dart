import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:part_time/cubit/job/states.dart';
import 'package:part_time/cubit/user/cubit.dart';
import 'package:part_time/models/company/company_model.dart';
import 'package:part_time/models/job/job_model.dart';
import 'package:part_time/network/database.dart';

class JobCubit extends Cubit<JobStates> {
  JobCubit() : super(JobInitialState());

  static JobCubit get(context) => BlocProvider.of(context);

  List<Job> myJobs = [];

  final TextEditingController JobCategoryController = TextEditingController();
  final TextEditingController JobTitleController = TextEditingController();
  final TextEditingController JobDescriptionController =
      TextEditingController();
  final TextEditingController JobAgeFromController = TextEditingController();
  final TextEditingController JobAgeToController = TextEditingController();
  final TextEditingController JobRequirementsController =
      TextEditingController();
  final TextEditingController JobApplyLinkController = TextEditingController();
  DateTime? picked;
  final TextEditingController JobDeadlineController =
      TextEditingController(text: 'Deadline Date');
  void pickDateDialog(context) async {
    picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime.now().subtract(
          Duration(days: 0),
        ),
        lastDate: DateTime(2100));
    if (picked != null) {
      JobDeadlineController.text =
          '${picked!.year} - ${picked!.month} - ${picked!.day}';
    }
    emit(PickDeadlineState());
  }

  Future PostJob(context) async {
    await NetworkDatabase.PostJob(
        context: context,
        title: JobTitleController.text,
        location: "Kuwait",
        description: JobDescriptionController.text,
        requirements: JobRequirementsController.text,
        applyLink: JobApplyLinkController.text,
        companyId: UserCubit.get(context).myUser.id,
        ageFrom: JobAgeFromController.text,
        ageTo: JobAgeToController.text);
    emit(PostJobState());
  }

  Future GetMyJobs(context) async {
    myJobs.clear();
    var result = await NetworkDatabase.GetMyJobs(context: context);
    List<dynamic> jobsJson = result["_embedded"]["jobs"] as List<dynamic>;
    for(int i=0;i<jobsJson.length;i++){
      dynamic element = jobsJson[i];
      await GetJobCompanyData(context, element["id"]).then((value){
        myJobs.add(Job.FromJson(element, value));
      });
    }
    emit(GetMyJobsState());
  }

  Future GetAllJobs (context) async {
    myJobs.clear();
    var result = await NetworkDatabase.GetAllJobs(context: context);
    List<dynamic> jobsJson = result["_embedded"]["jobs"] as List<dynamic>;
    for(int i=0;i<jobsJson.length;i++){
      dynamic element = jobsJson[i];
      await GetJobCompanyData(context, element["id"]).then((value){
        myJobs.add(Job.FromJson(element, value));
      });
    }
    emit(GetAllJobsState());
  }

  Future GetJobCompanyData(context, jobID) async {
    var result = await NetworkDatabase.GetJobCompany(
        context: context, id: jobID);
    print(result.toString());

    return Company.FromJson(result);
  }
}
